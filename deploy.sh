# build
docker build -t y0urs3lf/multi-client:latest -t y0urs3lf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t y0urs3lf/multi-server:latest -t y0urs3lf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t y0urs3lf/multi-worker:latest -t y0urs3lf/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push latest to docker hub
docker push y0urs3lf/multi-client:latest
docker push y0urs3lf/multi-server:latest
docker push y0urs3lf/multi-worker:latest

docker push y0urs3lf/multi-client:$SHA
docker push y0urs3lf/multi-server:$SHA
docker push y0urs3lf/multi-worker:$SHA

# update running deployments
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=y0urs3lf/multi-server:$SHA
kubectl set image deployments/client-deployment client=y0urs3lf/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=y0urs3lf/multi-worker:$SHA