# java maven app pipeline

this project is to build spring-pet-clinic app with jenkins pipeline and push final image to docker hub repo.
with increment version stage to edit pom.xml file with new version number and assign it to docker image tag.


## docker compose file to specify services and its replicas and its configurations:

* pet-app service to run five replicas of the app.
* mysqldb service to run mysql database to store pet-app data. 
* balancer service to run nginx container with its default.conf file to work as a load balancer for the five replicas.



## Tools

- git
- Docker & Docker compose 
- nginx as load Balancer  
- Jenkins CICD 
- bash scrpit

## deployscript.sh file :
it is bash script to install docker and git to run docker compose file to deploy services.

## Deployment

To deploy this project run attached deployscript.sh file on cloud server .

```bash
  chmod 777 deployscript.sh
  bash deployscript.sh
```

## to clone this repo :
'''bash
git clone https://github.com/rashadahmed424/java-pet-clinic-app-pipeline.git
'''



## Run Locally

Clone the project

```bash
  git clone https://github.com/rashadahmed424/java-pet-clinic-app-pipeline.git
```

Go to the project directory

```bash
  cd java-pet-clinic-app-pipeline
```


Start services 

```bash
   docker compose -f dockercompose.yaml  up --build -d 
```


