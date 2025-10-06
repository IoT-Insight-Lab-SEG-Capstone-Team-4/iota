# 📒 Meeting Team Notes

## Description

This file contains all the meeting notes taken during our team meetings.\*\*.

---

### 12th September 2025

-   Discussed the architecture to be presented to the client in the next meeting.
-   Patrick will prepare a clearer architecture plan.
-   Decided on project management tools:
    -   We will use **IoT Insight Tracker** on GitHub as our project management tool.
    -   Karen will create a `docs` (wiki) folder on GitHub to contain all our notes and documents.
-   Agreed to request a **laptop requisition** from the client in the next meeting, which will act as our server.
-   Decided to name our project **iota**.

### 16th September 2025

-   Reviewed the architecture plan, discussed in details the different part of the architecture (IoT devices, server, database, preferred scenario, UI and how to connect all of them trough API calls).
-   Patrick added all these details in the architecture.md file.
-   We will meet tomorrow (17th September 2025) to access the lab and check the IoT devices available.
-   Since the client is not available tomorrow, we will send an email with a link to the architecture.md file and ask for feedback.
-   We can potentially work in parallel on different parts of the project (frontend using dummy data, backend using mock APIs & setting up the IoT devices) once the architecture is validated.

### 3rd October 2025

-   Updated the architecture plan as requested by the client in the previous meeting.
-   Added details to the diagram, including:
    -   **Communication protocols**
    -   **Required devices**
    -   A **color key** for each device category (Sensor, Router, ESP32, nRF52840, EFR32xG24)
-   We concluded that we currently lack the required devices for some protocols:
    -   **LoRaWAN, Z-Wave, Zigbee** (critical)
    -   **Thread** which is missing one IoT device nRF52840 (less urgent)
-   We will ask the client to provide the missing devices.
-   We divided the tasks between us according to the architecture. This is the list of responsibilities:
    <div align="center">

| Team Member | Responsibility           |
| ----------- | ------------------------ |
| **Adam**    | MQTT protocol            |
| **Hiba**    | Thread protocol          |
| **Karen**   | Zigbee protocol          |
| **Patrick** | Virtual model            |
| **David**   | Backend & storage server |

</div>
