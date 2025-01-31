pipeline {
    agent any

    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('jenkins-example') // GCP service account key in Jenkins credentials
    }

    stages {
        stage ("Checkout Code") {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage ("Initialize Terraform") {
            steps {
                script {
                    sh "terraform init"
                }
            }
        }

        stage ("Validate Terraform") {
            steps {
                script {
                    sh "terraform validate"
                }
            }
        }

        stage ("Terraform Plan") {
            steps {
                script {
                    sh "terraform plan -out=tfplan"
                }
            }
        }

        stage ("Apply Terraform") {
            steps {
                script {
                    sh "terraform apply -auto-approve tfplan"
                }
            }
        }

        stage ("Show Output") {
            steps {
                script {
                    sh "terraform output"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Terraform deployment completed successfully!"
        }
        failure {
            echo "❌ Terraform deployment failed. Check logs for errors."
        }
    }
}
