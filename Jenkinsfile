pipeline {
    agent any
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('jenkins-example') // Your Google Cloud credentials ID
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'pramaneni', url: 'https://github.com/pramaneni/terraform.git']]])
                // OR, simpler git step (if you're sure about the branch name):
                // git branch: 'master', credentialsId: 'YOUR_GIT_CREDENTIALS_ID', url: 'https://github.com/pramaneni/terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan' // Save plan for later apply
            }
            post {
                always {
                    archiveArtifacts 'tfplan' // Archive the plan (optional but good practice)
                }
                failure {
                  echo "Terraform plan failed. Check the console logs."
                  // Add notification logic here (email, Slack, etc.)
                }
            }
        }

        stage('Terraform Apply') {
            // Removed -auto-approve for safety.  Now requires manual approval.
            input message: 'Are you sure you want to apply this Terraform plan?'
            steps {
                sh 'terraform apply tfplan' // Apply the previously generated plan
            }
            post {
                always {
                  // Archive logs or other artifacts (optional)
                }
                failure {
                  echo "Terraform apply failed. Check the console logs."
                  // Add notification logic here
                }
                success {
                  echo "Terraform apply successful."
                }
            }
        }
    }
}
