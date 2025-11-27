# Phase 1 — Discovery & Inventory Methodology

[⬅ Return to Main Page](./README.md)

---

## 📡 Introduction

Phase 1 focuses on an **“Outside-In” discovery approach**.  
Before diving into source code, libraries, or kernel-level cryptographic settings, we first need to understand the external attack surface:  

**What services are exposed, and what cryptography do they rely on?**

This phase identifies exposed interfaces, the protocols they advertise, and the cryptographic algorithms they negotiate.  
The results from this phase map directly to **Table 0: Initial Inventory** in the PQC Migration Workbook, forming the foundation for Phase 2 and beyond.

---

## 🔄 The Methodology (How It Works)

Phase 1 uses a structured, step-by-step discovery flow to minimize blind spots and ensure accuracy.

---

### **1. Target Acquisition**

You tell the tool where to look:

- A **single IP** (e.g., a server or appliance), or  
- A **subnet range** (e.g., an entire VLAN)

You also assign a **Location/Owner tag** (e.g., “Server Room A”), which helps link assets to physical or logical context in later reporting.

---

### **2. Port Discovery**

Using Nmap, the tool scans specifically for ports associated with cryptographic services (“crypto-heavy ports”):

| Port | Purpose | Notes |
|------|---------|-------|
| **22** | SSH | KEX & host key algorithms |
| **443 / 8443** | HTTPS/TLS | Cipher suites & protocol versions |
| **3389** | RDP | Known for legacy crypto |
| **636** | LDAPS | TLS handshake |
| **993 / 995** | Secure IMAP/POP3 | TLS handshake |

The objective isn’t to discover every port —  
it’s to discover **crypto-relevant ports** that play a role in PQC migration.

---

### **3. Service Enumeration**

Once a crypto-relevant port is found, the script extracts:

- Service name (e.g., `ssh`, `https`, `ms-wbt-server`)
- Software version (e.g., `OpenSSH 8.9p1`, `Apache 2.4.52`)
- Protocol type (SSH, TLS/SSL, RDP, etc.)

This version fingerprint is critical because older versions often indicate deprecated or weak algorithm usage.

---

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

---

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
