# Router Firmware VM Testing Environment

This setup creates virtual machines for testing router firmware vulnerabilities using virt-manager/libvirt.

## Prerequisites

```bash
# For Debian/Ubuntu
sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

# For Fedora/RHEL
sudo dnf install qemu-kvm libvirt virt-install virt-manager

# For Arch Linux
sudo pacman -S qemu libvirt virt-manager
```

### Adding VM images

-   You can add `.zip` or '.img' url in [firmware_urls.txt](firmware_urls.txt)
-   Zip files will be automatically unzipped and `.img` converted to `.qcow2` which is VM friendly

### Setup and Running

-   You can download and add all VM by running:

```sh
sudo ./setup_vms.sh
```

-   This will check the firmware list and check which ones have not being downloaded and installed.
-   You can run this command as many times as you want. There will be no duplicates.

### Managing VMs

-   You can list, start, stop, delete VM using:

```sh
sudo ./vm_manager
```
