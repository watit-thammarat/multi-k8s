docker build -t tongnakub/multi-client:latest -t tongnakub/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tongnakub/multi-server:latest -t tongnakub/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tongnakub/multi-worker:latest -t tongnakub/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tongnakub/multi-client:latest
docker push tongnakub/multi-client:$SHA

docker push tongnakub/multi-server:latest
docker push tongnakub/multi-server:$SHA

docker push tongnakub/multi-worker:latest
docker push tongnakub/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=tongnakub/multi-client:$SHA
kubectl set image deployments/server-deployment server=tongnakub/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tongnakub/multi-worker:$SHA