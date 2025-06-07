#!/bin/bash

# Dossier de backup
BACKUP_DIR=./ldap_backups
# Date du jour
DATE=$(date +"%Y-%m-%d")
# Nom du fichier backup
BACKUP_FILE="ldap-backup-$DATE.ldif"

# Créer le dossier de backup s'il n'existe pas
mkdir -p $BACKUP_DIR

# Exécuter le slapcat pour faire le backup
docker exec openldap slapcat -l /tmp/$BACKUP_FILE

# Copier le fichier du container vers l'hôte
docker cp openldap:/tmp/$BACKUP_FILE $BACKUP_DIR/$BACKUP_FILE

# Supprimer le fichier temporaire dans le container
docker exec openldap rm -f /tmp/$BACKUP_FILE

# (Optionnel) Supprimer les backups plus vieux que 7 jours
find $BACKUP_DIR -type f -name "*.ldif" -mtime +7 -exec rm {} \;

echo "Backup LDAP réalisé avec succès : $BACKUP_DIR/$BACKUP_FILE"
