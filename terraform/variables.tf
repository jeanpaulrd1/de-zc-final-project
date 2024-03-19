variable "credentials" {
  description = "My Credentials"
  default     = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "airy-digit-410117"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "fifa_wc_2022"
}

variable "gcs_bucket_name" {
  description = "Bucket Name to store raw data"
  default     = "fifa_wc_2022_bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}