package com.example.demo.notice;

import lombok.Getter;
import lombok.Setter;

// CREATE TABLE notice (
//   id varchar(20) NOT NULL,
//   no int(11) NOT NULL AUTO_INCREMENT,
//   title varchar(30) NOT NULL DEFAULT '',
//   content varchar(1000),
//   writeDate varchar(20) NOT NULL DEFAULT '',
//   fileName varchar(255) NOT NULL DEFAULT '',
//   views int(11) NOT NULL DEFAULT 0,
//   checked tinyint(1),
//   PRIMARY KEY (no));

@Setter
@Getter
public class NoticeDTO {
    private String id;
    private int no;
    private String title;
    private String content;
    private String writeDate;
    private String fileName;
    private int views;
    private String checked;

}
