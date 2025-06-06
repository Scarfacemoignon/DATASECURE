# DATASECURE
Sécurisation et Pentest d'une Infrastructure en Docker
# Projet M1 : Sécurisation et Pentest d'une Infrastructure en Docker

## 👉 Objectif du Projet

Ce projet a pour but de :

1. **Blue Team** : Déployer une infrastructure simulée d'entreprise, sécurisée, à l'aide de Docker Compose.
2. **Red Team** : Effectuer un test d'intrusion complet de cette infrastructure.

## 🔧 Partie 1 : Déploiement de l'Infrastructure (Blue Team)

### 🔹 Composants à déployer

* **Application Métier** : Dolibarr ERP/CRM
* **Base de données** : MariaDB
* **Gestion des utilisateurs** : OpenLDAP
* **Bastion SSH** : Serveur pour administration
* **VPN** : OpenVPN pour accès distant sécurisé

### 📊 Architecture Réseau

* **dmz\_network** : Serveur Web (Dolibarr) - Accessible depuis l'Internet via HTTPS (443).
* **internal\_network** : Base de données, OpenLDAP, Bastion SSH - Réseau interne non exposé.
* **vpn\_network** : VPN pour accès Red Team.

### 📁 Docker Compose (Vue Globale)

| Service     | Image Docker           | Réseau            | Ports Exposés |
| ----------- | ---------------------- | ----------------- | ------------- |
| Dolibarr    | dolibarr/dolibarr      | dmz\_network      | 443 (HTTPS)   |
| MariaDB     | mariadb                | internal\_network | Aucun         |
| OpenLDAP    | osixia/openldap        | internal\_network | 389, 636      |
| Bastion SSH | rastasheep/ubuntu-sshd | internal\_network | 22            |
| OpenVPN     | kylemanna/openvpn      | vpn\_network      | 1194/UDP      |

### 🔒 Sécurisation

* HTTPS obligatoire avec Let’s Encrypt via reverse proxy (Traefik ou Nginx).
* Clés SSH uniquement sur Bastion.
* Firewall hôte avec `iptables` pour contrôler l'accès aux containers.
* Fail2Ban sur SSH pour protection brute force.
* LDAPS (LDAP + SSL/TLS) activé pour sécuriser les communications LDAP.
* Segmentation des réseaux Docker.

### 📅 Livrables Blue Team

1. Schéma réseau
2. `docker-compose.yml`
3. Documentation d'installation et de configuration
4. Rapport de sécurité justifiant chaque choix
5. Procédure d'accès pour Red Team (IP publique, VPN config)

## 🔧 Partie 2 : Test d'Intrusion (Red Team)

### 🛡️ Objectif

Tester la robustesse de l’infrastructure déployée par la Blue Team.

### 🔹 Périmètre d'attaque

* Application Dolibarr (HTTPS)
* VPN
* Bastion SSH
* Tentatives d'accès interne (MariaDB, OpenLDAP)

### 🔍 Méthodologie

1. **Reconnaissance** : Scan IP, ports (nmap)
2. **Analyse de vulnérabilités** : Dolibarr, configurations.
3. **Exploitation** : Vulnérabilités Web, Escalade de privilèges.
4. **Post-Exploitation** : Recherche de pivot possible.

### 📅 Livrables Red Team

1. Rapport de pentest documenté (vulnérabilités, preuves d'exploitation, recommandations)
2. Démonstration de la compromission
3. Évaluation de la détection (logs, IDS activé ?)

## 📚 Conclusion

Ce projet met en pratique les compétences de déploiement sécurisé d'infrastructure, d'usage de Docker Compose pour la virtualisation, et de pentesting orienté entreprise, en respectant les bonnes pratiques de cybersécurité.


*Projet réalisé par : \[Dierry TCHUENDOM]*
