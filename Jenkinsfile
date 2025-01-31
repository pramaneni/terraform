pipeline {
  agent any
  environment {
     GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sa')
  }
  stages {
     stage ("connecting to git") {
        steps{
          git branch : "master", url : "https://github.com/pramaneni/terraform.git"
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
