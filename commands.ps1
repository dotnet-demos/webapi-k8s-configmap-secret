##################### Build with tag and push ########################
docker build -t joymon/simplek8sconfiguration:0.0.1 -f .\host\Dockerfile .
# Note that the above command build in production configuration
docker push joymon/simplek8sconfiguration:0.0.1

##################### Start simplek8s-env-vars ########################
kubectl apply -f .\host\k8s-docker-desktop-env-var-deploy.yml
kubectl get all -n=simplek8s-env-vars
kubectl describe service/webapiservice -n simplek8s-env-vars
# Get the NodePort number from above 
# http://localhost:<NodePort>/Echo
# To clean up
kubectl delete namespace simplek8s-env-vars
#################### Ending simplek8s-env-vars ########################

####################### Start simplek8s-secrets #######################
kubectl apply -f .\host\k8s-docker-desktop-secret-deploy.yml
kubectl get all -n=simplek8s-secret

kubectl get secret -n=simplek8s-secret
kubectl describe secrets/secret-map -n=simplek8s-secret
kubectl get secret secret-map -o jsonpath='{.data}' -n=simplek8s-secret
kubectl get secret secret-map -o jsonpath='{.data.MySecret}' -n=simplek8s-secret

# Change secret dring runtime
kubectl delete secret secret-map "MySecret" -n=simplek8s-secret
kubectl create secret generic secret-map --from-literal=MySecret=MYS3c6et -n simplek8s-secret
# Delete the pods to get updated value. The K8s will spin up pods immediately after deletion as its mentioned in the deploymnet
kubectl delete pods -l app=weather-forecast -n simplek8s-secret
kubectl delete namespace simplek8s-secret

# Mount secret as file 
# https://base64.guru/converter/encode/file
kubectl apply -f .\host\k8s-docker-desktop-secret-file-deploy.yml
kubectl get all -n=simplek8s-secret

kubectl delete namespace simplek8s-secret

###################### Ending simplek8s-secrets #######################

################# Start simplek8s-configmap-inline ####################
kubectl apply -f .\host\k8s-docker-desktop-configmap-inline-deploy.yml
kubectl get all -n=simplek8s-configmap-inline
kubectl describe service/webapiservice -n simplek8s-configmap-inline
# Get the NodePort number from above 
# http://localhost:<NodePort>/configurations/MyKey
# Please note the /swagger end point will not work as it is compiled in production. Chanage startup.cs to get swagger in production
kubectl describe configMap appsettings-configmap -n=simplek8s-configmap-inline

# restart pods after configMap change
kubectl delete pods -l app=weather-forecast -n simplek8s-configmap-inline

# To clean up
kubectl delete -f .\host\k8s-docker-desktop-configmap-inline-deploy.yml
delete namespace simplek8s-configmap-inline
################# Ending simplek8s-configmap-inline ####################

################# Start simplek8s-configmap-file ####################
kubectl apply -f .\host\k8s-docker-desktop-configmap-file-deploy.yml
# This won't work by just using Kubectl. Require Helm to replace the file contents.
kubectl get all -n=simplek8s-configmap-file
kubectl describe service/webapiservice -n simplek8s-configmap-file

# To clean up
kubectl delete -f .\host\k8s-docker-desktop-configmap-file-deploy.yml
################# Ending simplek8s-configmap-file ####################

