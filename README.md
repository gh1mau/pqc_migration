# 🛡️ PQC Migration Readiness Toolkit (Unofficial)

A practical, research-friendly toolkit designed to help teams prepare for Post-Quantum Cryptography (PQC) migration.  
This project focuses on the biggest challenge in PQC transition: **visibility** — knowing what cryptography you have, where it lives, and how ready it is for PQC-era threats.

Inspired by insights from the  
**“Bengkel Migrasi Post-Quantum Cryptography (PQC) Tahun 2025 Siri 10”** organized by **NACSA** and **PTPKM**.  
This toolkit is **not official**, **not endorsed**, and **not affiliated** with these organizations.

---

## ⚠️ Disclaimer

This toolkit is **unofficial**, provided **as-is**, and intended **for educational and research purposes only**.  
The authors take **no responsibility** for any system issues, downtime, misconfiguration, or damages arising from its use.

Only scan systems you own or are authorized to test.  
Use responsibly.

---

## 📖 Introduction

Quantum computing will eventually break today’s widely used cryptographic algorithms such as RSA and ECC — a risk commonly described as **“Harvest Now, Decrypt Later.”**  
Because of this, organizations must start planning their migration to **Post-Quantum Cryptography (PQC)**.

But PQC migration is not just “change the algorithm.” It requires understanding your environment:

- What cryptographic protocols and services exist?
- What software components depend on them?
- How ready (or outdated) are those services?
- What is the impact of replacing classical crypto with PQC?
- Which assets require deeper analysis (SBOM/CBOM)?
- How much risk does each asset carry?

This toolkit introduces a simple, structured methodology to support that journey.  
Across all phases, the goal is to make PQC migration **clearer, measurable, and actionable**.

### **Scope of This Toolkit**
The toolkit covers the following areas:

#### **1. Inventory & Discovery**
- Network-facing crypto services  
- TLS/SSL versions and cipher suites  
- SSH algorithms and host key formats  
- Software versions and service fingerprints  

#### **2. SBOM (Software Bill of Materials)**
- Identifying libraries, dependencies, and crypto-relevant packages  
- Mapping components to PQC compatibility  

#### **3. CBOM (Cryptographic Bill of Materials)**
- Highlighting cryptographic primitives inside applications  
- Listing what algorithms, key sizes, or libraries are in use  

#### **4. Risk Register**
- Mapping all findings into a security and migration risk register  
- Categorizing assets based on sensitivity and exposure  

#### **5. Risk Assessment**
- Assigning risk levels  
- Identifying priority assets for PQC migration  
- Generating recommendations for future phases  

This project starts with **Phase 1**, with more phases being developed over time.

---

## 📚 Table of Contents

### 🔹 Project Documentation
- [Phase 1 — Discovery & Inventory](./phase1.md)  
- [Phase 2 — SBOM/CBOM Deep Analysis](./phase2.md)  
- [Phase 3 — PQC Compatibility Evaluation](./phase3.md)  
- [Phase 4 — Migration Planning & Roadmap](./phase4.md)  

### 🔹 General Information
- [About the Project](#-pqc-migration-readiness-toolkit-unofficial)  
- [Introduction](#-introduction)  
- [Disclaimer](#-disclaimer)  
- [Authors & Contributors](#authors--contributors)  
- [License](#license)  

---

## 📦 About This Repository

This repository contains:

- Core scripts for scanning and inventory  
- Documentation for each PQC migration phase  
- Example outputs (CSV, logs, diagrams)  
- Draft workflows for SBOM/CBOM analysis  
- Early-stage tools for risk scoring and readiness assessment  

The design philosophy is simple:
> **Readable, practical, and usable in real environments.**

---

## 👥 Authors & Contributors

### **Author**
- **Hussein Bin Mohamed (masta ghimau)**

### **Contributor**
- **Mohd Saufy**

---

## 📜 License

This project uses the **MIT License**, which allows reuse and modification while clearly stating **no warranty**.

---

## 🤝 Contributions

This is a learning-focused and community-friendly project.  
Pull requests, ideas, and improvements are welcome — especially enhancements for PQC scanning and SBOM/CBOM automation.

---

## ⭐ Support the Project

If this project helps you or sparks your curiosity, feel free to star the repo.  
Your support helps keep the development moving forward.

---
