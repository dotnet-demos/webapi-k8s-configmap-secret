##################### Build with tag and push ########################
docker build -t joymon/simplek8sconfigmap:0.0.1 -f .\host\Dockerfile .
docker push joymon/simplek8sconfigmap:0.0.1
#################### Start simplek8s-configmap #######################

kubectl apply -f .\host\k8s-docker-desktop-app-settings-deploy.yml
kubectl get all -n=simplek8s-configmap
kubectl describe service/webapiservice -n simplek8s-configmap
# Get the NodePort number from above 
# http://localhost:<NodePort>/echo
# http://localhost:<NodePort>/configurations/MyKey

# Please note the /swagger end point will not work as it is compiled in production. Chanage startup.cs to get swagger in production
kubectl describe configMap appsettings-configmap -n=simplek8s-configmap

# restart pods after configMap change
kubectl delete pods -l app=weather-forecast -n simplek8s-configmap

# To clean up
kubectl delete -f .\host\k8s-docker-desktop-app-settings-deploy.yml
delete namespace simplek8s-configmap
#################### Ending simplek8s-configmap #######################

##################### Start simplek8s-env-vars ########################
kubectl apply -f .\host\k8s-docker-desktop-env-var-deploy.yml
kubectl get all -n=simplek8s-env-vars
kubectl describe service/webapiservice -n simplek8s-env-vars
# To clean up
kubectl delete namespace simplek8s-env-vars
#################### Ending simplek8s-env-vars ########################

####################### Start simplek8s-secrets #######################
kubectl apply -f .\host\k8s-docker-desktop-secret-deploy.yml
kubectl get all -n=simplek8s-secret
kubectl describe service/webapiservice -n simplek8s-secret

kubectl delete pods -l app=weather-forecast -n simplek8s-secret
kubectl delete namespace simplek8s-secret
###################### Ending simplek8s-secrets #######################
