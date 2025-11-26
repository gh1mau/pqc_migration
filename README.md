# 🛡️ PQC Migration Readiness Toolkit (Unofficial)

Welcome to the **PQC Migration Readiness Toolkit (Unofficial)** — a simple but practical toolkit created to help teams understand where they stand before moving into the world of Post-Quantum Cryptography (PQC).

This project focuses on the *visibility problem* — because you can’t secure what you don’t know you have.  
The toolkit helps you discover cryptographic services, identify what algorithms are being used, and prepare the groundwork for a full PQC migration plan.

This repository is inspired by insights shared during the  
**“Bengkel Migrasi Post-Quantum Cryptography (PQC) Tahun 2025 Siri 10”**  
organized by **NACSA (National Cyber Security Agency)** and **PTPKM**.  
This project is **not official**, **not endorsed**, and **not associated** with these organizations — just something built to help learning and exploration.

---

## ⚠️ Disclaimer

This toolkit is **unofficial** and provided strictly **as-is**.  
There is **no warranty**, no support, and the authors are **not responsible** for any damage, data loss, downtime, or issues that may occur from using this toolkit.

It is meant **for educational and research purposes only**.

Please do not use this toolkit on networks or systems you do not own or do not have permission to scan.  
Use responsibly.

---

## 📖 Introduction

Cryptography today relies heavily on classical algorithms like RSA and ECC.  
As quantum computers grow more capable, these algorithms will eventually become breakable — a threat often called **“Harvest Now, Decrypt Later”**.

To prepare for this future, organizations must migrate to **Post-Quantum Cryptography (PQC)**.  
The challenge? Migration is not as simple as switching an algorithm. It requires understanding your entire cryptographic landscape — from certificates and TLS settings to SSH configurations, middleware, libraries, and backend systems.

The hardest step is the first one: **visibility**.

This toolkit focuses on solving that first hurdle:

- Discover what cryptographic services exist  
- Identify software versions  
- Enumerate algorithms and protocol support  
- Highlight potential weaknesses  
- Build a clean inventory that feeds into PQC migration planning  

This is **Phase 1** of a bigger migration methodology — and more phases will be added as the toolkit grows.

---

## 📚 Table of Contents

### 🔹 **Project Pages**
- [Phase 1 — Discovery & Inventory](./phase1.md)
- [Phase 2 — SBOM/CBOM Deep Analysis](./phase2.md)
- [Phase 3 — PQC Compatibility Evaluation](./phase3.md)
- [Phase 4 — Migration Planning & Roadmap](./phase4.md)

### 🔹 **General**
- [About This Project](#-pqc-migration-readiness-toolkit-unofficial)
- [Disclaimer](#-disclaimer)
- [Introduction](#-introduction)
- [Authors & Contributors](#authors--contributors)
- [License](#license)

---

## 📦 About This Repository

This repo stores:

- The core scanning scripts  
- Documentation for each migration phase  
- CSV inventory output samples  
- Log examples  
- Diagrams and workflow references  
- Future tools for SBOM/CBOM extraction and PQC readiness scoring  

The goal is to keep everything simple, readable, and usable in real environments.

---

## 👥 Authors & Contributors

### **Author**
- **Hussein Bin Mohamed (masta ghimau)**

### **Contributor**
- **Mohd Saufy**

---

## 📜 License

This project uses the **MIT License**, which allows reuse while protecting contributors with a clear **no-warranty** clause.

---

## 🤝 Contributions

This is a learning-focused project.  
If you want to improve the scripts, add new checks, write documentation, or simply share ideas — contributions are welcome.

---

## ⭐ Support the Project

If you find this useful or interesting, feel free to star the repo.  
It helps others discover the toolkit and encourages ongoing development.

---
