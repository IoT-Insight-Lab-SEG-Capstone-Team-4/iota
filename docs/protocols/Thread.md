# Thread Protocol

## Introduction

Thread is an IPv6-based, low-power mesh networking protocol for IoT devices in smart homes and building automation. It enables interoperable communication across manufacturers, building on IEEE 802.15.4 and 6LoWPAN for reliable, secure connectivity.

Formed in 2014 by the Thread Group (initially Nest Labs, Samsung, ARM; now including Apple, Amazon, IKEA), it supports Matter integration and operates in the 2.4 GHz band for low-power, scalable networks up to thousands of nodes.

## Core Concepts

### Mesh Networking

Thread uses a self-forming, self-healing mesh where devices relay messages to extend range and reliability. It supports up to 32 active routers for multi-hop routing.

```mermaid
graph TD
    A[Border Router] --> B[Router]
    A --> C[Router]
    A --> H[Router]
    B --> D[End Device]
    B --> E[End Device]
    C --> F[End Device]
    H --> G[End Device]
```

## Architecture

Thread's IP-based stack includes:

```mermaid
graph TD
    subgraph TPS ["Thread Protocol Stack"]
        A["Application Layer"]
        T["Transport Layer (UDP/TCP)"]
        I["Internet Layer (IPv6)"]
        D["Adaptation Layer (6LoWPAN)"]
        M["MAC Layer (IEEE 802.15.4)"]
        P["PHY Layer (IEEE 802.15.4)"]
    end

    A <--> T
    T <--> I
    I <--> D
    D <--> M
    M <--> P

    style A fill:#3675B2,color:white,stroke:#2d639e,stroke-width:2px
    style T fill:#3675B2,color:white,stroke:#2d639e,stroke-width:2px
    style I fill:#3675B2,color:white,stroke:#2d639e,stroke-width:2px
    style D fill:#3675B2,color:white,stroke:#2d639e,stroke-width:2px
    style M fill:#3675B2,color:white,stroke:#2d639e,stroke-width:2px
    style P fill:#3675B2,color:white,stroke:#2d639e,stroke-width:2px
```

-   **PHY and MAC Layers:** IEEE 802.15.4 at 250 kbps; handles transmission, CSMA-CA, ACKs, retries, AES encryption.

-   **Adaptation Layer (6LoWPAN):** IPv6 header compression, fragmentation, mesh routing.

-   **Internet Layer (IPv6):** Addressing, routing, ICMPv6.

-   **Transport Layer (UDP/TCP):** Low-overhead delivery.

-   **Application Layer:** Protocols like CoAP for device tasks.

### Device Types

-   `Border Router`: Bridges Thread to IP networks (e.g., Wi-Fi); required for external access.

-   `Routers` (FTDs): Backbone for routing, addressing; up to 32 active.

-   `End Devices` (MTDs/SEDs): Low-power peripherals; rely on parent routers.

Communication uses two-way ACKs, retries (3-4 attempts), and ICMPv6 error reporting. A Leader router manages keys and partitions.

## Example: Simple Sensor Network

```mermaid
sequenceDiagram
    participant S as Sensor (SED)
    participant P as Parent Router
    participant BR as Border Router
    participant G as Gateway App (Cloud)
    participant L as Light (End Device)

    S->>P: Inclusion Request (via MLE)
    P->>S: IPv6 Address Assignment
    S-->>P: ACK (Inclusion complete)

    S->>S: Detects Motion

    S->>P: IPv6 UDP Message (Motion Detected)
    P-->>S: MAC ACK

    P->>BR: Routed via Mesh
    BR-->>P: ACK

    BR->>G: Data Forwarded (e.g., via IP)

    G->>BR: Command to Turn on Light (e.g., via Matter/CoAP)

    BR->>P: Routed IPv6 Command
    P-->>BR: ACK

    P->>L: Forward to Parent/Direct
    L-->>P: MAC ACK
```

## References

-   https://en.wikipedia.org/wiki/Thread_(network_protocol)
-   https://www.threadgroup.org/Portals/0/documents/support/Thread%20Network%20Fundamentals_v3.pdf
-   https://openthread.io/guides/thread-primer
