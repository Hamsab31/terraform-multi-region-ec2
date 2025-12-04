# 🚀 Terraform Assignment: Launch EC2 Instances in Two AWS Regions

This project demonstrates how to use **Terraform** to launch **two EC2 instances** in **two different AWS regions** using a **single Terraform configuration file**.  
It also uses **provider aliasing**, **data sources**, **security groups**, and **multi-region deployment**.

---

## 📌 **Task Requirements**
- Use **Terraform**
- Use **AWS CLI** for authentication
- Launch **one Linux EC2 in ap-south-1 (Mumbai)**
- Launch **one Linux EC2 in us-east-1 (N. Virginia)**
- Push code + output screenshots to GitHub

---

## 🗂️ **Project Structure**

Terraform-task1/
│── main.tf
│── .gitignore
└── screenshots/

---

## ⚙️ **What This Terraform Script Does**

### ✔ Creates two AWS provider configurations  
- **Default provider** → Mumbai (`ap-south-1`)  
- **Secondary provider** → N. Virginia (`us-east-1`)

### ✔ Fetches the latest Amazon Linux 2 AMI in both regions

### ✔ Creates two Security Groups  
- `allow_ssh` → default region  
- `allow_ssh_secondary` → secondary region  

### ✔ Launches two EC2 Instances  
- `Primary-EC2-Instance`  
- `Secondary-EC2-Instance`

### ✔ Outputs the public IPs  
Printed automatically after `terraform apply`

---

## 🔧 **Prerequisites**
Install the following:

- Terraform  
- AWS CLI  
- Git  
- AWS IAM user with programmatic access

Login to AWS using:

```bash
aws configure
▶️ How to Run This Project

1️⃣ Initialize Terraform
terraform init

2️⃣ Preview the resources
terraform plan

3️⃣ Apply & create the EC2 instances
terraform apply

Type yes when prompted.

📤 Output After Apply
Terraform prints the public IPs:
primary_instance_ip   = xx.xx.xx.xx
secondary_instance_ip = yy.yy.yy.yy

📸 Screenshots Included
Inside the screenshots/ folder:
EC2 in ap-south-1
EC2 in us-east-1
Terraform output screenshot

🧹 Clean Up Resources
To avoid charges:
terraform destroy
Type yes to confirm.
