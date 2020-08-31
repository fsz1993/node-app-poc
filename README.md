# Node App + Kubernetes POC
This project is a proof of concept of implementing a node web app that requests a message from a database, all running as containers on top of kubernetes.

## Build
Inside the root folder there is a setup script to help build the image. There is also a git ci definition but it depends on the setup of each gitlab instance as a artifact and image registry.
Follow the instructions by running:
```
./setup.sh
```

After building the image, it is required to send the image to the docker image repository being used by the environment (in this example repo *poc*)
```
docker push my-repo/node-web-app:1.0.0
```

## Deploying to kuberentes
There is a script inside the folder kubernetes that helps the deploy to kubernetes. Follow the instructions by running:
```
cd kubernetes
./setup.sh
```

After deploying the stack, it is needed to create the inputs of the DB (it was not automated for this task but it is easily done by init-scripts and k8s entrypoings). The sql commands can be found inside the folder kubernetes/initdb.
```
kubectl get pods -l app=postgres
kubectl exec -it postgres-pod-name -n node-web-app -- psql --host postgres.node-web-app.svc.cluster.local --port 5432 postgres -U postgres -W
```

## Testing
When deploying to kubernetes it asks for the environment beeing deployed to. It could be architected to run multiple clusters for prd and env or different namespaces. For the sake of simplicity, we are agnostic of the environment and use the same namespaces changing configs via deploy stage to differentiate configuration.

The kustomization setup creates a nodePort service for the app. In a real scenario it would need to deploy an ingress stack. After deploying, one need to get the node to which the pod was deployed and acces the service by running:
```
kubectl get pods -o wide -n node-web-app #get the node name or ip
curl -L node-name-or-ip:30900
```

The expected result is the following message
{"message":"Hello world! This is <ENV>!"}[



### Notes
There are tons of good practices to be put on like network policies, security context, run as non root, resources, image vulnerability scan, static code analisis, and so on.