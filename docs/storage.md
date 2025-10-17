# Storage Research

## 📊 Data Description

The goal of this project is to collect as much data as possible from the IoT devices. We are aiming to gather similar data types found in *CIC IoT-IDAD Dataset 2024* (http://cicresearch.ca/IOTDataset/CIC%20IoT-IDAD%20Dataset%202024/Dataset/). The information we want to store includes the following: 

1. Device id/type (e.g., MH-Z19B, BH1750, BME680)
2. Timestamp (ex: DD/MM/YYYY HH:MM:SS AM/PM)
3. Active status (on/off)
4. Protocol being used (e.g., MQTT, Zigbee, Thread)
5. Source/Destination IP address
6. Source/Destination MAC address
7. Source/Destination Port
8. Temperature (°C)
9. Humidity (%RH)
10. Pressure (hPa)
12. Light intensity (lx)
13. Gas (kΩ)
14. CO2 levels (ppm)
15. Network traffic (PCAP files)

*Screenshot from Anomaly_Detection_-_Flow_Based_features > BenignTraffic.pcap_Flow.csv*

The data should be formatted in a structured way, meaning it is organized in a clear, predefined format with tables and rows. Each column represents a specific variable, while each row represents a single reading or event. In the context of IoT analytics, structured data is ideal because it is easy to query, analyze for trends, visualize, and store efficiently as time-series data.

However, PCAP files are naturally unstructured since they contain raw packets, each with its own headers and payloads. According to ChatGPT, relevant fields can be extracted from these packets and stored in a structured format. This can be achieved using tools such as Wireshark or Tshark, which can export PCAP data to CSV or JSON formats with the following command:
*tshark -r file.pcap -T fields -e frame.time -e ip.src -e ip.dst -e tcp.srcport -e tcp.dstport -e _ws.col.Protocol -E header=y -E separator=,*

---

## ✅ Storage Solution

| Storage Type | Pros | Cons |
|---------------|------|------|
| **SQL** | - Strong consistency (ACID) <br> - Mature tools and ecosystem <br> - Great for structured, relational data <br> - Great for metadata, configs, and control data | - Horizontal scaling difficulties <br> - Slow for massive data ingestion <br> - Rigid schema <br> - Poor native support for time-series analytics |
| **NoSQL** | - Flexible schema <br> - Scales horizontally <br> - Fast, simple read/writes <br> - Ideal for unstructured or JSON data | - Weak support for complex queries/joins <br> - Limited time-series features <br> - Eventual (not strict) consistency <br> - May require data duplication |
| **Time-Series** | - Optimized for sensor/time data <br> - Very high ingestion speed <br> - Built-in time-based queries, aggregation, and retention policies <br> - Efficient storage via compression | - Limited for general-purpose data <br> - Weaker join capabilities <br> - May require another DB for metadata <br> - Less mature ecosystem than SQL |
| **Object Storage** | - Great for raw/unstructured IoT data <br> - Scales easily to store high volumes of IoT data <br> - Can store PCAP/JSON/images/logs | - Slower access compared to databases <br> - Not ideal for real-time queries or analytics <br> - No built-in schema/query support |

---

## 🔎 Recommendation Based on Research and Scope of the Project

In the context of our project, we concluded that a time-series database is the most suitable option based on our research. According to the article *“How to Choose an IoT Database”* by the Timescale Team ([Timescale, 2024](https://www.tigerdata.com/learn/how-to-choose-an-iot-database)), time-series databases “are often the best fit for IoT applications.” Since this project involves storing and analyzing sensor data streams and examining IoT trends, a time-series database aligns perfectly with these typical use cases. Additionally, the collected data can be easily exported to CSV format.