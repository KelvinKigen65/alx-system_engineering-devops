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
