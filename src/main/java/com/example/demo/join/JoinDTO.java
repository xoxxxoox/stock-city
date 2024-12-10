package com.example.demo.join;

import lombok.Getter;
import lombok.Setter;

// CREATE TABLE user (
//   no int(11) NOT NULL,
//   id varchar(20) NOT NULL,
//   pw varchar(100) NOT NULL,
//   company varchar(255) NOT NULL,
//   businessNo varchar(20),
//   email varchar(40),
//   regDate varchar(20) NOT NULL,
//   registStatus varchar(20) NOT NULL,
//   adCount varchar(20),
//   accountId varchar(20),
//   dbName varchar(20),
//   PRIMARY KEY (no));

@Getter
@Setter
public class JoinDTO {
    private int no;
    private String id;
    private String pw;
    private String confirm;
    private String company;
    private String businessNo;
    private String email;
    private String regDate;
    private String registStatus;
    private String adCount;
    private String accountId;
    private String dbName;
    private String count;
}
