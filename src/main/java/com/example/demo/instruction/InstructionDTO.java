package com.example.demo.instruction;

import lombok.Getter;
import lombok.Setter;

// CREATE TABLE instruction (
//   id varchar(20),
//   no int(11) DEFAULT 0,
//   processing varchar(255),
//   confirmation varchar(255),
//   prodNo varchar(200) PRIMARY KEY,
//   prodName varchar(50),
//   colorCode varchar(10),
//   size varchar(6),
//   respStore varchar(20),
//   respQuan int(11),
//   respDate varchar(20));

@Setter
@Getter
public class InstructionDTO {
    // InstructionDTO
    private String id;
    private int no;
    private String processing; // 처리구분
    private String confirmation; // 확인,미확인 박스

    // OrderStockDTO
    private int reqQuan; // 요청수량
    private int respQuan; // 받은수량
    private String reqDate; // 요청날짜
    private String respDate; // 수령날짜
    private String orderStatus; // 요청상태
    private String respStore; // 매장

    // ProdDTO
    private String prodNo; // 상품코드번호
    private String brandCode; // 브랜드코드
    private String prodName; // 품명
    private int incomePrice; // 입고가격
    private int sellPrice; // 판매가격
    private String size; // 사이즈
    private String storeName; // 매장

    // CateDTO
    private String cateGroup;
    private String cateCode;
    private String cateName;

    // ColorDTO
    private String colorCode;
    private String colorName;

}
