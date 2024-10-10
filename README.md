# Bootstrap Exchange automation
This repository includes IaC code for bootstrapping an Automation Account with a System Assigned Managed Identity and permissions to manage Exchange Online. 

## Terraform
IaC with Terraform works. Run the bootstrap by typing:

```
az login
cd tf
terraform init
terraform apply -var="subscription_id=<subscription id>"
```

## Bicep
IaC with Bicep does not work yet. The code is missing functionality for assigning the **"Exchange Administrator"** directory role to the managed identity. This is not yet supported in the Microsoft Graph Bicep extension, so we're just going to have to wait patiently.
