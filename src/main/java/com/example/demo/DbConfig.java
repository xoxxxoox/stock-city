package com.example.demo;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;

import com.example.demo.join.JoinDTO;

import java.util.List;

@Service
public class DbConfig {

    private final JdbcTemplate jdbcTemplate;
    private final DataSource dataSource; // Add this line
    private String defaultUserName = "demo";

    public DbConfig(JdbcTemplate jdbcTemplate, DataSource dataSource) {
        this.jdbcTemplate = jdbcTemplate;
        this.dataSource = dataSource;
    }

    public void setDynamicDatabase(String dbName) { // 동적으로 DB를 변경하는 메서드
        try {
            jdbcTemplate.execute("USE " + dbName);
        } catch (Exception e) {
            logError("setDynamicDatabase 메소드에서 오류 발생", e);
        }
    }

    // private void closeCurrentConnection() throws SQLException {
    // System.out.println("Closing current connection");
    // java.sql.Connection connection = dataSource.getConnection();
    // if (connection != null && !connection.isClosed()) {
    // connection.close();
    // System.out.println("Connection closed successfully");
    // } else {
    // System.out.println("No active connection to close");
    // }
    // }

    public void setLogoutDatabase() { // 로그아웃시 defaultUserName 데이터베이스로 이동
        // try {
        // closeCurrentConnection();
        // String dynamicUrl = "jdbc:mariadb://db.itbank08.link:3306/" +
        // defaultUserName;
        // DataSource newDataSource = buildDataSource(dynamicUrl, "admin"); // 추후 숨겨주길
        // 바람.
        // jdbcTemplate.setDataSource(newDataSource);
        // } catch (Exception e) {
        // logError("setLogoutDatabase 메소드에서 오류 발생", e);
        // }
        try {
            jdbcTemplate.execute("USE " + defaultUserName);
        } catch (Exception e) {
            logError("setLogoutDatabase 메소드에서 오류 발생", e);
        }
    }

    // protected DataSource buildDataSource(String url, String id) { // 동적으로 DB연결 주소
    // pool
    // HikariConfig hikariConfig = new HikariConfig();
    // hikariConfig.setJdbcUrl(url);
    // hikariConfig.setUsername(id);
    // hikariConfig.setPassword("mariapass");

    // return new HikariDataSource(hikariConfig);
    // }

    public void createSetDatabase(String dbName) { // 회원가입 승인 후 demo 데이터베이스 복제
        try {
            if (!databaseExists(dbName)) {
                createDatabase(dbName);
                // createUserAndGrantPrivileges(dbName);
                List<String> tables = getTablesInDatabase();

                for (String table : tables) {
                    updateTableStatements(dbName, table);
                    // 여기에 특정한 테이블 값에 대한 로직 추가
                    if (table.trim().equals("orderstatus") || table.trim().equals("user")) {
                        // table 값을 소문자로 반환해주기에 소문자로하기
                        // 특정한 테이블에 데이터 추가하는 로직
                        addDataToTable(table, dbName);
                    }
                }
            } else {
                jdbcTemplate.execute("USE " + dbName);

                String grantPrivilegesQuery = "GRANT ALL PRIVILEGES ON " + dbName + ".* TO ?@'%'";
                jdbcTemplate.update(grantPrivilegesQuery, dbName);

                List<String> tables = getTablesInDatabase();
                for (String table : tables) {
                    String grantReadPermissionQuery = "GRANT SELECT ON " + dbName + "." + table + " TO ?@'%'";
                    jdbcTemplate.update(grantReadPermissionQuery, dbName);
                }

                jdbcTemplate.execute("USE " + defaultUserName);
            }
        } catch (Exception e) {
            logError("데이터베이스 생성, 테이블 복제, 유저 생성 및 권한 부여 실패", e);
        }
    }

    public void changeUseDatabase(String dbName){
        jdbcTemplate.execute("USE " + dbName);
    }
    protected void createDatabase(String dbName) { // 1. 데이터 베이스 생성
        try {
            String createDatabaseQuery = "CREATE DATABASE IF NOT EXISTS " + dbName;
            jdbcTemplate.execute(createDatabaseQuery);
            System.out.println("데이터베이스 생성 완료: " + dbName);
        } catch (Exception e) {
            logError("데이터베이스 생성 실패", e);
        }
    }

    // protected void createUserAndGrantPrivileges(String dbName) {
    // 사용자 생성 및 권한 부여
    // try {
    // if (!userExists(dbName)) {
    // // CREATE USER 쿼리 수정
    // String createUserQuery = "CREATE USER ?@'%' IDENTIFIED BY 'mariapass'"; //
    // 사용자 계정 생성
    // jdbcTemplate.update(createUserQuery, dbName);

    // String grantPrivilegesQuery = "GRANT ALL PRIVILEGES ON " + dbName + ".* TO
    // ?@'%'";
    // // 생성한 DB의 권한만 부여
    // jdbcTemplate.update(grantPrivilegesQuery, dbName);

    // System.out.println("계정 생성 및 권한 부여 완료: " + dbName);
    // } else {
    // System.out.println("사용자 이미 존재함: " + dbName);
    // }
    // } catch (Exception e) {
    // logError("사용자 계정 생성 및 권한 생성 실패", e);
    // }
    // }

