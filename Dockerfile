FROM openjdk:8-jdk-alpine
EXPOSE 8080
ARG JAR_FILE=target/hw.jar
COPY ${JAR_FILE} hw.jar
ENTRYPOINT ["java","-jar","/hw.jar"]