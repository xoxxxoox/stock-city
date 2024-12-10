package com.example.demo.prod;

import lombok.Getter;
import lombok.Setter;
import java.util.UUID;

@Getter
@Setter
public class ProdDTO {

  int no;
  String prodNo;
  String brandCode;
  String cateGroup;
  String cateCode;
  String prodName;
  int incomePrice; // 입고가격
  int sellPrice; // 판매가격
  String size;
  String colorCode;
  int quan;
  String prodCon;
  String regDate; // mapper -> Now()
  String storeName;

  public ProdDTO(String brandCode, String cateGroup, String cateCode, String size) {
    // 생성자에서 직접 getProdNo 메서드 호출
    getProdNo(brandCode, cateGroup, cateCode, size);
  }

  // prodNo를 자동으로 생성하는 메서드
  private void getProdNo(String brandCode, String cateGroup, String cateCode, String size) {
    this.prodNo = brandCode + cateGroup + cateCode + size + UUID.randomUUID().toString();
  }

  // CREATE TABLE product (
  //   no int(11) NOT NULL AUTO_INCREMENT,
  //   prodNo varchar(200) NOT NULL DEFAULT concat('cateCode',uuid()),
  //   brandCode varchar(25),
  //   cateCode varchar(25),
  //   prodName varchar(50),
  //   incomePrice int(11),
  //   sellPrice int(11),
  //   size varchar(6),
  //   colorCode varchar(10) NOT NULL,
  //   quan int(11),
  //   regDate varchar(50),
  //   prodCon varchar(300),
  //   storeName varchar(20),
  //   PRIMARY KEY (no));

}
