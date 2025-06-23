# VM Odoo 18 Community en Google Cloud

Este repositorio contiene un script para crear automáticamente una instancia de máquina virtual (VM) en Google Cloud Platform (GCP) con Odoo 18 Community Edition instalado.

## 🟢 Ejecutar en Google Cloud Shell

Haz clic para ejecutarlo directamente en Cloud Shell:

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ssh.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/ricardoyoxti/vm-odoo18-community&cloudshell_working_dir=.&cloudshell_tutorial=README.md)

## Archivos

- `crear_vm_odoo18_community.sh`: Script bash para crear y configurar la VM con Odoo 18.
- `README.md`: Instrucciones de uso.
- `.gitignore`, `LICENSE`

## Requisitos

- Tener instalado y autenticado el Google Cloud SDK (`gcloud init`) si se ejecuta local
- Tener habilitada la API de Compute Engine

## Uso

```bash
chmod +x crear_vm_odoo18_community.sh
./crear_vm_odoo18_community.sh
```

Al finalizar, accede a Odoo en: `http://IP_PUBLICA:8069`
