pipeline {
    agent any

    triggers {
        pollSCM('* * * * *') //every minute
    }

    environment {
        USER_ARN = credentials('USER_ARN')
    }

    stages {
        stage("Checkout") {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage("Terraform INIT") {
            steps {
                dir('eks-terraform') {
                    script {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage("Terraform PLAN") {
            steps {
                dir('eks-terraform') {
                    script {
                        sh 'terraform plan -var="user_arn=${USER_ARN}" -out=tfplan'
                    }
                }
            }
        }
        stage("Terraform APPLY") {
            steps {
                dir('eks-terraform') {
                    script {
                        sh 'terraform apply -var="user_arn=${USER_ARN}" -auto-approve '
                    }
                }
            }
        }
    }
}