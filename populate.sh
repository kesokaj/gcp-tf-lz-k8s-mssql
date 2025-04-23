#!/bin/bash

# enable logging
set -euxo pipefail

GCP_USER=$(gcloud auth list --format="value(ACCOUNT)")
GCP_BILLING_ID=$(gcloud beta billing accounts list --format="value(name)")
GCP_ORG_ID=$(gcloud organizations list --format="value(ID)")
GCP_FOLDER_ID=$(gcloud resource-manager folders list --organization=$GCP_ORG_ID --format="value(name)")

cat << EOF > terraform.tfvars
#first_user = "${GCP_USER}"
billing_id = "${GCP_BILLING_ID}"
org_id = "${GCP_ORG_ID}"
folder_id = "${GCP_FOLDER_ID}"
EOF