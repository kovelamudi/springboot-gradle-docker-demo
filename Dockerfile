FROM gradle:4.7.0-jdk8-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon
FROM openjdk:8
EXPOSE 8080
RUN mkdir /app
COPY --from=build /home/gradle/src/build/libs/*.jar /app/demo-docker-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/app/demo-docker-0.0.1-SNAPSHOT.jar"]