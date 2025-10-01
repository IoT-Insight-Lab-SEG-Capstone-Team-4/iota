# Requirements

| #   | Requirement                                                                                                   | Type       | Dependency |
| --- | ------------------------------------------------------------------------------------------------------------- | ---------- | ---------- |
| 1   | The system shall provide an environment for physical and simulated IoT devices to interact.                   | Functional |            |
| 2   | The system shall generate data representing normal behavior of IoT devices.                                   | Functional |            |
| 3   | The system shall generate data representing behavior during attacks.                                          | Functional |            |
| 4   | The system shall collect sensor data from IoT devices.                                                        | Functional |            |
| 5   | The system shall collect network traffic data.                                                                | Functional |            |
| 6   | The system shall collect IDS logs.                                                                            | Functional |            |
| 7   | The system shall store collected data.                                                                        | Functional | 4,5,6      |
| 8   | The system shall allow injection of attacks on IoT devices.                                                   | Functional |            |
| 9   | The system shall evaluate logs after attack injection.                                                        | Functional | 6,8        |
| 10  | The system shall provide a dashboard for data visualization.                                                  | Functional | 7          |
| 11  | The system shall use AI/ML integration for data analysis.                                                     | Functional | 7          |
| 12  | The system shall detect malicious or vulnerable devices.                                                      | Functional | 11         |
| 13  | The system shall support multiple IoT protocols including Thread, UART, Bluetooth, WiFi, Z-wave, and LoRaWAN. | Functional |            |
| 14  | The system shall collect data from at least 3-5 devices per supported protocol.                               | Functional | 13         |
| 15  | The system shall collect health packets from IoT devices.                                                     | Functional |            |
| 16  | The system shall perform port scans on IoT devices.                                                           | Functional |            |
| 18  | The system shall collect PCAP files for network traffic.                                                      | Functional | 5          |
| 19  | The system shall support MQTT messaging between IoT devices.                                                  | Functional |            |
| 20  | The system shall include a firewall between attackers and the network.                                        | Functional | 8          |
