Username : pscandidate04@gmail.com
Project: internal-interview-candidates

================================================

1. Use Application Default Credentials (ADC):
`gcloud auth application-default login`


1. List all GCP Projects:
`gcloud projects list`

1. Set active Project:
`gcloud config set project internal-interview-candidates

1. Use Service Account Credentials:
```
gcloud iam service-accounts create prod-svc

gcloud projects add-iam-policy-binding internal-interview-candidates --member="serviceAccount:prod-svc@internal-interview-candidates.iam.gserviceaccount.com" --role="roles/owner"

gcloud iam service-accounts keys create prod-svc-creds2.json --iam-account=prod-svc@internal-interview-candidates.iam.gserviceaccount.com



```

1. Set GCP Credentials:
`export GOOGLE_APPLICATION_CREDENTIALS=<Path to service account JSON key>`

1. Set ssh username (Optional):
`export TF_VAR_username=$(whoami)`

1. Run init
`terraform init`

1. Run init
`terraform fmt'

1. Run Validate
`terraform validate`

1. Run Apply
`terraform apply`



# login: 
ssh -i ssh-key admin@34.67.249.152  ## first node
ssh -i ssh-key admin@104.154.136.219  ## Second node

# save and start simple Flask server:
python app.py

# test accessibility:
curl http://34.69.49.97:5000/

or  Simply access from your browser:

http://34.69.49.97:5000/


Thanks to Terraform.


