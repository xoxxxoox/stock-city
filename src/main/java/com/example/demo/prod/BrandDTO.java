package com.example.demo.prod;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BrandDTO {

  int no;
  String brandCode;
  String brandDescription;

}

// CREATE TABLE brand (
//   no int(11) NOT NULL AUTO_INCREMENT,
//   brandCode varchar(30),
//   brandDescription varchar(300),
//   PRIMARY KEY (no));
