package com.tca.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    // Get complete database URL from environment variable
    private static final String DATABASE_URL = System.getenv("DATABASE_URL");
    
    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL driver missing!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (DATABASE_URL == null) {
            throw new SQLException("Database URL not found in environment variables");
        }
        return DriverManager.getConnection(DATABASE_URL);
    }
}