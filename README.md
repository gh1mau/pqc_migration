#  PQC Migration Readiness Toolkit (Unofficial)

A practical and research-friendly toolkit built to help teams prepare for Post-Quantum Cryptography (PQC) migration.  
The main goal of this project is to give you clear visibility of your cryptographic landscape. What algorithms you are using, where they live, and how ready they are for future PQC requirements.

This toolkit was inspired by the '**Bengkel Migrasi Post-Quantum Cryptography (PQC) Tahun 2025 Siri 10**'. The workshop was organized by **NACSA** and **PTPKM (Pusat Teknologi dan Pengurusan Kriptologi Malaysia)**, with participation from **Pejabat SUK Negeri Sembilan** and several Pejabat SUK Bahagian Utara.

This project is **not official**, **not endorsed**, and **not affiliated** with these organizations.


## ⚠️ Disclaimer

This toolkit is **unofficial** and provided **as-is** for educational and research purposes only.  

I (**Hussein bin Mohamed – masta ghimau**) am not responsible for any system downtime, data loss, misconfiguration, or any damage resulting from the use of these tools and the methodology provided.

Scan only systems that you own or have permission to test. Use responsibly.



## 📖 Introduction

Quantum computing is expected to break many of today’s widely used cryptographic algorithms especially RSA and ECC.  

This risk is often described as **“Harvest Now, Decrypt Later”**, where attackers collect encrypted data today and decrypt it in the future once quantum computers become strong enough.

Because of this, organizations need to start planning their journey towards **Post-Quantum Cryptography (PQC)**.  
But migrating to PQC is not as simple as replacing one algorithm with another. You first need to understand your environment:

- Which cryptographic protocols and services are running?
- What software or systems depend on them?
- Are those services outdated or still safe?
- What will break if you replace classical algorithms with PQC?
- What needs deeper inspection through **SBOM** (Software Bill of Materials) or **CBOM** (Cryptographic Bill of Materials)?
- How much risk is carried by each asset?

This toolkit provides a simple and structured way to answer those questions.  

Each phase is designed to make PQC migration **clear**, **measurable**, and **actionable**. Even for teams that are just getting started.



## 📦 Scope of This Toolkit

This project automates the early stages of PQC migration: inventory, analysis, and risk assessment. It specifically covers the following tools and functionalities based on the scripts provided:

### **1. Inventory & Discovery (Phase 1)**  
**Tool:** `pqc_scanner_phase1`  
This script acts as your network scout. It scans your network to map out all active services and identify the cryptographic protocols they use.

**What it does:**

- Scans for SSH, TLS/SSL, RDP, and other crypto-heavy services  
- Uses Nmap and TestSSL to detect versions and algorithms  
- Performs live handshakes to collect cipher and key exchange details  
- Generates an easy-to-read Inventory CSV ready for reporting.



### **2. Deep Dive Analysis (Phase 2)**  
**Tool:** `scan_pqc_phase_2.sh`  
After identifying key assets, this phase provides a detailed analysis of the system or codebase. It combines several powerful engines:

**What it does:**

- **OS Scan:** Uses `mini-pqc-scanner` to check kernel, OpenSSL, and crypto libraries  
- **SBOM:** Uses **Syft** to list installed packages and dependencies  
- **Vulnerability Scan:** Uses **Grype** to match SBOM components to known CVEs  
- **CBOM:** Uses **Semgrep** with my custom rules (pqc-php-rules.yml) to detect specific crypto usage in source code (e.g., md5(), password_hash(), openssl_encrypt()).



### **3. Intelligence & Reporting**

**Tool:** `parser.py`

Raw JSON output is useful for machines, but not exactly fun to read.  
This parser takes all the scan results and turns them into clean, organized reports that you can actually use for decision-making.

**What it does:**

- Pulls everything together to produce your **SBOM, CBOM, Risk Registers, and Risk Assessments**
- Merges OS, SBOM, and CBOM data into one place so the relationships between systems, software, and cryptography are easy to follow
- Tags vulnerable components with the correct **CVE IDs**, so you instantly know what needs attention
- Calculates PQC-related risk scores and highlights low crypto-agility areas (like hardcoded algorithms)
- Helps you see the “story” behind the data instead of just raw numbers
- Generates the following ready-to-use Excel files:
  - **SBOM.xlsx**
  - **CBOM.xlsx**
  - **Risk_Register.xlsx**
  - **Risk_Assessment.xlsx**

## 📚 Project Documentation

- [Phase 1 — Discovery & Inventory](./content/phase_1.md) 
- Phase 2 — SBOM/CBOM Deep Analysis  
- Phase 3 — PQC Compatibility Evaluation (Planned)  
- Phase 4 — Migration Planning & Roadmap (Planned)



## 👥 Authors & Contributors

**Author:** Hussein Bin Mohamed - masta ghimau  **Pejabat SUK Negeri Sembilan**
**Contributor:** Muhammad Saufy Rohmad **PTPKM** (Output review, report validation)



## 📜 License

Licensed under the **MIT License**.  
You may use, modify, and distribute the project, as long as the original copyright notice is included.


