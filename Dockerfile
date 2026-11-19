# Build the Maven web application
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -B -ntp clean package

# Run the WAR using Tomcat 9
FROM tomcat:9.0-jre17-temurin-noble

COPY --from=build /app/target/ticket-reservation.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]