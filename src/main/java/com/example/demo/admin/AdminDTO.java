package com.example.demo.admin;

import lombok.Getter;
import lombok.Setter;

// CREATE TABLE admin (
//   aId varchar(20) NOT NULL,
//   aPw varchar(60) NOT NULL,
//   PRIMARY KEY (aId));

// 관리자 로그인 페이지     http://localhost/suadonghyeonyeonjidongwoonsangwon@SC

@Getter
@Setter
public class AdminDTO {
    private String aId;
    private String aPw;
    private String confirm;
}
