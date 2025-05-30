FROM eclipse-temurin:24-jdk
WORKDIR /app

# copy the fat JAR you built with `mvn clean package`
COPY target/*.jar app.jar

# run it
ENTRYPOINT ["java","-jar","app.jar"]
