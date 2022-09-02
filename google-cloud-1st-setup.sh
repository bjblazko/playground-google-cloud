#!/bin/sh

echo "Ensure to be connected to the correct cloud account."
echo "have you type this before? > gcloud auth login"
echo
read -p "Press any key to continue or [Ctrl]+[C] to exit..." -n 1 -r

if [ -z "$GC_DEPLOY_SERVICE_ACCOUNT" ]; then
  echo "expecting ENV var GC_DEPLOY_SERVICE_ACCOUNT"
  exit 1
fi
if [ -z "$GC_PROJECT_ID" ]; then
  echo "expecting ENV var GC_PROJECT_ID"
  exit 1
fi

GC_SERVICE_ACCOUNT_FQ="$GC_DEPLOY_SERVICE_ACCOUNT@${GC_PROJECT_ID}.iam.gserviceaccount.com"

gcloud projects add-iam-policy-binding ${GC_PROJECT_ID} \
    --member=serviceAccount:${GC_SERVICE_ACCOUNT_FQ} \
    --role=roles/container.admin
gcloud projects add-iam-policy-binding ${GC_PROJECT_ID} \
    --member=serviceAccount:${GC_SERVICE_ACCOUNT_FQ} \
    --role=roles/run.admin
gcloud projects add-iam-policy-binding ${GC_PROJECT_ID} \
    --member=serviceAccount:${GC_SERVICE_ACCOUNT_FQ} \
    --role=roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding ${GC_PROJECT_ID} \
    --member=serviceAccount:${GC_SERVICE_ACCOUNT_FQ} \
    --role=roles/cloudbuild.builds.editor
gcloud projects add-iam-policy-binding ${GC_PROJECT_ID} \
    --member=serviceAccount:${GC_SERVICE_ACCOUNT_FQ} \
    --role=roles/storage.objectAdmin
gcloud projects add-iam-policy-binding ${GC_PROJECT_ID} \
    --member=serviceAccount:${GC_SERVICE_ACCOUNT_FQ} \
    --role=roles/storage.admin
gcloud projects add-iam-policy-binding ${GC_PROJECT_ID} \
    --member=serviceAccount:${GC_SERVICE_ACCOUNT_FQ} \
    --role=roles/artifactregistry.admin


gcloud services disable cloudbuild.googleapis.com --project=$GC_PROJECT_ID
gcloud services enable cloudbuild.googleapis.com --project=$GC_PROJECT_ID

#gcloud beta run deploy playground-cloud-run-jvm --quiet --platform managed --region europe-west1 --source ./cloud-run-jvm --project playground-361314 --format json