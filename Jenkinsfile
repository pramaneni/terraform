pipeline {
  agent any
  environment {
     GOOGLE_APPLICATION_CREDENTIALS = credentials('jenkins-example')
  }
  stages {
     stage ("connecting to git") {
        steps{
          git branch : "main", url : "https://github.com/pramaneni/terraform.git"
        }
    }

    stage ("terraform initlation"){
        steps{
          sh "terraform init"
          sh "terraform plan"
          sh "terraform apply -auto-approve"  
        }
    }
  }

}
