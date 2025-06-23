#!/bin/bash

# === CONFIGURACIÓN ===
NOMBRE_INSTANCIA="odoo18-community"
ZONA="us-central1-a"
MAQUINA="e2-medium"
DISCO="50GB"
PROYECTO=$(gcloud config get-value project)
USUARIO_GCE="odoo18"

echo "🚀 Creando instancia VM en Google Cloud..."
gcloud compute instances create "$NOMBRE_INSTANCIA" \
    --zone="$ZONA" \
    --machine-type="$MAQUINA" \
    --image-project=debian-cloud \
    --image-family=debian-11 \
    --boot-disk-size="$DISCO" \
    --tags=http-server,https-server \
    --metadata=startup-script='#! /bin/bash
apt update
apt upgrade -y
apt install -y git python3-pip build-essential wget python3-dev libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev libssl-dev libjpeg-dev libpq-dev libffi-dev libtiff-dev libopenjp2-7-dev liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev node-less npm
apt install -y postgresql
sudo -u postgres createuser -s odoo18
adduser --system --home=/opt/odoo18 --group odoo18
mkdir /opt/odoo18/odoo
cd /opt/odoo18/odoo
git clone https://www.github.com/odoo/odoo --depth 1 --branch 18.0 --single-branch .
pip3 install wheel
pip3 install -r requirements.txt
echo "[options]
admin_passwd = admin
db_host = False
db_port = False
db_user = odoo18
db_password = False
addons_path = /opt/odoo18/odoo/addons
logfile = /var/log/odoo18.log
" > /etc/odoo18.conf

echo "[Unit]
Description=Odoo18
After=network.target

[Service]
Type=simple
SyslogIdentifier=odoo18
PermissionsStartOnly=true
User=odoo18
Group=odoo18
ExecStart=/usr/bin/python3 /opt/odoo18/odoo/odoo-bin -c /etc/odoo18.conf
StandardOutput=journal+console

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/odoo18.service

systemctl daemon-reexec
systemctl daemon-reload
systemctl enable odoo18
systemctl start odoo18
'

echo "✅ Instancia '$NOMBRE_INSTANCIA' creada y Odoo 18 Community instalado."
echo "🌐 Accede a Odoo desde: http://$(gcloud compute instances describe $NOMBRE_INSTANCIA --zone=$ZONA --format='get(networkInterfaces[0].accessConfigs[0].natIP)'):8069"
