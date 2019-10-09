docker build -t shdkapoor/multi-client:latest -t shdkapoor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shdkapoor/multi-server:latest -t shdkapoor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shdkapoor/multi-worker:latest -t shdkapoor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shdkapoor/multi-client:latest
docker push shdkapoor/multi-server:latest
docker push shdkapoor/multi-worker:latest

docker push shdkapoor/multi-client:$SHA
docker push shdkapoor/multi-server:$SHA
docker push shdkapoor/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shdkapoor/multi-server:$SHA
kubectl set image deployments/client-deployment client=shdkapoor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shdkapoor/multi-worker:$SHA