variable "region" {
  default = "us-central1"
}

variable "gcp_project" {
  default = "internal-interview-candidates"
}



variable "project_name" {
  default = "gcp"
}
variable "subnet_cidr" {
  default = "10.10.0.0/24"
}

variable "scopes_default_web" {
  default = [
    "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/compute.readonly",
  ]
}

variable "zone" {
  default = "us-central1-a"
}

# variable "image_web" {
#   default = "debian-cloud/debian-10"
# }

# variable "machine_type_web" {
#   default = "n1-standard-1"
# }

variable "ssh_user" {
  default = "admin"
}

variable "ssh_pub_key_file" {
  default = "ssh-key.pub"
}

variable "webservers" {
  type = list(object({
    type  = string
    image = string
    name  = string
  }))

  default = [
    {
      image = "debian-cloud/debian-10"
      type  = "n1-standard-1"
      name  = "server1"
    },
    {
      image = "debian-cloud/debian-10"
      type  = "n1-standard-1"
      name  = "server2"
    }
  ]
}