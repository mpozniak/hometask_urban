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

There are following GitHub Actions (CI/CD pipelines):
- **Deploy GCP infrastructure** (deploy_infrastructure.yaml) - Deploy all required GCP resources in the cloud. Triggered only when changes are made to terraform files (**.tf) in the 'main' branch
- **Build app Docker image and Deploy app** (build_and_deploy.yaml) - Build an app Docker image and deploy an image to k8s cluster. Added a security/vulnerability check for the generated final Docker image
- **-= !!! Terraform DESTROY !!! =- (destroy all provisioned GCP resources)** (terraform_destroy.yaml) - Destroy the application deployment resources and any generated GCP resources
- **Terraform FMT (shift left: code formating check)** (terraform_fmt.yaml) - is used to check/rewrite Terraform configuration files to a canonical format and style. This GitHub action applies a subset of the Terraform language style conventions, along with other minor adjustments for readability

The pipeline uses a number of variables that allow you to customize the ability to scale the application. You can change them and add new ones for finer customization and more flexibility.

 - **GCP_REGION** - the variable defines the GCP region
 - **APP_NAME** - Urban application name
 - **APP_LABEL** - Urban application label

When starting the CI/CD **'Build app Docker image and Deploy app'** pipeline, you must specify the **environment** and the **version** of the application (default value is not accepted: **v0.0.0**)

## App access
You can access the application using the 'Build app Docker image and Deploy app' pipeline's output 'load_balancer_ip' parameter (for instance: load_balancer_ip = "34.82.60.243").

## 'Metrics' endpoint
An additional '/metrics' endpoint has been added to the application using the 'prom-client' package. It can be used to collect node.js statistics and additionally, custome metric: 'responses_count' - a request counter.


## Improvements
- add triggers on 'main' branch tagging and use the tag to version the application (Docker image tag, k8s deployment version)
- use separate repositories for terraform modules and use tags to determine code readiness - stable to use in production, testable in test/feature/developmen environments
- move terraform code check from a separate GitHub action to precommit hooks - shift to the left closer to development
- consolidate network related resources into one 'network.tf' file
- add tls termination to ingress (redirect from http (tcp/80) to https (tcp/443))
- add human readable DNS name
- delete all branches related to closed PRs