# SEG4910-4911-capstone

# IoT Security and Analytics Platform

## 📖 Project Overview
This project aims to create an experimental IoT environment, both physical and simulated, where IoT devices can interact under normal operation as well as under attack scenarios.  
The generated dataset will include:
- Sensor readings  
- Network traffic logs  
- IDS (Intrusion Detection System) alerts  

A **Kibana-style dashboard** will be developed to visualize the data. Depending on progress, the project will also explore **ML/AI models** for anomaly detection and predictive analytics.

---

## 👥 Team Members and Roles
- **Adam (Team Lead & Backend Engineer):** Coordination, backend services, data pipeline design, IoT lab integration.  
- **Member 2 (IoT Specialist):** IoT device setup, firmware research, sensor/actuator configuration.  
- **Member 3 (Data Engineer):** Dataset curation, log collection, preprocessing for analytics.  
- **Member 4 (Dashboard Developer):** Kibana-style dashboard implementation and visualization.  
- **Member 5 (ML/AI Engineer – optional):** Anomaly detection and predictive analytics (if scope allows).  

---

## 🎯 Objectives
### Benefit to Customer
- Provide a **realistic IoT testing environment** for security research.  
- Enable the **collection of datasets** covering normal operation and attack scenarios.  
- Offer a **real-time visualization dashboard** for monitoring IoT system health and security.  

### Key Accomplishments
- Functional IoT testbed with physical and simulated devices.  
- Automated log collection for **sensor data, network activity, and IDS alerts**.  
- A dashboard capable of visualizing and filtering logs.  
- (Optional) ML/AI models for anomaly detection.  

### Criteria for Success
- Simulate normal IoT operations and at least one attack scenario.  
- Generate and store logs in a structured, queryable format.  
- Deliver a working dashboard with meaningful visualizations.  
- Provide documentation for dataset reproducibility.  

---

## 🏗️ Anticipated Architecture

IoT Devices (Physical + Simulated)
│
▼
Network Layer (Routers, IDS - Snort/Suricata, Packet Capture)
│
▼
Data Collection Layer (Logstash, Aggregators, DB - Elasticsearch/InfluxDB)
│
▼
Visualization Layer (Kibana / Grafana Dashboard)
│
▼
Analytics Layer (ML/AI models for anomaly detection - optional)


---

## ⚠️ Anticipated Risks
- **Engineering Challenges**
  - Setting up vulnerable firmware versions on IoT devices.  
  - Synchronizing log collection across heterogeneous sources.  
  - Ensuring dashboard performance with large log datasets.  
- **Time Constraints**
  - Limited project time may restrict ML/AI integration.  
- **Dependencies**
  - Access to IoT lab, certification requirements, and hardware availability.  

---

## ⚖️ Legal and Social Issues
- **Data Privacy:** Ensure no personal/sensitive data is collected.  
- **Responsible Use:** Data is strictly for **academic and security research purposes**.  
- **Ethical Considerations:** Attacks are conducted in a **sandboxed, controlled environment** to prevent unintended harm.  

---

## 🚀 Initial Plans (First Release)
1. **Tool Setup**
   - GitHub repository, documentation wiki, CI/CD pipeline.  
   - Configure ELK stack (Elasticsearch, Logstash, Kibana) or Grafana.  

2. **Environment Prep**
   - Secure lab access (credentials, certification).  
   - Identify IoT devices and vulnerable firmware.  

3. **First Release Deliverables**
   - Minimal IoT environment with 1–2 devices.  
   - Log collection from normal operations.  
   - Basic dashboard showing sensor data in real time.  

---
