package com.tca.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    // Hardcoded Render database credentials
    private static final String DB_URL = "jdbc:postgresql://dpg-cv497i5umphs73eqreh0-a.singapore-postgres.render.com:5432/ajdb19?sslmode=require";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "zEh8cb5Ge5ZC8QiYYcXpyOXNuymrztoS";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL driver missing!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }
}