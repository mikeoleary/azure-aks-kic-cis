# Setting up ingress
Follow these instructions to configure ingress to your cluster with F5 CIS and NGINX Ingress Controller

## F5 CIS (<b>C</b>ontroller <b>I</b>ngress <b>S</b>ervices)
These instructions will configure 2x CIS instances.

1. (Optional. Only required if you changed default variables.) Edit the file ````cis/secret_sa_rbac.yaml```` so that the password is the <b>base64 encoded</b> password of the admin account on F5 BIG-IP.
2. (Optional. Only required if you changed default variables.) Edit the file ````cis/cis1.yaml```` so that the fields below are updated
````bash
    "--bigip-url=`<mgmt ip of bigip>`",
    "--bigip-partition=`<partition on bigip to manage>`",
````
3. (Optional. Only required if you changed default variables.) Edit the file ````cis/cis2.yaml```` so that the fields below are updated
````bash
    "--bigip-url=`<mgmt ip of bigip>`",
    "--bigip-partition=`<partition on bigip to manage>`",
````
4. (Optional. Only required if you changed default variables.) Edit the file ````cis/crd/virtualserver.yaml```` so that the field ````virtualServerAddress```` below is updated to your desired IP address for your VIP:

````yaml
apiVersion: "cis.f5.com/v1"
kind: VirtualServer
metadata:
  name: hello-world-virtual-server
  namespace: nginx-ingress
  labels:
    f5cr: "true"
spec:
  tlsProfileName: hello-world-tls  # --> This will attach hello-world-tls TLSProfile
  virtualServerAddress: "10.0.2.100"
  pools:
  - path: /
    service: nginx-ingress
    servicePort: 80
    monitor:
      type: http
      interval: 10
      timeout: 31
      send: "/"
````
5. Set your kube_config file by copying the file that was created from the infra build, or set an environment variable.

````bash
    #update your kube config file
    mv ../infra/kube_config ~/.kube/config
    #or, set an environment variable
    export KUBECONFIG=../infra/kube_config
````
6. Then deploy CIS in your cluster with the commands:
````bash
    #create required CRD's
    kubectl apply -f cis/crd-definition/customresourcedefinitions.yaml
    #create the Kubernetes secret, service account, and rbac resources in your cluster
    kubectl apply -f cis/secret_sa_rbac.yaml
    #deploy CIS
    kubectl apply -f cis/cis1.yaml
    kubectl apply -f cis/cis2.yaml
````

## NGINX Ingress Controller (referred to as KIC, for <b>K</b>ubernetes <b>I</b>ngress <b>C</b>ontroller)
These instructions will configure NGINX Ingress Controller

1.  Run the following commands to create the resources in Kubernetes that make up NGINX ingress controller.
````bash
    #create namespace, rbac, tls, configmap, and ingress class to support KIC
    kubectl apply -f nginx/common/ns-and-sa.yaml
    kubectl apply -f nginx/rbac/rbac.yaml
    kubectl apply -f nginx/common/default-server-secret.yaml
    kubectl apply -f nginx/common/nginx-config.yaml
    kubectl apply -f nginx/common/ingress-class.yaml
    
    #Create CRD's
    kubectl apply -f nginx/crd/vs-definition.yaml
    kubectl apply -f nginx/crd/vsr-definition.yaml
    kubectl apply -f nginx/crd/ts-definition.yaml
    kubectl apply -f nginx/crd/policy-definition.yaml
    
    #Run the Ingress Controller
    kubectl apply -f nginx/deployment/nginx-ingress.yaml
````
2. Run the commands to create a service to expose the ingress controller pods
````bash
    #Create NGINX ingress service
    kubectl apply -f nginx/service/service.yaml
````
3. Create VirtualServer object which will be seen by F5 CIS and created on BIG-IP
````bash
    kubectl apply -f cis/crd/tlsprofile.yaml
    kubectl apply -f cis/crd/virtualserver.yaml
    kubectl apply -f cis/crd/virtualserver2.yaml
````

## Deleting your resources
This script will delete the resources you have created. 

````bash
    
    #delete VirtualServer object which configured CIS to expose KIC
    kubectl delete -f cis/crd/virtualserver.yaml
    #delete KIC
    kubectl delete -f nginx/service/service.yaml
    kubectl delete -f nginx/deployment/nginx-ingress.yaml
    kubectl delete -f nginx/common/ingress-class.yaml
    kubectl delete -f nginx/common/nginx-config.yaml
    kubectl delete -f nginx/common/default-server-secret.yaml
    kubectl delete -f nginx/rbac/rbac.yaml
    kubectl delete -f nginx/common/ns-and-sa.yaml
    #delete CRDs
    kubectl delete -f nginx/crd/vs-definition.yaml
    kubectl delete -f nginx/crd/vsr-definition.yaml
    kubectl delete -f nginx/crd/ts-definition.yaml
    kubectl delete -f nginx/crd/policy-definition.yaml

    #delete CIS
    kubectl delete -f cis/cis1.yaml
    kubectl delete -f cis/cis2.yaml
    kubectl delete -f cis/secret_sa_rbac.yaml
    #delete CRDs
    kubectl delete -f cis/crd-definition/customresourcedefinitions.yaml
````