docker build -t 99177812/mutli-client:latest -t 99177812/mutli-client:$SHA -f ./client/Dockerfile ./client
docker build -t 99177812/mutli-server:latest -t 99177812/mutli-server:$SHA -f ./server/Dockerfile ./server
docker build -t 99177812/mutli-worker:latest -t 99177812/mutli-worker:$SHA -f ./worker/Dockerfile ./worker
docker push 99177812/multi-client:latest
docker push 99177812/multi-server:latest
docker push 99177812/multi-worker:latest

docker push 99177812/multi-client:$SHA
docker push 99177812/multi-server:$SHA
docker push 99177812/multi-worker:$SHA

kubetl apply -f k8s
kubectl set image deployments/server-deployment server=99177812/multi-server:$SHA
kubectl set image deployments/client-deployment client=99177812/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=99177812/multi-worker:$SHA
