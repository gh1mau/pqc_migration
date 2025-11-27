# 🛡️ Quantum Migration Intelligence Core – Phase 1: Discovery & Inventory

![Phase 1](https://img.shields.io/badge/Phase-1-4caf50)
![Status](https://img.shields.io/badge/Status-Experimental-yellow)
![License](https://img.shields.io/badge/License-MIT-blue)
![Dependencies](https://img.shields.io/badge/Dependencies-Check-yellowgreen)
![Last Run](https://img.shields.io/badge/Last%20Run-Not%20Executed-lightgrey)
![CSV Generated](https://img.shields.io/badge/CSV-❌-red)

> Automated inventory scanning tool to detect exposed crypto-enabled services and assess migration readiness.

---

## 📡 Introduction

Phase 1 uses an **"Outside-In"** approach. Before diving into source code or kernel configs, we first discover what is externally exposed. This phase identifies open network interfaces and the cryptographic protocols they are using.

This initial inventory forms the foundation for all subsequent phases of migration or security assessment.

---

<details>
<summary>🔄 Methodology (Click to Expand)</summary>

### How the Tool Works

The discovery tool follows these steps:

1. **Target Acquisition**  
   Specify the target IP (single host) or subnet (entire network segment). Tag each target with its physical location.

2. **Port Discovery**  
   Scans for crypto-heavy ports: SSH (22), HTTPS (443), RDP (3389), LDAPS (636).

3. **Service Enumeration**  
   Detects service name and version (e.g., OpenSSH 8.9, Apache 2.4). Helps identify capabilities and vulnerabilities.

4. **Active Interrogation (Handshake)**  
   - SSH: queries supported key exchange methods  
   - TLS/SSL: performs handshake to enumerate cipher suites and TLS versions

5. **Readiness Grading**  
   Preliminary "Migration Readiness Level" (Low, Medium, High) based on crypto strength.

</details>

---

<details>
<summary>📈 Process Flowchart</summary>

```mermaid
flowchart TD
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
</details>
