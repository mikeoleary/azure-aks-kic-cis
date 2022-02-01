    cd infra/
    terraform init
    terraform plan
    terraform apply -auto-approve
    sleep 120s # this sleep is to allow BIG-IP to initialize before we make further deployments in the next commands.
    #save some terraform output values for use later
    DNS_LISTENER=$(terraform output --raw dns-listener-vip)
    APP_VIP=$(terraform output app-vip)
    echo 'sleep for 120 seconds...'
    cd ../ingress/
    #deploy and configure CIS
    cp ~/.kube/config ~/.kube/config-backup
    mv ../infra/kube_config ~/.kube/config
    kubectl apply -f cis/crd-definition/customresourcedefinitions.yaml
    kubectl apply -f cis/secret_sa_rbac.yaml
    kubectl apply -f cis/cis1.yaml
    kubectl apply -f cis/cis2.yaml
    #deploy and configure KIC
    kubectl apply -f nginx/common/ns-and-sa.yaml
    kubectl apply -f nginx/rbac/rbac.yaml
    kubectl apply -f nginx/common/default-server-secret.yaml
    kubectl apply -f nginx/common/nginx-config.yaml
    kubectl apply -f nginx/common/ingress-class.yaml
    kubectl apply -f nginx/common/crds/k8s.nginx.org_virtualservers.yaml
    kubectl apply -f nginx/common/crds/k8s.nginx.org_virtualserverroutes.yaml
    kubectl apply -f nginx/common/crds/k8s.nginx.org_transportservers.yaml
    kubectl apply -f nginx/common/crds/k8s.nginx.org_policies.yaml
    kubectl apply -f nginx/deployment/nginx-ingress.yaml
    kubectl apply -f nginx/service/service.yaml

    # deploy the CRD's required to create a TLSProfile, VirtualServer, and WideIP on the BIG-IP
    #sed -i "s/10.0.2.100/$APP_VIP/g" cis/crd/virtualserver.yaml
    sed -i "s/  virtualServerAddress: .*/  virtualServerAddress: $APP_VIP/g" cis/crd/virtualserver.yaml
    kubectl apply -f cis/crd/tlsprofile.yaml
    kubectl apply -f cis/crd/virtualserver.yaml
    #kubectl apply -f cis/crd/virtualserver2.yaml
    kubectl apply -f edns/edns.yaml
    #deploy demo app
    cd ../app/helloworld
    kubectl apply -f ns.yaml
    kubectl apply -f deployment.yaml
    kubectl apply -f service.yaml
    kubectl apply -f ingress.yaml
    cd ../..