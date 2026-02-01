#build stage
FROM maven:3.9.9-eclipse-temurin-21-jammy AS foundation

WORKDIR /base

# copy only pom.xml first for cache
COPY pom.xml .
RUN mvn dependency:go-offline



# copy source and build
COPY src ./src
RUN mvn clean package -DskipTests

#runtime stage
FROM tomcat:10.1-jdk21



#creating non root user



RUN useradd -r -u 1001 -g root tomcatuser



LABEL project="vprofile"
LABEL maintainer="tabarak23"

# remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*


COPY --from=foundation /base/target/vprofile-v2.war \
     /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
