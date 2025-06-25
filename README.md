# 🌐 ALX System Engineering & DevOps: Web Infrastructure Design

## 📘 Overview

This document describes a multi-server web infrastructure setup for hosting the website **www.foobar.com**, incorporating concepts such as load balancing, database clustering, security, and monitoring.

---

## 🖥️ Infrastructure Components

### 1. What is a Server?
A **server** is a physical or virtual computer that provides data, services, or programs to clients over a network. In this setup, it hosts the website and processes user requests.

### 2. What is the Role of the Domain Name?
A **domain name** (e.g., `www.foobar.com`) is a human-readable address mapped to the server's IP. It allows users to access the server without remembering the IP address.

### 3. What Type of DNS Record is ‘www’ in `www.foobar.com`?
- `www` is a **subdomain**.
- Common DNS records used:
  - **A Record**: Maps `www.foobar.com` directly to an IP.
  - **CNAME Record**: Maps `www.foobar.com` to another domain like `foobar.com`.

### 4. What is the Role of the Web Server?
The **web server** (e.g., Nginx or Apache):
- Serves static content (HTML, CSS, JS)
- Handles HTTPS encryption
- Routes dynamic requests to the application server
- Logs and manages HTTP traffic

### 5. What is the Role of the Application Server?
The **application server**:
- Runs backend logic (e.g., Python, Node.js, PHP)
- Processes requests and interacts with the database
- Handles dynamic user interactions

### 6. What is the Role of the Database?
The **database**:
- Stores persistent data like users, sessions, orders
- Powers dynamic content
- Examples: MySQL, PostgreSQL

### 7. How Does the Server Communicate With the User?
Communication is done over **HTTP/HTTPS via TCP/IP**. The user’s browser sends an HTTP request, and the server returns a response, rendered in the browser.

---

## 🏗️ Extended Infrastructure Components

| Component         | Purpose                                                                 |
|------------------|-------------------------------------------------------------------------|
| Load Balancer     | Distributes traffic across servers to ensure availability & scalability |
| Primary-Replica DB| Enhances read performance and adds redundancy                          |
| Firewall          | Secures the network by blocking unauthorized access                     |
| HTTPS             | Encrypts traffic between server and clients                             |
| Monitoring System | Provides visibility into server health and performance                  |

---

## 🔁 Load Balancer Distribution Algorithm

- **Algorithm Used:** Round Robin
  - Request 1 → Server A  
  - Request 2 → Server B  
  - Request 3 → Server C  
  - Request 4 → Server A (cycle repeats)

- Other common algorithms:
  - **Least Connections**: Chooses server with the fewest active connections
  - **IP Hash**: Maps client IPs to specific backend servers for session persistence

---

## 🧭 Active-Active vs Active-Passive Load Balancing

| Setup          | Description                                      | Use Case                         |
|----------------|--------------------------------------------------|----------------------------------|
| Active-Active  | All nodes handle traffic simultaneously          | High performance, high availability |
| Active-Passive| One active node handles traffic; others on standby | Simpler, but limited capacity    |

---

## 🗃️ Database: Primary-Replica Cluster

- **Primary Node (Master)**: Handles all **write operations**
- **Replica Node (Slave)**: Handles **read operations** and syncs with the primary

### Replication Types:
- **Asynchronous**: High performance, but potential data loss on crash
- **Semi-synchronous**: Balance between speed and safety

---

## ⚙️ Primary vs Replica (From the App Perspective)

| Feature             | Primary Node | Replica Node |
|---------------------|--------------|--------------|
| Handles Writes       | ✅           | ❌           |
| Handles Reads        | ✅           | ✅           |
| Risk of Conflict     | Possible     | None         |
| Failure Impact       | High         | Can be promoted to primary |

---

## ⚠️ Known Infrastructure Issues

### ❗ Single Points of Failure (SPOFs)
- **Load Balancer**: If it fails, no traffic reaches backend servers.
- **Primary DB**: Write operations stop if it fails without replication or failover.

### ❗ Security Issues
- No **firewall**: Exposed to brute force, DDoS, or unauthorized access
- No **HTTPS**: Plaintext traffic may lead to eavesdropping

### ❗ No Monitoring
- Failures go unnoticed
- No insights into performance, traffic, or bottlenecks

---

## ✅ Recommendations

- Introduce **redundant components** (load balancer, DB, app servers)
- Implement **firewalls and HTTPS**
- Add **monitoring tools** (Prometheus, Grafana, Datadog)
- Enable **failover and multi-zone deployment**

---

## 🔧 Additional Infrastructure Considerations

| Element           | Purpose                                                               |
|-------------------|-----------------------------------------------------------------------|
| Load Balancer     | Improves scalability and uptime                                       |
| Firewall          | Protects from unauthorized traffic and attacks                        |
| HTTPS/SSL         | Encrypts traffic and builds user trust                                |
| Monitoring Tools  | Tracks health, alerts on failures, helps optimize performance         |
| DB Replication    | Provides high availability and failover                               |
| Separate Tiers    | Isolating web, app, and DB improves scaling and debugging             |

---

## 🔐 What Are Firewalls For?
- Blocks unauthorized access
- Allows traffic based on rules
- Helps mitigate attacks (DDoS, brute force, etc.)

---

## 🔒 Why Use HTTPS?
- Encrypts user-server communication
- Prevents MITM attacks and eavesdropping
- Boosts SEO and browser compatibility

---

## 📈 What Is Monitoring Used For?
- Tracks CPU, memory, disk, network, uptime
- Detects anomalies and alerts on issues
- Helps with scaling and debugging

---

## 📊 How Does Monitoring Collect Data?
- Agents/exporters installed on servers
- Pulls data via HTTP, SNMP, or logs
- Stores metrics in a time-series DB (e.g., Prometheus)
- Visualized via dashboards (e.g., Grafana)

---

## ❓ How to Monitor Web Server QPS (Queries Per Second)

1. Enable **access logging** on web server (Nginx, Apache)
2. Use tools like:
   - **GoAccess**, **AWStats** for logs
   - **Prometheus + Nginx exporter**
   - **Grafana** for dashboarding
3. Set **alerts** on QPS thresholds for traffic spikes

---

## ⚠️ Infrastructure Weak Points

### ❗ SSL Termination at Load Balancer
- Unencrypted traffic between load balancer and backend
- Solution: Use **TLS passthrough** or **re-encrypt** traffic to backend

### ❗ Single MySQL Primary Node
- No write operations if it fails
- Solution: Use **failover setup** or **MySQL cluster**

### ❗ Monolithic Servers
- All components on one machine → resource contention, hard to scale
- Solution: Use **tiered architecture** (web / app / DB separation)

---

## 📌 License
This documentation is for educational purposes and part of the **ALX System Engineering & DevOps** program.
