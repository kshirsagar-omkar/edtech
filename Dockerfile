FROM tomcat:10-jdk17

# Clear default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file with the correct name
COPY target/JSP-ASS-01-LoginPage.war /usr/local/tomcat/webapps/ROOT.war

# Configure for Render's required port (10000)
EXPOSE 10000
RUN sed -i 's/port="8080"/port="10000"/' /usr/local/tomcat/conf/server.xml

CMD ["catalina.sh", "run"]
