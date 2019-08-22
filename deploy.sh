# Build images from Dockerfile
docker build -t mirks/multi-client:latest -t mirks/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mirks/multi-server:latest -t mirks/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mirks/multi-worker:latest -t mirks/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push docker images to docker hub
docker push mirks/multi-client:latest
docker push mirks/multi-server:latest
docker push mirks/multi-worker:latest

# Push seperate set of images to docker hub
docker push mirks/multi-client:$SHA
docker push mirks/multi-server:$SHA
docker push mirks/multi-worker:$SHA

# Apply k8s configs
kubectl apply -f k8s

# Set image to latest using imperative approach
kubectl set image deployments/server-deployment server=mirks/multi-server:$SHA
kubectl set image deployments/client-deployment client=mirks/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mirks/multi-worker:$SHA