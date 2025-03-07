# Java WebServlet/JSP Deployment on Render

## Overview
This guide provides step-by-step instructions for deploying a Java WebServlet/JSP application on Render.com. The deployment includes setting up a PostgreSQL database, configuring Maven, Dockerizing the application, and troubleshooting common issues. 

## Structured Deployment Guide for Java WebServlet/JSP Application on Render.com

### 1. Prerequisites
- **Render Account**: Sign up at [Render](https://render.com/).
- **Git Repository**: Host your project on GitHub/GitLab.
- **Java & Maven**: Ensure JDK 17 and Maven are installed locally.
- **PostgreSQL**: Set up a PostgreSQL database on Render.

---

### 2. Project Configuration
#### 2.1 Update `pom.xml` for Jakarta EE and PostgreSQL
```xml
<project ...>
    <modelVersion>4.0.0</modelVersion>
    <groupId>JSP-ASS-01-LoginPage</groupId>
    <artifactId>JSP-ASS-01-LoginPage</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>war</packaging>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <jakarta.version>10.0.0</jakarta.version>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>

    <dependencies>
        <!-- Jakarta EE Web API -->
        <dependency>
            <groupId>jakarta.platform</groupId>
            <artifactId>jakarta.jakartaee-web-api</artifactId>
            <version>${jakarta.version}</version>
            <scope>provided</scope>
        </dependency>

        <!-- PostgreSQL JDBC Driver -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <version>42.7.4</version>
        </dependency>
    </dependencies>

    <build>
        <finalName>ROOT</finalName>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.13.0</version>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.4.0</version>
                <configuration>
                    <failOnMissingWebXml>false</failOnMissingWebXml>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

#### 2.2 Modify `DBUtil.java` for Render Environment
```java
package com.tca.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String DB_URL = System.getenv("DATABASE_URL");

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL driver missing!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (DB_URL == null) {
            throw new SQLException("DATABASE_URL environment variable not set.");
        }
        return DriverManager.getConnection(DB_URL);
    }
}
```

---

### 3. Docker Setup
#### 3.1 Create `Dockerfile` (Multi-Stage Build)
```dockerfile
# Stage 1: Build WAR using Maven
FROM maven:3.8-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Deploy to Tomcat
FROM tomcat:10.1-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Configure for Render's port (10000)
EXPOSE 10000
RUN sed -i 's/port="8080"/port="10000"/' /usr/local/tomcat/conf/server.xml

CMD ["catalina.sh", "run"]
```

#### 3.2 Create `.dockerignore`
```txt
target/
.git/
*.iml
```

---

### 4. Deploy on Render
#### 4.1 Create PostgreSQL Database on Render
1. Go to Dashboard → **New** → **PostgreSQL**.
2. Note the **Internal Database URL** (e.g., `postgresql://user:pass@host:port/db`).

#### 4.2 Create Web Service
1. Dashboard → **New** → **Web Service**.
2. Connect your Git repository.
3. Configure settings:
   - **Runtime**: Docker
   - **Build Command**: Leave empty (handled by Dockerfile).
   - **Start Command**: Leave empty.
4. Set **Environment Variables**:
   - `DATABASE_URL`: Paste the Internal Database URL from Render.
5. Click **Deploy**.

---

### 5. Troubleshooting
#### 5.1 Common Errors
- **Docker Build Fails**:
  - Ensure `Dockerfile` and `pom.xml` are in the root directory.
  - Verify the WAR filename in `Dockerfile` matches `pom.xml`'s `<finalName>`.

- **Database Connection Issues**:
  - Check `DATABASE_URL` in Render's environment variables.
  - Add debug logs in `DBUtil.getConnection()`.

- **NullPointerException in Servlets**:
  - Add null checks for database results.
  - Test locally with Render's database URL.

---

### 6. Post-Deployment
- **Access Application**: Use the URL provided by Render (e.g., `https://your-service.onrender.com`).
- **Monitor Logs**: Check logs in Render Dashboard for runtime errors.

---

### 7. Resources
- [Render Web Services Docs](https://render.com/docs/web-services)
- [Render PostgreSQL Docs](https://render.com/docs/databases)
- [Tomcat Docker Image](https://hub.docker.com/_/tomcat)

This guide ensures your Java WebServlet/JSP application is securely deployed on Render with PostgreSQL, proper Docker configuration, and environment-aware database connectivity.
