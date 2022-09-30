# URBAN hometask

This repository contains all the necessary code and utilities for deploying the Urban application in the **k8s** cluster using the resources of the *Google Cloud Provider*. To manage the necessary resources, the **Terraform** deployment automation tool is used.

## GCP prerequisites
First of all, you must have a GCP account with rights to create and modify resources and an existing project (you can create a new one - **$PROJECT_NAME**). So does credential **JSON** file.

Before deploying infrastructure resources, you must create a Cloud Storage Bucket to store the state of the Terraform. To do this, you need to use the **gcloud** utility:

```bash
gcloud storage buckets create gs://$TF_STATE_BUCKET_NAME --project=$PROJECT_NAME
```

for instance:

```bash
gcloud storage buckets create gs://terraform-infrastructure-urban-application --project=urban-111111
```

Enable 'versioning' feature for bucket:

```bash
gcloud storage buckets describe gs://terraform-infrastructure-urban-application --format="default(versioning)"
```

To check this feature status, you can run:

```bash
gcloud storage buckets describe gs://terraform-infrastructure-urban-application --format="default(versioning)"
```

## Github repository secrets
To grant **Terraform** rights to the GCP, you must specify a credentials **JSON**  file and save it in GitHub repository secrets (for instance: **GCP_CREDENTIALS**):
[How to ...](https://medium.com/interleap/automating-terraform-deployment-to-google-cloud-with-github-actions-17516c4fb2e5)

I also recommend keeping the following parameters in GitHub repo secrets:

 - **BUCKET_NAME** - Cloud Storage Bucket name for storing Terraform state files
 - **GCP_PROJECT** - GCP Project name (**$PROJECT_NAME**)

## Terraform specifics
The **Terraform** code is split into two main parts:
- immutable infrastructure part
- part of the code that deploys applications (orchestration)

Due to the fact that this code can be scaled to different environments within the project, the **Terraform** backend for each deployment is configured dynamically. For this purpose, it is necessary to override the **Terraform** backend settings in CI/CD pipeline:

- infrastructure:
```bash
terraform init -input=false -backend-config="bucket=$BUCKET_NAME" -backend-config="prefix=$PROJECT_NAME-$ENVIRONMENT-infrastructure"
```

- app-level:
```bash
terraform init -input=false -backend-config="bucket=$BUCKET_NAME" -backend-config="prefix=$PROJECT_NAME-$ENVIRONMENT-application"
```
When deploying **Terraform** resources in the pipeline, checking the correctness (*terraform validate*) of the code and formatting (*terraform fmt*) are used.


### CI/CD
GitHub Action was created as a **CI/CD** pipeline. It allows:
- expand all resources in GCP
- build the **Docker** image of the application, upload the image to the GS Registry
- deploy the application image to the k8s cluster and open access to the application

The pipeline uses a number of variables that allow you to customize the ability to scale the application. You can change them and add new ones for finer customization and more flexibility.

 - **GCP_REGION** - the variable defines the GCP region
 - **APP_NAME** - Urban application name
 - **APP_LABEL** - Urban application label

When starting the CI/CD pipeline, you must specify the **environment** and the **version** of the application (default value is not accepted: **v0.0.0**)