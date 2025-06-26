# 🔐 Projet Final - Infrastructure Sécurisée avec Docker, Suricata & ELK

## 📌 Objectif

Ce projet vise à concevoir et déployer une infrastructure sécurisée et supervisée à l’aide de conteneurs Docker. Elle intègre une application vulnérable, un pare-feu applicatif (WAF), un système de détection d'intrusion (IDS) avec Suricata, une machine d'attaque Kali Linux, ainsi qu'une stack ELK (Elasticsearch, Logstash, Kibana) pour la collecte et l’analyse des logs de sécurité.

---

## 🧱 Architecture du projet

```plaintext
                   +-------------------------+
                   |     Attaquant (Kali)    |
                   +-----------+-------------+
                               |
                               v
+-----------+     +-----------+-------------+     +------------------+
| Utilisateur| -->| Reverse Proxy (Traefik) | --> | Dolibarr         |
+-----------+     +-------------------------+     +------------------+
                               |
                +--------------+--------------+
                |              |              |
         +------+-----+  +-----+------+  +-----+------+
         | ModSecurity |  |   Suricata  |  |  Bastion  |
         |     WAF     |  |   IDS (host)|  |  SSH LDAP |
         +-------------+  +-------------+  +-----------+
                                      |
                         +------------+------------+
                         |     Stack ELK (SIEM)    |
                         |  - Elasticsearch        |
                         |  - Logstash             |
                         |  - Kibana               |
                         +-------------------------+
```

---

## 🛠️ Technologies utilisées

- **Docker & Docker Compose** : Conteneurisation de l’ensemble des services
- **Traefik** : Reverse proxy et gestion SSL
- **Dolibarr** : Application métier ERP/CRM vulnérable intégrée
- **ModSecurity + CRS OWASP** : Pare-feu applicatif
- **Suricata** : IDS avec détection des attaques réseau
- **Kibana** : Visualisation des logs
- **Logstash** : Parsing des logs Apache & Suricata
- **Elasticsearch** : Stockage indexé des logs
- **OpenLDAP + phpLDAPadmin** : Gestion centralisée des utilisateurs
- **Kali Linux** : Machine d’attaque pour tests XSS, SQLi, Brute-force

---

## 🚀 Déploiement rapide

### ✅ Prérequis

- Docker et Docker Compose installés
- Modifier le fichier `/etc/hosts` :

```bash
127.0.0.1 app.datasecure.local ldap.datasecure.local
```

### ⚙️ Lancement via `make`

```bash
make setup
```

Sinon, à la main :

```bash
git clone https://github.com/Scarfacemoignon/DATASECURE.git
cd projet-final-cybersec
docker-compose up -d
```

---

## 🔍 Services exposés

| Service           | URL/Port                                                       |
| ----------------- | -------------------------------------------------------------- |
| Web App           | [https://app.datasecure.local](https://app.datasecure.local)   |
| Kibana            | [http://localhost:5601](http://localhost:5601)                 |
| phpLDAPadmin      | [https://ldap.datasecure.local](https://ldap.datasecure.local) |
| Traefik Dashboard | [http://localhost:8080](http://localhost:8080)                 |
| SSH Bastion       | ssh user\@localhost -p 2222                                    |

---

## 📁 Fichiers clés

| Fichier                  | Rôle                                 |
| ------------------------ | ------------------------------------ |
| `docker-compose.yml`     | Définition des services              |
| `suricata/suricata.yaml` | Configuration de Suricata (IDS)      |
| `logstash/logstash.conf` | Ingestion des logs Suricata / Apache |
| `rules/local.rules`      | Règles personnalisées Suricata       |
| `traefik/*.yml`          | Configuration HTTPS / Entrées DNS    |
| `.gitignore`             | Fichiers à ignorer pour Git          |

---

## 🧪 Tests d'attaque

Depuis Kali :

- **XSS** :

```bash
curl "https://app.datasecure.local/index.php?msg=<script>alert(1)</script>"
```

- **SQL Injection** :

```bash
sqlmap -u "https://app.datasecure.local/login.php" --data="user=admin&pass=123" --batch
```

- **Brute-force** :

```bash
hydra -l admin -P /usr/share/wordlists/rockyou.txt https://app.datasecure.local login=^USER^ pass=^PASS^
```

---

## 📊 Analyse dans Kibana

1. Accéder à Kibana : [http://localhost:5601](http://localhost:5601)
2. Créer les index patterns :
   - `suricata-alerts-*`
   - `apache-logs-*`
3. Visualiser :
   - Les types d'attaques
   - IP suspectes
   - Requêtes HTTP filtrées par le WAF

---

## 🧠 Auteur

**Dierry Nevyl Tchuendom**\
Étudiant en Cybersécurité - Lille YNOV Campus\
Projet DevSecOps

