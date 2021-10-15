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

################# Start simplek8s-configmap-inline ####################
kubectl apply -f .\host\k8s-docker-desktop-configmap-inline-deploy.yml
kubectl get all -n=simplek8s-configmap-inline
kubectl describe service/webapiservice -n simplek8s-configmap-inline
# Get the NodePort number from above 
# http://localhost:<NodePort>/echo
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

####################### Start simplek8s-secrets #######################
kubectl apply -f .\host\k8s-docker-desktop-secret-deploy.yml
kubectl get all -n=simplek8s-secret
kubectl describe service/webapiservice -n simplek8s-secret

kubectl delete pods -l app=weather-forecast -n simplek8s-secret
kubectl delete namespace simplek8s-secret
###################### Ending simplek8s-secrets #######################