pipeline {
    environment {
        REPOSITORY_PREFIX: "885801475464.dkr.ecr.eu-west-3.amazonaws.com/ecr-petclinic"
    }
    agent any
   
    stages {
      stage('Build Images') {
        steps {
          script{
          sh '''
            mvn spring-boot:build-image -Pk8s -DREPOSITORY_PREFIX=${REPOSITORY_PREFIX}
            echo 'Images built'
            sleep 6
            '''
            }
        }
      }
      stage('Push Images') {
        steps {
          withAWS(credentials: 'aws-credentials', region: 'eu-west-3') {
          sh '''
            docker push $REPOSITORY_PREFIX:spring-petclinic-cloud-api-gateway
            docker push $REPOSITORY_PREFIX:spring-petclinic-cloud-visits-service
            docker push $REPOSITORY_PREFIX:spring-petclinic-cloud-vets-service
            docker push $REPOSITORY_PREFIX:spring-petclinic-cloud-customers-service
            '''
            }
        }
      }
      stage('Deploy with helm on dev') {
        steps {
          withAWS(credentials: 'aws-credentials', region: 'eu-west-3') {
          sh '''
            rm -Rf ~/.kube
            aws eks update-kubeconfig --name eks-petclinic
            helm upgrade --install helm-chart ./helm --values=./helm/values.yaml --kubeconfig ~/.kube/config --namespace dev --create-namespace
            '''
            }
        }
      }
    }
}
