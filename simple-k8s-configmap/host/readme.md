# Purpose

Demonstrate a sample WebAPI is hosted into Kubernetes running using DockerDesktop

# Environment
- ASP.Net WebAPI on .Net 5
- Docker Desktop
- Windows 10
- Visual Studio 2019

# How to run
- Clone.
- Compile the project and make sure its running using Docker.
- Build the image
- Push the newly created image to repository.
  - The sample uses Docker Hub for images
- Apply the file k8s-docker-desktop-deploy.yml using kubectl
- Get the list of services in the deployment and get the NodePort number
- Navigate to http://localhost:<port number>/WeatherForecast

The API will return random weather data.

# Points to note
- The K8s file k8s-docker-desktop-deploy.yml is targeted to deploy into local dev environments that run using Docker Desktop
- If it needs to be deployed to cloud such as Azure the service needs to use LoadBalancer instead of NodePort  
- The container expose 443 and 80 ports. But the K8s yaml file uses only port 80. This is on the assumption that with in K8s cluster pods/containers can communicate without http(s)
  - Enabling http(s) requires certificate and that is not in the scope of this PoC
