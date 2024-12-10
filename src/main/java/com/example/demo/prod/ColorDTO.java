package com.example.demo.prod;

import lombok.Getter;
import lombok.Setter;

// CREATE TABLE color (
//   no int(11) NOT NULL AUTO_INCREMENT,
//   colorCode varchar(10),
//   colorName varchar(50),
//   PRIMARY KEY (no));

@Getter
@Setter
public class ColorDTO {

  int no;
  String colorCode;
  String colorName;

}
