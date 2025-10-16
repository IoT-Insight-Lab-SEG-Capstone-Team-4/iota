#!/bin/bash

#############################################
# Router Firmware VM Setup Script
# Author: vian21
# Date: 2025-10-15
# Description: Downloads router firmware and creates VMs using virt-manager
#############################################

set -u
set -o pipefail

# Color codes for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly FIRMWARE_DIR="$SCRIPT_DIR/firmware"
readonly FIRMWARE_URL_FILE="$SCRIPT_DIR/firmware_urls.txt"
readonly VM_BASE_DIR="$SCRIPT_DIR/router_vms"
readonly MEMORY=512
readonly VCPUS=2
readonly DISK_SIZE=2

# Logging function
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1" >&2
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Check if running as root for VM operations
check_requirements() {
    log_info "Checking system requirements..."
    
    # Check for required tools
    local required_tools=("virsh" "virt-install" "wget" "qemu-img" "unzip" "gunzip")
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            log_error "$tool is not installed. Please install libvirt, virt-manager, qemu, unzip, and gzip."
            exit 1
        fi
    done
    
    # Check if libvirtd is running
    if ! systemctl is-active --quiet libvirtd; then
        log_warn "libvirtd is not running. Attempting to start..."
        sudo systemctl start libvirtd || {
            log_error "Failed to start libvirtd"
            exit 1
        }
    fi
    
    log_info "All requirements satisfied."
}

# Create firmware directory
create_firmware_dir() {
    if [ ! -d "$FIRMWARE_DIR" ]; then
        log_info "Creating firmware directory: $FIRMWARE_DIR"
        mkdir -p "$FIRMWARE_DIR"
    else
        log_info "Firmware directory already exists: $FIRMWARE_DIR"
    fi
}

# Create VM base directory
create_vm_dir() {
    if [ ! -d "$VM_BASE_DIR" ]; then
        log_info "Creating VM base directory: $VM_BASE_DIR"
        mkdir -p "$VM_BASE_DIR"
    fi
}

# Function to download firmware
download_firmware() {
    local firmware_name="$1"
    local firmware_url="$2"
    local output_file="$FIRMWARE_DIR/$firmware_name"
    
    if [ -f "$output_file" ]; then
        log_info "Firmware already downloaded: $firmware_name"
        return 0
    fi
    
    log_info "Downloading firmware: $firmware_name"
    
    if [ -n "$firmware_url" ] && [ "$firmware_url" != "N/A" ]; then
        if ! wget -c -O "$output_file" "$firmware_url"; then
            log_warn "Failed to download $firmware_name from $firmware_url"
            rm -f "$output_file"
            touch "$output_file"
            echo "PLACEHOLDER - URL: $firmware_url" > "$output_file"
            return 1
        fi
    else
        log_warn "No valid URL for $firmware_name. Creating placeholder."
        touch "$output_file"
        echo "PLACEHOLDER - No URL available" > "$output_file"
        return 1
    fi
}

extract_firmware() {
    local firmware_file="$1"
    local firmware_path="$FIRMWARE_DIR/$firmware_file"
    local base_name="$firmware_file"
    
    # Strip extensions to get base name
    base_name="${base_name%.zip}"
    base_name="${base_name%.gz}"
    base_name="${base_name%.img}"
    
    local extract_dir="$FIRMWARE_DIR/$base_name"
    local target_img="$FIRMWARE_DIR/${base_name}.img"
    
    if [ ! -f "$firmware_path" ] || grep -q "PLACEHOLDER" "$firmware_path" 2>/dev/null; then
        log_warn "Firmware file not available: $firmware_file"
        return 1
    fi
    
    if [[ "$firmware_file" == *.gz ]]; then
        if [ -f "$target_img" ]; then
            log_info "Firmware already extracted: $base_name.img"
            echo "$target_img"
            return 0
        fi
        
        log_info "Extracting $firmware_file..."
        if ! gunzip -c "$firmware_path" > "$target_img"; then
            log_warn "Failed to extract $firmware_file"
            rm -f "$target_img"
            return 1
        fi
        
        echo "$target_img"
        return 0
    elif [[ "$firmware_file" == *.zip ]]; then
        if [ -f "$target_img" ]; then
            log_info "Firmware already extracted: $base_name.img"
            echo "$target_img"
            return 0
        fi
        
        log_info "Extracting $firmware_file..."
        mkdir -p "$extract_dir"
        if ! unzip -q "$firmware_path" -d "$extract_dir"; then
            log_warn "Failed to extract $firmware_file"
            rm -rf "$extract_dir"
            return 1
        fi
        
        local img_file=$(find "$extract_dir" -type f -name "*.img" | head -n 1)
        if [ -n "$img_file" ]; then
            log_info "Found image file: $(basename "$img_file"), renaming to $base_name.img"
            mv "$img_file" "$target_img"
            rm -rf "$extract_dir"
            echo "$target_img"
            return 0
        else
            log_warn "No .img file found in extracted archive"
            rm -rf "$extract_dir"
            return 1
        fi
    elif [[ "$firmware_file" == *.img ]]; then
        echo "$firmware_path"
        return 0
    else
        log_warn "Unsupported firmware format: $firmware_file (only .zip, .img, and .gz supported)"
        return 1
    fi
}

