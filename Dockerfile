# Build stage
FROM maven:3.8-openjdk-17 as builder
WORKDIR /app
# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src
# Build the application
RUN mvn clean package

# Runtime stage
FROM tomcat:10-jdk17
# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy WAR from build stage
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Configure for Render
EXPOSE 10000
RUN sed -i 's/port="8080"/port="10000"/' /usr/local/tomcat/conf/server.xml

CMD ["catalina.sh", "run"]
