# Reproduce project
## Setup GCP project
Create new [GCP project](https://console.cloud.google.com/).

<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/db359421-a2f1-491d-852b-0ed9ae4b4781" width="50%" align="center"/>
</p>

## Create Virtual Machine
Once you have a GCP project created, enable the Compute Engine API.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/6b0dad26-bc88-40d0-8310-2706fe92a4f0" width="50%" align="center"/>
</p>

Then go to Compute Engine and create a new instance considering this parameters:
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
Go to IAM service and then to Service Accounts tab.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/6540e304-8095-4203-87fa-195c5a9160fe" height="50%" align="center"/>
</p>
Create a service account.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/ef0e2516-ba0e-41b3-88ca-7bf3aeaba90d" height="50%" align="center"/>
</p>
Grant the following roles to service account:

- Viewer
- Storage Admim
- Storage Object Admin
- BigQuery Admin
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/002f1030-3607-4258-8ff0-465601d13ff8" height="50%" align="center"/>
</p>

Click continue and navigate to the right side three dots and click on manage keys and follow this: Add Key, Create new key, JSON and finally create key, then it will be downloaded on your pc.

<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/d40d6095-67ad-43d7-8158-8fc21024e5ad" height="50%" align="center"/>
</p>

## Setup VM SSH Access
Open a terminal in your pc and run the following command:
```bash
ssh-keygen -t rsa -f ~/.ssh/vm-gcp -C jeanpaul -b 2048
```
Once you have key generated, check the pub file content and copy to your clipboard.
Go to Metadata, click Add SSH Key, copy pub file content there and finally save it.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/a4571b5f-febc-48f4-be03-c3256d29c0a0" height="50%" align="center"/>
</p>

Create a config file into .ssh path and copy the following content:
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
One you have all the configurations done.
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
2. Once Terraform is already installed, move to terraform project directory and edit project name
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/ab788601-f370-4584-9b80-506d5262944e" height="50%" align="center"/>
</p>
3. Then run
```bash
terraform init
terraform apply
```
4. dfdf
