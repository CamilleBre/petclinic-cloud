helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install vets-db-mysql bitnami/mysql --namespace spring-petclinic  --set auth.database=service_instance_db --set primary.persistence.enabled=false --set secondary.persistence.enabled=false
helm install visits-db-mysql bitnami/mysql --namespace spring-petclinic   --set auth.database=service_instance_db --set primary.persistence.enabled=false --set secondary.persistence.enabled=false
helm install customers-db-mysql bitnami/mysql --namespace spring-petclinic   --set auth.database=service_instance_db --set primary.persistence.enabled=false --set secondary.persistence.enabled=false
