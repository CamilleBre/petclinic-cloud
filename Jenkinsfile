pipeline {
    environment {
        DOCKERHUB_ID = "dockerdev27"
        DOCKERHUB_PASSWORD = credentials('dockerhub_password')
        KUBE_CONFIG = credentials('config')
CREDENTIAL = credentials('CREDENTIALS')
        REPOSITORY_PREFIX= "dockerdev27"
    }
    agent any
   
    stages {
        stage('Setup Env Variable') {
            steps {
              sh '''
                export REPOSITORY_PREFIX=$DOCKERHUB_ID
                echo $REPOSITORY_PREFIX
                '''
            }
        }
             stage('Build and Push Images') {
            steps {
              sh '''
                ls ./scripts/ 
                docker login -u $DOCKERHUB_ID -p $DOCKERHUB_PASSWORD
                mvn spring-boot:build-image -Pk8s -DREPOSITORY_PREFIX=$DOCKERHUB_ID 
                docker push $DOCKERHUB_ID/spring-petclinic-cloud-api-gateway:latest
                docker push $DOCKERHUB_ID/spring-petclinic-cloud-visits-service:latest
                docker push $DOCKERHUB_ID/spring-petclinic-cloud-vets-service:latest
                docker push $DOCKERHUB_ID/spring-petclinic-cloud-customers-service:latest
                docker push $DOCKERHUB_ID/spring-petclinic-cloud-admin-server:latest
                docker push $DOCKERHUB_ID/spring-petclinic-cloud-discovery-service:latest
                docker push $DOCKERHUB_ID/spring-petclinic-cloud-config-server:latest
                echo 'Images built'
                '''
            }
        }
        
        
            stage('Create namespace') {
               
            steps {
              sh '''
                rm -Rf ~/.kube 
                mkdir ~/.kube
                cat $KUBE_CONFIG > ~/.kube/config
                  
                rm -Rf ~/.aws
                mkdir ~/.aws
                cat $CREDENTIAL > ~/.aws/credentials
                ls 
                cat ~/.kube/config
                cat ~/.aws/credentials
                kubectl get nodes
                sudo kubectl create namespace spring-petclinic
                echo 'namespace created'
                '''
            }

        }
             stage('Create services') {
            steps {
              sh '''
                sudo kubectl apply -f k8s/init-services
                sudo kubectl get svc -n spring-petclinic
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


                  ./scripts/deployToKubernetes.sh
                  echo 'Deploy done'
                '''
            }
        }
    }
}
