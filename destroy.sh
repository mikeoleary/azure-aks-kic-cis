    cd app/helloworld
    #delete demo app 
    kubectl delete -f ingress.yaml
    kubectl delete -f service.yaml
    kubectl delete -f deployment.yaml
    kubectl delete -f ns.yaml
    cd ../../ingress
    #delete KIC
    kubectl delete -f cis/crd/virtualserver.yaml
    kubectl delete -f nginx/service/service.yaml
    kubectl delete -f nginx/deployment/nginx-ingress.yaml
    kubectl delete -f nginx/common/ingress-class.yaml
    kubectl delete -f nginx/common/nginx-config.yaml
    kubectl delete -f nginx/common/default-server-secret.yaml
    kubectl delete -f nginx/rbac/rbac.yaml
    kubectl delete -f nginx/common/ns-and-sa.yaml
    kubectl delete -f nginx/crd/vs-definition.yaml
    kubectl delete -f nginx/crd/vsr-definition.yaml
    kubectl delete -f nginx/crd/ts-definition.yaml
    kubectl delete -f nginx/crd/policy-definition.yaml
    #delete CIS
    kubectl delete -f cis/cis1.yaml
    kubectl delete -f cis/cis2.yaml
    kubectl delete -f cis/secret_sa_rbac.yaml
    kubectl delete -f cis/crd-definition/customresourcedefinitions.yaml
    #destroy infrastructure
    cd ../infra
    terraform destroy -auto-approve