    // 테이블 생성(desc)
    protected void updateTableStatements(String dbName, String table) {
        if (!tableExists(dbName, table)) {
            // 'CREATE TABLE' 쿼리 실행 코드 추가
            String createTableQuery = "SHOW CREATE TABLE `" + defaultUserName + "`.`" + table + "`";

            try {
                // 두 번째 컬럼에 해당하는 타입으로 매핑하도록 수정
                String createTableStatement = jdbcTemplate.queryForObject(createTableQuery,
                        (rs, rowNum) -> rs.getString(2));

                // 새로운 사용자의 데이터베이스에 'CREATE TABLE' 쿼리 실행
                jdbcTemplate.execute("USE " + dbName);
                jdbcTemplate.execute(createTableStatement);

                System.out.println("테이블 생성 완료: " + dbName + "." + table);
                jdbcTemplate.execute("USE " + defaultUserName);
            } catch (EmptyResultDataAccessException e) {
                logError("updateTableStatements 메소드에서 오류 발생", e);
            }
        }
    }

    // 데이터베이스 내의 테이블 목록 가져오기
    protected List<String> getTablesInDatabase() {
        try {
            String query = "SHOW TABLES FROM " + defaultUserName;
            return jdbcTemplate.queryForList(query, String.class);
        } catch (Exception e) {
            logError("getTablesInDatabase 메소드에서 오류 발생", e);
            throw new RuntimeException("테이블 목록을 가져오는 동안 오류가 발생했습니다.", e);
        }
    }

    // 특정 테이블에 데이터 추가
    protected void addDataToTable(String table, String dbName) {
        System.out.println("Creating data: " + table);

        if (table.trim().equals("orderstatus")) {
            String insertSql = "INSERT INTO " + dbName + ".orderStatus (no, status) VALUES (?, ?)";
            // Query execution
            jdbcTemplate.execute("USE " + dbName);
            jdbcTemplate.update(insertSql, 1, "request"); // Requested
            jdbcTemplate.update(insertSql, 2, "approval"); // Approval confirmed
            jdbcTemplate.update(insertSql, 3, "reject"); // Request rejected
            jdbcTemplate.update(insertSql, 4, "deliver"); // Delivering
            jdbcTemplate.update(insertSql, 5, "receive"); // Received confirmation

            System.out.println("Data added to " + table + " table successfully");
        } else if (table.trim().equals("user")) {
            String selectSql = "SELECT * FROM " + defaultUserName + ".user WHERE dbName = ?";
            List<JoinDTO> joins = jdbcTemplate.query(selectSql, new BeanPropertyRowMapper<>(JoinDTO.class), dbName);

            jdbcTemplate.execute("USE " + dbName);
            for (JoinDTO join : joins) {
                System.out.println("No: " + join.getNo());
                System.out.println("Id: " + join.getId());
                System.out.println("Pw: " + join.getPw());
                System.out.println("Confirm: " + join.getConfirm());
                System.out.println("Company: " + join.getCompany());
                System.out.println("BusinessNo: " + join.getBusinessNo());
                System.out.println("Email: " + join.getEmail());
                System.out.println("RegDate: " + join.getRegDate());
                System.out.println("RegistStatus: " + join.getRegistStatus());
                System.out.println("AdCount: " + join.getAdCount());
                System.out.println("AccountId: " + join.getAccountId());
                System.out.println("DbName: " + join.getDbName());

                String insertSql1 = "INSERT INTO " + table + " VALUES (?,?,?,?,?,?,?,?,?,?,?)";

                jdbcTemplate.update(insertSql1, join.getNo(), join.getId(), join.getPw(),
                        join.getCompany(), join.getBusinessNo(), join.getEmail(), join.getRegDate(),
                        join.getRegistStatus(), join.getAdCount(), join.getAccountId(), join.getDbName());
            }

            System.out.println("Data added to " + table + " table successfully");
        }
    }

    protected boolean databaseExists(String databaseName) {
        try {
            String query = "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = ?";
            jdbcTemplate.queryForObject(query, String.class, databaseName);
            System.out.println("데이터베이스 존재함: " + databaseName);
            return true;
        } catch (EmptyResultDataAccessException e) {
            return false;
        }
    }

    // 데이터베이스 존재 여부 확인
    protected boolean tableExists(String databaseName, String tableName) {
        try {
            String query = "SHOW TABLES FROM " + databaseName + " LIKE ?";
            List<String> result = jdbcTemplate.queryForList(query, String.class, tableName);
            return !result.isEmpty();
        } catch (Exception e) {
            logError("tableExists 메소드에서 오류 발생", e);
            return false;
        }
    }

    // 사용자 존재 여부 확인
    protected boolean userExists(String userName) {
        try {
            String query = "SELECT user FROM mysql.user WHERE user = ?";
            jdbcTemplate.queryForObject(query, String.class, userName);
            return true;
        } catch (EmptyResultDataAccessException e) {
            return false;
        }
    }

    // 에러 로깅 메소드
    private void logError(String message, Exception e) {
        System.err.println(message);
        e.printStackTrace();
    }
}