# 📒 Meeting Client Notes

## Description

This file contains all the meeting notes taken during our biweekly meetings with the client.

---

### 10th September 2025

-   Met the client and discussed the project, initial set of requirements and scope.
-   Client's requests:
    -   Develop an environment where **physical/simulated** IoT devices can interact with each other.
    -   Generate 2 types of data: normal/benign behaviour and behaviour during attacks.
    -   Collect and store data such as sensor data, network traffic, and IDS logs.
    -   Inject attacks on the devices and evaluate logs.
    -   Visualize the data through a dashboard (Kibana style).
    -   If the time permits, integrate AI/ML to analyze de data, detect malicious/vulnerable devices.
-   Suggestions:
    -   Research vulnerable devices to inject attacks.
    -   Use Zeek or Suricata as a monitoring tool.
    -   Work in the research lab (an orientation and access form has been provided for us to fill out).
-   Currently awaiting access to the research lab.
-   An email has been sent to client to organize future meetings (to be held every 2 weeks).

---

### 24th September 2025

-   Met the client on teams and discussed the architecture.
-   Client provided feedback on the architecture diagram and suggested improvements.
-   David got the IoT devices and 18 ESP32 kits.

#### Frontend

-   Client prefers that we use Kibana or Grafana.

#### Backend

-   To be built in TypeScript (with Zod validation) or Python - No preferences for now.

#### Database Server

-   Client will ask IT whether we can use the CPU server in lab (STE 4009) as our backend server.
-   Client mentions that we should be able to query by features (to ask more details).

#### Attackers

-   Client will talk more about this later, keep in mind that we need firewall.

#### TODO

1. **Update Architecture Diagram**

    - Need to update architecture diagram to include the internet, assign IP address, DHCP server, missing internet part, how the attacker is connected to the Serial Node, Physical Network Devices, VMM (edge devices), Virtual layer (LoRaWAN).

2. **List of IoT Devices, Types of Data Collected, Protocol**

    - Make a list/table of the 20 IoT devices we will use for the different protocols and explain the strategy (e.g., most frequently used IoT devices used in North America, more complex one like camera, cheaper devices, more prone for attacks) behind the 20 devices we're going to choose (3-5 IoT devices per protocol).
    - Have around 3-5 devices per protocol:
        1. Thread
        2. UART
        3. Bluetooth
        4. WiFi
        5. Z-wave
        6. LoRaWAN
    - More devices: Google Nest, smart speakers
    - Type of data collected: Collect as much data as possible and research for frequency of how often we collect PCAP files, timestamp, sensor reading, network traffic data, sensor data, health, latency for each IoT devices.
    - Data being collected: PING, Port scan, Health packets sent to the cloud. Some IoT devices send periodically health packets through the internet.
    - Can Wireshark handle all network traffic data? Should we have it individually collect network traffic.
    - IoT devices messaging each other MQTT.
    - More health stuff = Port scan, communicating with the cloud? To research more on that.
    - May be add a firewall in between attacker and network.

3. **Research Topics**
    - There are additional protocols related to IoT devices: Zigbee (can ignore cuz old), z-wave, thread (combination of different protocols). Through analysis. (To do research on these different protocols and choose the IoT devices).
    - Research about using firewall between our IoT devices and attackers.
    - MQTT
    - LoRaWAN/LoRaWAN
    - Thread protocol
    - Z-wave
    - Optimal PCAP collection time for IoT

---

### 8th October 2025

#### Overview
This meeting focused on refining the architecture and device inventory.  
The client provided feedback regarding additional details, prioritization, and vulnerability tracking.

#### Client Requests & Updates

1. **Device Inventory Table**
Add the following new columns:
- **Usage Type:**  
  Indicate whether the item is for development or for usage.
- **Priority / Importance:**  
  Define how critical each item is to the current phase (e.g., *high*, *medium*, *low*).
- **CVE / Vulnerability:**  
  Include known vulnerabilities (based on CVE database lookups) for each device.

2. **Architecture Diagram**
- **Expand the Virtual Module:**  
  Add more detail regarding simulated devices and their data flow.  
- **Clarify Router/Switch Connections:**  
  Specify whether links are LAN or WLAN.  
- **Confirm IoT Server vs IoT Hub:**  
  Verify which term applies and update the diagram accordingly.

3. **Research Tasks**
- Investigate Home Assistant as a possible environment for simulating IoT devices.  
- Explore smart locks as example IoT devices for integration.  
- Gather data from CVE databases to identify vulnerabilities in devices used.

4. **Infrastructure Notes**
- A desktop computer in the lab may be available to serve as a local IoT server (pending confirmation).  
- Team will receive permissions to access the uOttawa router/server for experimentation (confirmation pending).