convert_to_qcow2() {
    local source_img="$1"
    local vm_name="$2"
    local qcow2_path="$VM_BASE_DIR/${vm_name}.qcow2"
    
    if [ ! -f "$source_img" ]; then
        log_error "Source image not found: $source_img"
        return 1
    fi
    
    if [ -f "$qcow2_path" ]; then
        log_info "QCOW2 image already exists: $qcow2_path"
        echo "$qcow2_path"
        return 0
    fi
    
    log_info "Converting $source_img to QCOW2 format..."
    if ! qemu-img convert -f raw -O qcow2 "$source_img" "$qcow2_path" 2>/dev/null; then
        log_error "Failed to convert image to QCOW2"
        rm -f "$qcow2_path"
        return 1
    fi
    
    log_info "Resizing disk to ${DISK_SIZE}G..."
    if ! qemu-img resize "$qcow2_path" "${DISK_SIZE}G" >/dev/null 2>&1; then
        log_warn "Failed to resize disk, continuing with original size"
    fi
    
    echo "$qcow2_path"
    return 0
}

# Check if VM exists
vm_exists() {
    local vm_name="$1"
    virsh list --all | grep -q "$vm_name"
}

# Create virtual machine
create_vm() {
    local vm_name="$1"
    local firmware_file="$2"
    
    if vm_exists "$vm_name"; then
        log_info "VM already exists: $vm_name"
        return 0
    fi
    
    log_info "Creating VM: $vm_name"
    
    local img_file
    img_file=$(extract_firmware "$firmware_file")
    local extract_result=$?
    
    if [ $extract_result -ne 0 ] || [ -z "$img_file" ]; then
        log_warn "Skipping VM creation for $vm_name - firmware extraction failed"
        return 1
    fi
    
    local disk_path
    disk_path=$(convert_to_qcow2 "$img_file" "$vm_name")
    local convert_result=$?
    
    if [ $convert_result -ne 0 ] || [ -z "$disk_path" ]; then
        log_warn "Skipping VM creation for $vm_name - image conversion failed"
        return 1
    fi
    
    log_info "Creating VM with disk: $disk_path"
    
    sudo virt-install \
        --name "$vm_name" \
        --memory $MEMORY \
        --vcpus $VCPUS \
        --cpu host-passthrough \
        --disk "path=$disk_path,format=qcow2,bus=virtio,cache=none" \
        --network bridge=virbr0,model=virtio \
        --rng /dev/urandom \
        --graphics vnc,listen=0.0.0.0 \
        --noautoconsole \
        --os-variant generic \
        --import || {
            log_warn "VM creation had issues for $vm_name, but continuing..."
            return 1
        }
    
    echo "$firmware_file" > "$VM_BASE_DIR/${vm_name}.firmware"
    
    log_info "VM created successfully: $vm_name (IP will be assigned via DHCP)"
    return 0
}

# Configure network bridge (optional - for better network access)
configure_network() {
    log_info "Checking network configuration..."
    
    # Check if default network is active
    if ! virsh net-list --all | grep -q "default.*active"; then
        log_warn "Default network not active. Starting it..."
        sudo virsh net-start default || log_warn "Could not start default network"
    fi
}

load_firmware_urls() {
    log_info "Loading firmware URLs from $FIRMWARE_URL_FILE..."
    
    if [ ! -f "$FIRMWARE_URL_FILE" ]; then
        log_error "Firmware URL file not found: $FIRMWARE_URL_FILE"
        exit 1
    fi
    
    declare -gA FIRMWARE_LIST
    
    while IFS='|' read -r firmware_name firmware_url || [ -n "$firmware_name" ]; do
        if [[ -z "$firmware_name" || "$firmware_name" =~ ^[[:space:]]*# ]]; then
            continue
        fi
        
        firmware_name=$(echo "$firmware_name" | xargs)
        firmware_url=$(echo "$firmware_url" | xargs)
        
        if [ -n "$firmware_name" ]; then
            FIRMWARE_LIST["$firmware_name"]="$firmware_url"
            log_info "Loaded: $firmware_name -> $firmware_url"
        fi
    done < "$FIRMWARE_URL_FILE"
    
    if [ ${#FIRMWARE_LIST[@]} -eq 0 ]; then
        log_error "No firmware entries found in $FIRMWARE_URL_FILE"
        exit 1
    fi
    
    log_info "Loaded ${#FIRMWARE_LIST[@]} firmware entries"
}

process_firmware_and_vms() {
    for firmware_name in "${!FIRMWARE_LIST[@]}"; do
        local firmware_url="${FIRMWARE_LIST[$firmware_name]}"
        local vm_name="${firmware_name%%.*}"
        
        download_firmware "$firmware_name" "$firmware_url"
        
        create_vm "$vm_name" "$firmware_name"
    done
}

main() {
    echo "================================================"
    echo "Router Firmware VM Setup Script"
    echo "User: vian21"
    echo "Date: $(date)"
    echo "================================================"
    echo ""
    
    check_requirements
    load_firmware_urls
    create_firmware_dir
    create_vm_dir
    configure_network
    process_firmware_and_vms
    
    echo ""
    log_info "Setup complete!"
    log_info "Firmware stored in: $FIRMWARE_DIR"
    log_info "VMs created in: $VM_BASE_DIR"
}

# Run main function
main
