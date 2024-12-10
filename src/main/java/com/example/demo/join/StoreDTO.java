package com.example.demo.join;

import lombok.Getter;
import lombok.Setter;

// CREATE TABLE store (
//   no int(11) NOT NULL,
//   storeNo varchar(20),
//   name varchar(20),
//   address varchar(50),
//   tel varchar(20),
//   PRIMARY KEY (no),
//   UNIQUE KEY storeNo (storeNo));

@Getter
@Setter
public class StoreDTO {
    private int no;
    private String storeNo;
    private String name;
    private String address;
    private String tel;
}
