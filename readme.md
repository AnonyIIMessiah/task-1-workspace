
# Task 1 Workspace – AWS EKS with Terraform & Jenkins

This repository provides a structured approach to provisioning and managing an AWS Elastic Kubernetes Service (EKS) cluster using Terraform, with continuous integration and deployment facilitated by Jenkins.

---

## 📁 Repository Structure

The repository is organized as follows:

```
task-1-workspace/
├── eks-terraform/
├── jenkins/
├── terraform_files/
├── .gitignore
├── Jenkinsfile
├── readme.md
├── start.sh
├── stop.sh
└── testFile
```

- `eks-terraform/`: Contains Terraform configurations for setting up the EKS cluster.
- `jenkins/`: Holds Jenkins-related configurations and scripts.
- `terraform_files/`: Contains Terraform files for jenkins Server.
- `.gitignore`: Specifies files and directories to be ignored by Git.
- `Jenkinsfile`: Defines the Jenkins pipeline for automated deployments.
- `readme.md`: Provides an overview and instructions for the project.
- `start.sh`: Shell script to initiate the infrastructure setup.
- `stop.sh`: Shell script to tear down the infrastructure.
- `testFile`: Placeholder or test file for validation purposes.

---

## 🛠️ Prerequisites

Ensure the following are installed and configured:

- AWS CLI
- kubectl
- Terraform
- Jenkins
- AWS credentials with appropriate permissions

---

## 🚀 Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/AnonyIIMessiah/task-1-workspace.git
   cd task-1-workspace
   ```

2. **Initialize and Apply Terraform Configurations**

   Navigate to the `eks-terraform/` directory and execute:

   ```bash
   terraform init
   terraform apply
   ```

   This will provision the EKS cluster as defined in the Terraform configurations.

3. **Configure kubectl**

   After the EKS cluster is up and running, configure `kubectl` to interact with it:

   ```bash
   aws eks update-kubeconfig --name task-eks --region ap-south-1
   ```

   This command updates your kubeconfig file with the new cluster's details.

4. **Start the Infrastructure**

   Execute the `start.sh` script to initiate any additional setup or services:

   ```bash
   ./start.sh
   ```

5. **Stop the Infrastructure**

   To tear down the infrastructure, run the `stop.sh` script:

   ```bash
   ./stop.sh
   ```

---

## ⚙️ Jenkins Integration

The `Jenkinsfile` defines the CI/CD pipeline for automating deployments.
Ensure Jenkins is set up and configured to use this pipeline for continuous integration and deployment processes.

---

## 📄 License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## 🤝 Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any enhancements or bug fixes.

---

For more information on setting up and managing AWS EKS clusters with Terraform and Jenkins, refer to the official documentation:

- AWS EKS Documentation: https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html
- Terraform AWS Provider: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- Jenkins Documentation: https://www.jenkins.io/doc/
