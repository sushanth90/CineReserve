package com.cinereserve;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class DatabaseConnectivityTest {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Test
    @DisplayName("Verify DataSource connection can be acquired and is PostgreSQL")
    void testDataSourceConnection() throws SQLException {
        assertNotNull(dataSource, "DataSource bean should be injected");
        try (Connection connection = dataSource.getConnection()) {
            assertNotNull(connection, "Active connection should be obtained");
            assertFalse(connection.isClosed(), "Connection should not be closed");
            String databaseProductName = connection.getMetaData().getDatabaseProductName();
            assertEquals("PostgreSQL", databaseProductName, "Database should be PostgreSQL");
        }
    }

    @Test
    @DisplayName("Verify existing CineReserve tables and records are intact without any data loss")
    void testExistingTablesAndDataIntact() {
        Integer userCount = jdbcTemplate.queryForObject("SELECT count(*) FROM \"User\"", Integer.class);
        assertNotNull(userCount);
        assertTrue(userCount >= 1, "User table must contain existing users (expected >= 1, found: " + userCount + ")");

        Integer movieCount = jdbcTemplate.queryForObject("SELECT count(*) FROM \"Movie\"", Integer.class);
        assertNotNull(movieCount);
        assertEquals(16, movieCount, "Movie table must contain all 16 existing movies");

        Integer cinemaCount = jdbcTemplate.queryForObject("SELECT count(*) FROM \"Cinema\"", Integer.class);
        assertNotNull(cinemaCount);
        assertEquals(5, cinemaCount, "Cinema table must contain all 5 existing cinemas");

        Integer seatCount = jdbcTemplate.queryForObject("SELECT count(*) FROM \"Seat\"", Integer.class);
        assertNotNull(seatCount);
        assertEquals(224, seatCount, "Seat table must contain all 224 existing seats");

        Integer showCount = jdbcTemplate.queryForObject("SELECT count(*) FROM \"Show\"", Integer.class);
        assertNotNull(showCount);
        assertEquals(900, showCount, "Show table must contain all 900 existing shows");

        Integer bookingCount = jdbcTemplate.queryForObject("SELECT count(*) FROM \"Booking\"", Integer.class);
        assertNotNull(bookingCount);
        assertTrue(bookingCount >= 27, "Booking table must contain existing bookings (expected >= 27, found: " + bookingCount + ")");
    }
}
