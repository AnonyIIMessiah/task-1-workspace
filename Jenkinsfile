pipeline {
    agent any

    triggers {
        pollSCM('* * * * *') //every minute
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
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }
        stage("Terraform APPLY") {
            steps {
                dir('eks-terraform') {
                    script {
                        sh 'terraform apply -auto-approve '
                    }
                }
            }
        }
    }
}