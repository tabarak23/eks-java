FROM eclipse-temurin:17-jdk AS build

WORKDIR /app


COPY pom.xml .
RUN apt-get update && apt-get install -y maven \
    && mvn dependency:go-offline


COPY src ./src
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk17-temurin
LABEL project="Vprofile"
LABEL author="tabarak23"

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
