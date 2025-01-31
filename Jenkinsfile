pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('jenkins-example')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'pramaneni', url: 'https://github.com/pramaneni/terraform.git']]])
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
            post {
                always {
                    steps { // <-- Add steps here
                        archiveArtifacts 'tfplan'
                    }
                }
                failure {
                    steps { // <-- Add steps here
                        echo "Terraform plan failed. Check the console logs."
                        // Add notification logic here
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: 'Are you sure you want to apply this Terraform plan?'
                sh 'terraform apply tfplan'
            }
            post {
                always {
                    steps { // <-- Add steps here
                        // Archive logs or other artifacts (optional)
                    }
                }
                failure {
                    steps { // <-- Add steps here
                        echo "Terraform apply failed. Check the console logs."
                        // Add notification logic here
                    }
                }
                success {
                    steps { // <-- Add steps here
                        echo "Terraform apply successful."
                    }
                }
            }
        }
    }
}
