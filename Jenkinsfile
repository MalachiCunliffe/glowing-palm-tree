def paramOperationList = ['validate','create', 'destroy']

pipeline {
    agent {
        docker {
          alwaysPull true
          image 'hashicorp/terraform:latest'
          args '--entrypoint='
        }
      }

    parameters {
    choice(name: 'Operation', choices: paramOperationList, description: 'Operation to perform.')
  }
  options {
    ansiColor('xterm')
    buildDiscarder(logRotator(numToKeepStr:'10'))
  }
      stages {
        stage('terraform init') {
          steps {
            echo "terraform init"

            withCredentials([usernamePassword(credentialsId: 'aws-demo-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable :'AWS_SECRET_ACCESS_KEY'),]) {
                sh '''
                terraform fmt
                terraform version
                terraform init
                '''
            }
          }
        }
        stage('terraform validate') {
          steps {

            withCredentials([usernamePassword(credentialsId: 'aws-demo-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable :'AWS_SECRET_ACCESS_KEY'),]) {
                sh '''
                terraform validate
                '''
            }
          }
        }
        stage('terraform plan') {
          when {
            equals expected: "create", actual: "${params.Operation}"
          }
        steps {
            echo "terraform plan"

            withCredentials([usernamePassword(credentialsId: 'aws-demo-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable :'AWS_SECRET_ACCESS_KEY'),]) {
                sh '''
                terraform plan -out=current.plan
                '''
            }
          }
        }
        stage('terraform apply') {
          when {
            equals expected: "create", actual: "${params.Operation}"
          }
          steps {
            echo "terraform apply"
            withCredentials([usernamePassword(credentialsId: 'aws-demo-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable :'AWS_SECRET_ACCESS_KEY'),]) {
                sh '''
                terraform apply current.plan
                '''
            }
          }
        }
        stage("terraform plan --destroy"){
          when {
            equals expected: "destroy", actual: "${params.Operation}"
          }
          steps {
            echo "terraform plan"

            withCredentials([usernamePassword(credentialsId: 'aws-demo-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable :'AWS_SECRET_ACCESS_KEY'),]) {
                sh '''
                terraform plan -destroy -out=current.plan
                '''
            }
          }
        }
        
        stage('terraform apply --destroy') {
          when {
            equals expected: "destroy", actual: "${params.Operation}"
          }
          steps {
            echo "terraform apply"
            withCredentials([usernamePassword(credentialsId: 'aws-demo-key', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable :'AWS_SECRET_ACCESS_KEY'),]) {
                sh '''
                terraform apply current.plan
                '''
            }
          }
        }


      }
      }