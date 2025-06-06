# DATASECURE
Sécurisation et Pentest d'une Infrastructure en Docker


![Docker Compose](https://img.shields.io/badge/Docker-Compose-blue)
![Security](https://img.shields.io/badge/Security-Wazuh%20%26%20Grafana-success)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)

---

## 🎯 Objectif

Ce projet a pour but de :

- 🚀 **Déployer une infrastructure simulée d'entreprise** sécurisée à l'aide de Docker Compose.
- 🛡️ **Effectuer un test d'intrusion** complet sur l'infrastructure.
- 📈 **Mettre en place un monitoring avancé** avec Wazuh et Grafana pour l'analyse des logs et la surveillance des performances.

---

## 🧩 Architecture de l'Infrastructure

### 📚 Services Déployés

| Service           | Image Docker             | Réseau          | Ports Exposés  |
|-------------------|---------------------------|-----------------|---------------|
| Dolibarr ERP/CRM  | dolibarr/dolibarr          | dmz_network     | 443 (HTTPS)   |
| Base de Données   | mariadb                   | internal_network| -             |
| OpenLDAP          | osixia/openldap           | internal_network| 389, 636      |
| Bastion SSH       | rastasheep/ubuntu-sshd     | internal_network| 2222 (SSH)    |
| OpenVPN           | kylemanna/openvpn          | vpn_network     | 1194/UDP      |
| Wazuh Manager     | wazuh/wazuh-manager        | wazuh_network   | 1514/UDP, 1515, 55000 |
| Wazuh Indexer     | wazuh/wazuh-indexer        | wazuh_network   | -             |
| Wazuh Dashboard   | wazuh/wazuh-dashboard      | wazuh_network   | 5601          |
| Grafana           | grafana/grafana            | wazuh_network   | 3000          |

### 🛰️ Réseaux Docker

- `dmz_network` : Pour Dolibarr Web Server.
- `internal_network` : Pour Base de Données, LDAP, SSH Bastion.
- `vpn_network` : Pour connexion sécurisée via VPN.
- `wazuh_network` : Pour la gestion des logs et monitoring.

---

## 🔒 Sécurisation Mise en Place

- HTTPS obligatoire avec certificat SSL via Let's Encrypt (reverse proxy Nginx/Traefik).
- Authentification SSH uniquement par clés privées sur Bastion.
- Firewall `iptables` actif sur l’hôte Docker pour restreindre les flux.
- Fail2Ban actif pour bloquer les tentatives SSH bruteforce.
- Sécurisation LDAP via LDAPS (SSL/TLS).
- Segmentation réseau stricte via Docker Networks.
- Monitoring centralisé et alerting avec **Wazuh**.
- Visualisation des métriques et logs via **Grafana**.

---

## 🛠️ Déploiement

1. Clonez ce dépôt :
    ```bash
    git clone https://github.com/<ton_github>/projet_m1_infra.git
    cd projet_m1_infra
    ```

2. Lancer tous les services :
    ```bash
    docker-compose up -d
    ```

3. Accéder aux Interfaces :
    - **Dolibarr** : `https://<votre-ip>`
    - **Wazuh Dashboard** : `http://<votre-ip>:5601`
    - **Grafana** : `http://<votre-ip>:3000` (Login: admin / admin)

4. Dans Grafana :
    - Ajouter OpenSearch (`http://wazuh.indexer:9200`) comme source de données.
    - Importer un dashboard préconfiguré pour la surveillance des services.

---

## 🔍 Test d'Intrusion (Red Team)

### Périmètre d'attaque
- Application Dolibarr
- VPN OpenVPN
- Bastion SSH
- Réseau interne (MariaDB, OpenLDAP)

### Méthodologie
- 🔎 Reconnaissance : Scan réseau (Nmap, masscan).
- 🔒 Analyse de vulnérabilités : OWASP ZAP, OpenVAS.
- 🛠️ Exploitation : Injection SQL, attaques XSS, escalade SSH.
- 🧩 Post-Exploitation : Accès aux données, escalade de privilèges.

### Livrables attendus
- Rapport de pentest détaillé (vulnérabilités + preuves).
- Démonstration de compromission.
- Évaluation de la capacité de détection (logs et alertes générées).

---

## 📈 Monitoring avec Wazuh et Grafana

- **Wazuh Dashboard** accessible sur `http://<votre-ip>:5601`
- **Grafana** accessible sur `http://<votre-ip>:3000`
  - Utilisez OpenSearch comme Data Source.
  - Importez des dashboards pour suivre :
    - Connexions SSH
    - Erreurs bases de données
    - Logs Web serveur (Dolibarr)
    - Activité OpenVPN
    - Tentatives d'intrusion

---

## 📝 Livrables du Projet

- `docker-compose.yml` complet.
- Schéma réseau.
- Documentation d'installation et sécurisation.
- Rapport de sécurité.
- Rapport de test d'intrusion.
- Accès configuré à Wazuh et Grafana.

---



*Projet réalisé par : \[Dierry TCHUENDOM]*
