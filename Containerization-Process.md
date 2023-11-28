Prerequisites
----
You should have Docker Engine and Docker CLI installed

Steps to build a docker image of the application
1. Clone the repo
```
git clone git@github.com:junior451/Web-App-DevOps-Project.git
```

2. Build the image
```
cd Web-App-DevOps-Project
docker build -t devops-orders-project
```

3. Run the following command to build the docker image
```
docker run -p 5000:5000 devops-orders-project
access it at https://localhost:5000
```

4. Tag the image and push it to dockerhub
```
docker tag devops-orders-project <docker-hub-username/devops-orders-project>:latest
```

5. You can also pull the image from dockerhub without building if its already been pushed to dockerhub

```
docker pull junior451/devops-orders-project:latest
docker run -p 5000:5000 junior451/devops-orders-project
```

## Cleanup

### Remove containers
```
docker ps -a
docker rm container-id
```

**Remove images**

```
docker images -a
docker rmi image-id
```

