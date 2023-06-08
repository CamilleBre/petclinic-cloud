pipeline {
    agent any
   
    stages {
        stage('Setup Env Variable') {
            steps {
              sh '''
                export REPOSITORY_PREFIX=dockerdev27
                echo $REPOSITORY_PREFIX
                '''
            }
        }
             stage('Build and Push Images') {
            steps {
              sh '''
                
                ./scripts/pushImages.sh
                echo 'Images built'
                '''
            }
        }
            stage('Create namespace') {
            steps {
              sh '''
                kubectl apply -f k8s/init-namespace/
                echo 'namespace created'
                '''
            }

        }
             stage('Create services') {
            steps {
              sh '''
                kubectl apply -f k8s/init-services
                kubectl get svc -n spring-petclinic
                echo 'Services created'
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

                  ./scripts/deployToKubernetes.sh
                  echo 'Deploy done'
                '''
            }
        }
    }
}
