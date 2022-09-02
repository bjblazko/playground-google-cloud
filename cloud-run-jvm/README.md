# Google Cloud Run (JVM) example

## Local development

You can run your application in dev mode that enables live coding using:
```shell script
./mvnw compile quarkus:dev
```

> **_NOTE:_**  Quarkus now ships with a Dev UI, which is available in dev mode only at http://localhost:8080/q/dev/.

## Deployment to Google Cloud

This example uses Github actions and the workflow is defined in ../.github

### Requirements prior 1st deployment

- You must have set up a Google Cloud project
- Create a service account (dedicated for deployment) with these roles:
  - ?
  - serviceusage.services.use
- the following APIs have to be enabled:
  - [Artifact Registry API](https://console.cloud.google.com/marketplace/product/google/artifactregistry.googleapis.com)
  - [Cloud Run (Admin?) API](https://console.cloud.google.com/apis/library/run.googleapis.com)
  - 