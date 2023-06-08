pipeline {
    agent any
   
    stages {
        stage('Build') {
            steps {
              sh '''
                echo 'Build de Jenkins'
                '''
            }
        }
             stage('Test') {
            steps {
              sh '''
                echo 'Test de Jenkins'
                '''
            }
        }
      
             stage('Push') {
            steps {
              sh '''
                echo 'Push de Jenkins'
                '''
            }
        }
      
          stage('Deploy to K8s') {
          environment {
            CREDENTIAL = credentials('CREDENTIALS')
            KUBE_CONFIG = credentials('config')
          }
            steps {
              sh '''
                  rm -Rf .kube
                  mkdir .kube
                  cat $KUBE_CONFIG > .kube/config
                  
                  rm -Rf .aws
                  mkdir .aws
                  cat $CREDENTIAL > .aws/credentials
                  ls 
                  cat .kube/config
                  cat .aws/credentials
                  kubectl get nodes
                '''
            }
        }
    }
}
