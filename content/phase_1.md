# 🛡️ Phase 1: Discovery & Inventory

![Phase 1](https://img.shields.io/badge/Phase-1-4caf50)
![Status](https://img.shields.io/badge/Status-Experimental-yellow)
![License](https://img.shields.io/badge/License-MIT-blue)
![Dependencies](https://img.shields.io/badge/Dependencies-Check-yellowgreen)

> Automated inventory scanning tool to detect exposed crypto-enabled services and assess migration readiness.

## 📡 Introduction

Phase 1 uses an **"Outside-In"** approach. Before diving into source code or kernel configs, we first discover what is externally exposed. This phase identifies open network interfaces and the cryptographic protocols they are using.

This initial inventory forms the foundation for all subsequent phases of migration or security assessment.

---


## 🔄 The Methodology (How It Works)

Phase 1 uses a structured, step-by-step discovery flow to minimize blind spots and ensure accuracy.

### **1. Target Acquisition**

You tell the tool where to look:

- A **single IP** (e.g., a server or appliance), or  
- A **subnet range** (e.g., an entire VLAN)

You also assign a **Location/Owner tag** (e.g., “Server Room A”), which helps link assets to physical or logical context in later reporting.

### **2. Port Discovery**

Using Nmap, the tool scans specifically for ports associated with cryptographic services (“crypto-heavy ports”):

| Port | Purpose | Notes |
|------|---------|-------|
| **22** | SSH | KEX & host key algorithms |
| **443 / 8443** | HTTPS/TLS | Cipher suites & protocol versions |
| **3389** | RDP | Known for legacy crypto |
| **636** | LDAPS | TLS handshake |
| **993 / 995** | Secure IMAP/POP3 | TLS handshake |

The objective isn’t to discover every port, it’s to discover **crypto-relevant ports** that play a role in PQC migration.

### **3. Service Enumeration**

Once a crypto-relevant port is found, the script extracts:

- Service name (e.g., `ssh`, `https`, `ms-wbt-server`)
- Software version (e.g., `OpenSSH 8.9p1`, `Apache 2.4.52`)
- Protocol type (SSH, TLS/SSL, RDP, etc.)

This version fingerprint is critical because older versions often indicate deprecated or weak algorithm usage.

### **4. Active Interrogation (Handshake Stage)**

This step reveals **what cryptography the service actually uses**, not just what it claims in its banner.

#### **For SSH Services**
The scanner collects:

- Key Exchange (KEX) algorithms  
- Host key types (RSA, ECDSA, ED25519)  
- Supported ciphers and MACs  

SSH enumeration helps identify:

- Legacy RSA-only systems  
- Outdated MACs such as SHA1  
- Hosts lacking modern crypto-agility  

#### **For TLS/SSL Services**
If `testssl.sh` is available, a real handshake is performed to identify:

- TLS versions (TLS 1.0 → TLS 1.3)  
- Supported cipher suites  
- Presence of strong or weak primitives:
  - AES-GCM  
  - ChaCha20  
  - ECDHE  
  - Deprecated: RC4, 3DES, MD5  

If TestSSL is missing, the scanner falls back to Nmap’s SSL scripts.

### **5. Migration Readiness Grading**

Each service receives a preliminary PQC-readiness rating:

| Level | Meaning | Indicators |
|-------|---------|------------|
| **High** | Good posture | TLS 1.3, ED25519, modern OpenSSH |
| **Medium** | Acceptable | TLS 1.2, RSA/ECDHE |
| **Low** | Needs attention | RC4, SSLv3, SHA1, outdated SSH |

This helps prioritize which systems need deeper analysis.

---
## 📈 Process Flowchart

```mermaid
graph TD
    start([Start Phase 1]) --> check_deps{Check Dependencies}
    check_deps -- Missing --> error_exit[Error: Install Nmap/TestSSL]
    check_deps -- OK --> input[User Input: Target IP & Location]
    
    input --> nmap_scan[Nmap Network Discovery Scan]
    nmap_scan --> check_ports{Crypto Port Open?}
    
    check_ports -- No --> skip_host[Skip Host / Log No Ports]
    check_ports -- Yes --> service_enum[Service Enumeration & Version Detection]
    
    service_enum --> analyze_crypto{Analyze Crypto}
    
    analyze_crypto -- SSH Port --> script_ssh[Run Nmap SSH Enum Scripts]
    analyze_crypto -- SSL/TLS Port --> script_ssl[Run TestSSL.sh / Nmap SSL Scripts]
    analyze_crypto -- Other Port --> basic_log[Log Basic Service Info]
    
    script_ssh --> collect_data[Collect Algorithms & Assess Risk]
    script_ssl --> collect_data
    basic_log --> collect_data
    
    collect_data --> generate_csv[Generate 'pqc_inventory_output.csv']
    generate_csv --> finish([End Phase 1])
```

## 📊 Data Dictionary: What the Data Means

The tool generates a CSV file (`pqc_inventory_output.csv`) that can be directly used for initial inventory.  
Below is the description of each column:

| Column Name                   | Description |
|--------------------------------|-------------|
| **Asset Type**                 | Type of asset (e.g., Application Stack, Operating System). The scanner infers this from the port scanned (e.g., Port 22 → OS/Application). |
| **Asset Name / Identifier**    | Unique ID for the asset. Combines IP Address, Service Name, and Software Version. Example: `10.10.10.7 - ssh (OpenSSH 8.9p1 Ubuntu)` |
| **Location / Owner**           | Physical location of the asset (e.g., "Pusat Data Kg. Ismail"). Provided by the user during scan. |
| **Cryptographic Functionality Present?** | Yes/No. Since the tool only scans crypto-enabled ports (22, 443, etc.), this is usually "Yes". |
| **Examples of Algorithms Used** | Cryptographic algorithms detected during handshake. Example: RSA, ECDHE, AES-GCM. |
| **SBOM/CBOM Available?**       | Default `No`. Indicates whether a deeper SBOM/CBOM scan has been done (Phase 2). |
| **Migration Readiness Level**  | Automated assessment of migration readiness (Low, Medium, High). For example, presence of RC4 → Low. |
| **Notes / Action Items**       | Recommendations or observations from the scanner. Example: "TLS Service detected. Deep scan recommended with testssl.sh." |

---

## 🛠️ How to Use the Tool

The `pqc_scanner_phase1 tool` is a wrapper for powerful scanners like Nmap and TestSSL. It handles all the complex commands for you.


### Prerequisites

- You need a Linux environment with `nmap` installed.
- Nmap installed (`sudo apt install nmap`).


### 1. Basic Usage

Run the script with `sudo` (root is needed for accurate OS fingerprinting).

**Syntax:**

```bash
sudo chmod +x pqc_scanner_phase1
sudo ./pqc_scanner_phase1 
```

### 2. Command Options & Examples

| Scenario             | Command |
|---------------------|---------|
| Scan a Single Server | `sudo ./pqc_scanner_phase1 192.168.1.50 "Server Room A"` |
| Scan a Whole Subnet  | `sudo ./pqc_scanner_phase1 10.55.0.0/24 "Pusat Data Kg Ismail"` |

---

## 📸 Screenshots & Proof of Concept

### 1. Scanning in Progress
The tool displays a clean status dashboard, hiding the messy Nmap output behind the scenes.  

![Phase 1 Scan Screenshot](./img/phase1_sc1.png)

*Figure 1: Example of Phase 1 scan output.*



### 2. Final Output
A success message indicating the CSV generation is complete.  

*sc4*



### 3. Video Demo
See the tool in action scanning a live environment.  

poc1

---

## ✅ Tested On

The tool has been tested on the following environment:

```text
- Ubuntu 24.04.2 LTS
- WSL version: 2.6.1.0 (Kali GNU/Linux Rolling 2025.2)
```

## 🔍 VirusTotal Scan Results

You can view the scan result for the compiled binary here:

[VirusTotal Report(https://www.virustotal.com/gui/file/89f48cfc567e412a9e725c608f7dd3bdadd788c42f314a5bd430615c1922f946?nocache=1)




[Return to Top](#)












