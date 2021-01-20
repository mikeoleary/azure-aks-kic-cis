# Setting up ingress
Follow these instructions to deploy a basic hello world app, and have it exposed via the nginx ingress controller

## Hello app deployment
These instructions will deploy the hello world app.

1. Make sure you are in the current directory, ie., cd to app/helloworld from the root of this repo. Also, set your kube_config file by copying the file that was created from the infra build, or set an environment variable.

````bash
    #change directory to current
    cd ../app/helloworld
    #update your kube config file
    mv ../../infra/kube_config ~/.kube/config
    #or, set an environment variable
    export KUBECONFIG=../../infra/kube_config
````

2. Run these commands to deploy the resources defined in them

````bash
    #create a new namespace for this app
    kubectl apply -f ns.yaml
    #deploy the app. We'll make a replica set of 3 pods
    kubectl apply -f deployment.yaml
    #expose the pods as a service on port 80
    kubectl apply -f service.yaml
    #create an ingress resource that KIC will configure KIC to route traffic to these pods
    kubectl apply -f ingress.yaml
````

## Delete app 
When you are ready to delete the app, delete in reverse order:
````bash
    #delete ingress 
    kubectl delete -f ingress.yaml
    #delete the service
    kubectl delete -f service.yaml
    #delete the deployment
    kubectl delete -f deployment.yaml
    #delete namespace
    kubectl delete -f ns.yaml
````