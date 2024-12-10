package com.example.demo.prod;

import lombok.Getter;
import lombok.Setter;

// CREATE TABLE category (
//   no int(11) NOT NULL AUTO_INCREMENT,
//   cateGroup varchar(10),
//   cateCode varchar(6),
//   cateName varchar(10),
//   PRIMARY KEY (no));

@Setter
@Getter
public class CateDTO {

  String cateGroup;
  String cateCode;
  String cateName;

}
