FROM openjdk:17-jdk-alpine
WORKDIR /APP
COPY ./target/spring-petclinic-*.jar .
EXPOSE 8080
CMD java -jar spring-petclinic*.jar
