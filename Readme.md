# Recurring cloudwatch alarms

## Prereqesuites

```
# Terraform
    # Mac
        brew tap hashicorp/tap
        brew install hashicorp/tap/terraform
    # Linux
        sudo yum install -y yum-utils shadow-utils
        sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
        sudo yum -y install terraform 
    # Windows
        install here https://developer.hashicorp.com/terraform/downloads?product_intent=terraform
# AWS CLI
    # Mac
        brew install awscli
    # Linux/Windows
        install here https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
```

## Usage

1. cd into repositoty directory ```cd ./recurring_cloudwatch_alarms```
2. change variables in variables.tfvars file if needed
3. init terraform ```terraform init ```
4. run ```terraform apply -var-file=variables.tfvars```

## Notes
1. these scripts cannot be run in China regions.