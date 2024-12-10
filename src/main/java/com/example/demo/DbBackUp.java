package com.example.demo;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.springframework.stereotype.Service;

@Service
public class DbBackUp {

    private String defaultUserName = "admin";
    private String defaultPassword = "mariapass";

    public void userRecoveryData(String dbName) { // 사용자(본사)의 데이터 복원기능

        String fullPath = "~/" + dbName;
        // AWS CLI 명령어 생성
        String s3BucketPath = "s3://ohjo-s3" + dbName.replace("\\", "/");
        String awsCliCommand = String.format("aws s3 mv \"%s\" \"%s\"", s3BucketPath, fullPath);
        System.out.println("명령어: " + awsCliCommand);

        // AWS CLI 명령어 실행
        executeCommand(awsCliCommand); // 백업된 데이터 베이스를 S3에 이동하는 작업

        String dbBackUpCommand = "sudo mysqldump -u " + defaultUserName + " -p" + defaultPassword
                + " " + dbName + "< ~/" + dbName + ".sql";
        executeCommand(dbBackUpCommand);// 데이터 베이스중 유저의 데이터베이스 데이터를 홈디렉터리에 백업

    }

    public void userFileUpload(String dbName) { // 사용자(본사)의 데이터 백업기능

        String dbBackUpCommand = "sudo mysqldump -u " + defaultUserName + " -p" + defaultPassword
                + " " + dbName + "> ~/" + dbName + ".sql";
        executeCommand(dbBackUpCommand);// 데이터 베이스중 유저의 데이터베이스 데이터를 홈디렉터리에 백업

        String fullPath = "~/" + dbName;
        // AWS CLI 명령어 생성
        String s3BucketPath = "s3://ohjo-s3" + dbName.replace("\\", "/");
        String awsCliCommand = String.format("aws s3 mv \"%s\" \"%s\"", fullPath, s3BucketPath);
        System.out.println("명령어: " + awsCliCommand);

        // AWS CLI 명령어 실행
        executeCommand(awsCliCommand); // 백업된 데이터 베이스를 S3에 이동하는 작업

        // String backUpDelete = "rm -rf " + fullPath;
        // executeCommand(backUpDelete);

    }

    public void adminFileUpload() { // 관리자의 데이터 백업기능

        String dbBackUpCommand = "sudo mysqldump -u " + defaultUserName + " -p" + defaultPassword
                + " --all-databases > ~/all.sql";
        executeCommand(dbBackUpCommand);// 데이터 베이스의 모든 데이터를 홈디렉터리에 백업

        String fullPath = "~/all.sql";
        // AWS CLI 명령어 생성
        String s3BucketPath = "s3://stockcity-s3/admin/"; // 슬래시로 구분
        String awsCliCommand = String.format("aws s3 mv \"%s\" \"%s\"", fullPath, s3BucketPath);
        System.out.println("명령어: " + awsCliCommand);

        // AWS CLI 명령어 실행
        executeCommand(awsCliCommand); // 백업된 데이터 베이스를 S3에 이동하는 작업

        // String backUpDelete = "rm -rf " + fullPath;
        // executeCommand(backUpDelete);

    }

    public void allRecoveryData() {
        String fullPath = "~/all.sql";
        // AWS CLI 명령어 생성
        String s3BucketPath = "s3://stockcity-s3/admin/"; // 슬래시로 구분
        String awsCliCommand = String.format("aws s3 mv \"%s\" \"%s\"", s3BucketPath, fullPath);
        System.out.println("명령어: " + awsCliCommand);

        // AWS CLI 명령어 실행
        executeCommand(awsCliCommand); // S3에 보관된 데이터 백업본을 홈디렉터리에 이동하는 작업

        String dbBackUpCommand = "sudo mysqldump -u " + defaultUserName + " -p" + defaultPassword
                + " --all-databases < ~/all.sql";
        executeCommand(dbBackUpCommand);// 데이터 베이스의 모든 데이터를 홈디렉터리에 백업
    }

    protected void executeCommand(String awsCliCommand) { // 서버에서 커맨드 하는 명령어
        try { // 프로세스 빌더 생성
            ProcessBuilder processBuilder = new ProcessBuilder();
            processBuilder.command("bash", "-c", awsCliCommand);

            // 프로세스 실행
            Process process = processBuilder.start();

            // 프로세스의 출력 및 에러를 읽기
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));

            // 프로세스의 출력을 읽기
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.println(line);
            }

            // 프로세스의 에러를 읽기
            while ((line = errorReader.readLine()) != null) {
                System.err.println(line); // 에러 스트림을 표준 에러로 출력
            }

            // 프로세스 종료 대기
            int exitCode = process.waitFor();
            System.out.println("Exited with error code " + exitCode);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("실행 오류!");
        }

    }
}
