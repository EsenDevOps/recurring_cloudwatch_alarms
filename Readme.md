# Recurring cloudwatch alarms

The recurring alarms script automates the process of setting up recurring CloudWatch alarms for AWS resources.

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
- region, region in which resources will be provisioned (by default "us-east-1")
- tag_for_repeated_notificationtag_for_repeated_notification, tag that you need to add to cloudwatch alarm, should be "key:value" string (by default "RepeatedAlarm:true")
- wait_seconds, interval between messages, it must be a number (by default 5)  
3. init terraform ```terraform init ```
4. run ```terraform apply -var-file=variables.tfvars```

## Notes
1. these scripts cannot be run in China regions
2. script doesn't craete cloudwatch alarm, do it on your own, don't forget to add tag, you specified in variables.tfvars file
