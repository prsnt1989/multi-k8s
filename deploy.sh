docker build -t prsnt1989/multi-client:latest -t prsnt1989/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t prsnt1989/multi-server:latest -t prsnt1989/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t prsnt1989/multi-worker:latest -t prsnt1989/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push prsnt1989/multi-client:latest
docker push prsnt1989/multi-server:latest
docker push prsnt1989/multi-worker:latest

docker push prsnt1989/multi-client:$SHA
docker push prsnt1989/multi-server:$SHA
docker push prsnt1989/multi-worker:$SHA

kubectl apply -f k8s

#kubectl set image deployments/client-deployment client=prsnt1989/multi-client:$SHA
#kubectl set image deployments/server-deployment server=prsnt1989/multi-server:$SHA
#kubectl set image deployments/worker-deployment worker=prsnt1989/multi-worker:$SHA

kubectl rollout restart deployments/client-deployment
kubectl rollout restart deployments/server-deployment
kubectl rollout restart deployments/worker-deployment