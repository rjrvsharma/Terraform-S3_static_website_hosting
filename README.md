# Terraform-S3_static_website_hosting

# Terraform AWS S3 Static Website Hosting

## Project Overview

This project uses Terraform to provision an Amazon S3 bucket and host a static website. The website consists of:

* `index.html` - Main website page
* `error.html` - Custom error page

Terraform uploads both files to the S3 bucket and configures the bucket for static website hosting.

---

## Architecture

Terraform creates and configures the following AWS resources:

1. S3 Bucket
2. S3 Bucket Ownership Controls
3. S3 Public Access Configuration
4. S3 Bucket ACL
5. S3 Objects (index.html and error.html)
6. S3 Website Configuration

---

## Prerequisites

Before running this project, ensure you have:

* AWS Account
* AWS CLI configured
* Terraform installed
* IAM user with S3 permissions

Verify installations:

```bash
terraform version
aws sts get-caller-identity
```

---

## Project Structure

```text
.
├── main.tf
├── variables.tf
├── terraform.tfvars
├── index.html
├── error.html
└── README.md
```

---

## Terraform Resources

### S3 Bucket

Creates a new S3 bucket.

```hcl
resource "aws_s3_bucket" "mybucket"
```

### Ownership Controls

Sets bucket ownership preferences.

```hcl
resource "aws_s3_bucket_ownership_controls" "ownership"
```

### Public Access Block

Allows public website access by disabling public access restrictions.

```hcl
resource "aws_s3_bucket_public_access_block" "puclicaccess"
```

### Bucket ACL

Makes bucket objects publicly readable.

```hcl
resource "aws_s3_bucket_acl" "aclaccess"
```

### S3 Objects

Uploads website files.

```hcl
resource "aws_s3_object" "index"
resource "aws_s3_object" "error"
```

### Website Configuration

Configures S3 static website hosting.

```hcl
resource "aws_s3_bucket_website_configuration" "website"
```

---

## Deployment Steps

### Initialize Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Review Changes

```bash
terraform plan
```

### Deploy Resources

```bash
terraform apply
```

Type:

```text
yes
```

when prompted.

---

## Access Website

After deployment, retrieve the website endpoint:

```bash
terraform state show aws_s3_bucket_website_configuration.website
```

Example:

```text
http://my-bucket.s3-website-us-east-1.amazonaws.com
```

Open the URL in a browser to view the website.

---

## Destroy Resources

To remove all resources:

```bash
terraform destroy
```

---

## Learning Objectives

This project demonstrates:

* Infrastructure as Code (IaC)
* Terraform resource management
* AWS S3 bucket creation
* Static website hosting
* Object uploads using Terraform
* Public access configuration
* Website endpoint configuration

---

## Author

Created using Terraform and AWS S3 Static Website Hosting.
