package com.tca.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL driver missing!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        // Use environment variables for database credentials
        String dbUrl = System.getenv("JDBC_URL");
        String dbUser = System.getenv("DB_USER");
        String dbPass = System.getenv("DB_PASSWORD");

        if (dbUrl == null || dbUser == null || dbPass == null) {
            throw new RuntimeException("Database environment variables are not set!");
        }

        return DriverManager.getConnection(dbUrl, dbUser, dbPass);
    }
}