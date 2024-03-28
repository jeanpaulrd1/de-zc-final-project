# Reproduce project
## Setup GCP project
1. Create new [GCP project](https://console.cloud.google.com/).

<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/db359421-a2f1-491d-852b-0ed9ae4b4781" width="50%" align="center"/>
</p>

## Create Virtual Machine
1. Once you have a GCP project created, enable the Compute Engine API.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/6b0dad26-bc88-40d0-8310-2706fe92a4f0" width="50%" align="center"/>
</p>

2. Then go to Compute Engine and create a new instance considering this parameters:
Name: Whatever you want
Region: Closest to you
Machine Type: e2-standard-4 (4 vCPU, 2 cores, 16 GB RAM)
Boot disk: Ubuntu 20.04 LTS Size: 20GB or 30 GB

<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/22aac766-b617-4019-ad30-2ebaf97ed039" height="50%" align="center"/>
</p>

<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/1c2641af-9ed2-4327-8e05-ab129ed9afc7" height="50%" align="center"/>
</p>

<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/e2e74eb7-a3f3-4fae-a4e7-ea098a3003d9" height="50%" align="center"/>
</p>

## Create Service Account
1. Go to IAM service and then to Service Accounts tab.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/6540e304-8095-4203-87fa-195c5a9160fe" height="50%" align="center"/>
</p>
2. Create a service account.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/ef0e2516-ba0e-41b3-88ca-7bf3aeaba90d" height="50%" align="center"/>
</p>
3. Grant the following roles to service account:

- Viewer
- Storage Admim
- Storage Object Admin
- BigQuery Admin
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/002f1030-3607-4258-8ff0-465601d13ff8" height="50%" align="center"/>
</p>

4. Click continue and navigate to the right side three dots and click on manage keys and follow this: Add Key, Create new key, JSON and finally create key, then it will be downloaded on your pc.

<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/d40d6095-67ad-43d7-8158-8fc21024e5ad" height="50%" align="center"/>
</p>

## Setup VM SSH Access
1. Open a terminal in your pc and run the following command:
```bash
ssh-keygen -t rsa -f ~/.ssh/vm-gcp -C jeanpaul -b 2048
```
2. Once you have key generated, check the pub file content and copy to your clipboard.
Go to Metadata, click Add SSH Key, copy pub file content there and finally save it.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/a4571b5f-febc-48f4-be03-c3256d29c0a0" height="50%" align="center"/>
</p>

3. Create a config file into .ssh path and copy the following content:
```bash
Host <VM name>
    HostName <public IP address>
    User <user name defined on your pub file>
    IdentityFile <private key path>
```
## Setup SSH access in Visual Studio 

1. Install this extension
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/db22f086-e051-44c9-9ddc-d6b32374694d" height="50%" align="center"/>
</p>
2. Once you have the extension, go to the left hand corner and click on the following blue icon
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/8862ad74-e762-4413-9ca8-64282d05c9c7" height="50%" align="center"/>
</p>
3. Then, choose Connect to Host and enter the name you gave the VM in the config file.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/0f02262c-0675-4ce7-b1e4-f184116715d8" height="50%" align="center"/>
</p>

## Setup VM
Once you have all the configurations done.
1. Connect to VM using following command:
```bash
ssh <VM name>
```
2. Run
```bash
sudo apt-get update
```
3. Clone project repo
```bash
git clone https://github.com/jeanpaulrd1/de-zc-final-project.git
```
4. Make new directory, move there credentials json file that we had previously downloaded.
```bash
mkdir -p .gcp/credentials
```
5. Set environment variable to point to your downloaded GCP keys
```bash
export GOOGLE_APPLICATION_CREDENTIALS=~/<path/to/your/service-account-authkeys>.json

# then run
source .bashrc

gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS
```

## Setup Terraform
1. Run the following commands:
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```
2. Once Terraform is already installed, move to terraform project directory edit project name and GCS Bucket name.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/ab788601-f370-4584-9b80-506d5262944e" height="50%" align="center"/>
</p>

3. Then run
```bash
terraform init
terraform apply
```

## Run Mage

1. Install [Docker](https://docs.docker.com/engine/install/)
2. Clone Mage repo
```bash
git clone https://github.com/mage-ai/mage-zoomcamp.git mage-zoomcamp
```
3. Edit requirements.txt and add the following library
```bash
statsbombpy
```
4. Now, let's build the container
```bash
docker compose build
```
5. Finally, start the container
```bash
docker compose up
```
6. Clone repo locally
```bash
git clone https://github.com/jeanpaulrd1/de-zc-final-project.git
```
7. Enter to mage_pipelines folder and copy all the content to your local Mage folder.
8. Once it's done, navigate to [http://localhost:6789](http://localhost:6789)
9. Go to pipeline, then go Triggers, click run@once and Run now

<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/944bc5d4-e44b-419f-aecb-b94e2c409227" height="50%" align="center"/>
</p>

## Setup dbt
1. Create [dbt cloud account](https://www.getdbt.com/signup).
2. Create new project and configure Bigquery connection. Check details [here](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/04-analytics-engineering/dbt_cloud_setup.md)
3. Once you have everything set up, fork my repo https://github.com/jeanpaulrd1/de-zc-final-project.git
4. Then configure repo into dbt, copy ssh link
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/6dd8b155-c52c-4457-a0f9-a165a6c47167" height="50%" align="center"/>
</p>
5. Follow [GitHub instructions](https://docs.getdbt.com/docs/cloud/git/import-a-project-by-git-url) to configure repo 

6. Set project subdirectory as dbt
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/0d1dbaf4-37dc-45f5-af8a-476351db45dd" height="50%" align="center"/>
</p> 

7. Create prod environment
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/512322a5-1e99-49de-a003-3c5c23cc5411" height="50%" align="center"/>
  
8. Then go to Deploy, Jobs.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/2d63c53e-5314-4adc-b0f6-9dc1f45b0399" height="50%" align="center"/>
</p>

9. Create job, following these values:
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/a9548076-15a5-4a4a-bbef-bf4e12585741" height="50%" align="center"/>
</p>
10. When the job is created, click in Run Now.

11. After the job has finished running, you can query tables and views in BigQuery.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/9604b466-e710-47d9-9e90-0f2e9e7e93c8" height="50%" align="center"/>
</p>

## Create Dashboard in Looker Studio

1. Go to Looker Studio.
2. Add BigQuery connection.
3. Selected dataset previously created.
