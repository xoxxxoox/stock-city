package com.example.demo.prod;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StockStatusDTO {

    // product table
    private String storeName;
    private String prodNo;
    private String brandCode;
    private String cateCode;
    private String cateGroup;
    private String prodName;
    private String incomePrice;
    private String sellPrice;
    private String size;
    private String sizeS;
    private String sizeM;
    private String sizeL;
    private String sizeXL;
    private String colorCode;
    private String quan;

    // color table
    private String colorName;

}
