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
4. Make new directory to stored credentials json file that we had previously downloaded.
```bash
mkdir -p .gcp/credentials
```
Move the credentials file we downloaded before.
5. 
6. df
