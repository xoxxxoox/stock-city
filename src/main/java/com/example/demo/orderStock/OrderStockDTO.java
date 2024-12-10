package com.example.demo.orderStock;

import lombok.Getter;
import lombok.Setter;

// CREATE TABLE orderstock (
//   reqStore varchar(20),
//   respStore varchar(20),
//   prodNo varchar(200) DEFAULT concat('cateCode',uuid()),
//   reqQuan int(11),
//   respQuan int(11),
//   reqDate varchar(20),
//   respDate varchar(20),
//   orderStatus varchar(20));

@Getter
@Setter
public class OrderStockDTO {

    private String reqStore;
    private String respStore;
    private String prodNo;
    private int reqQuan;
    private int respQuan;
    private String reqDate;
    private String respDate;
    private String orderStatus;

}
