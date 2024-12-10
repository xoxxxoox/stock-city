package com.example.demo.prod;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("prod")
public class ProdRestController {

  @Autowired
  ProdService service;

  @GetMapping("detail/{prodNo}")
  public ProdDTO prodInfo(@PathVariable String prodNo) {
    ProdDTO prod = service.findById(prodNo);
    return prod;
  }

  @PutMapping("updateProd/{prodNo}")
  public ProdDTO updateProd(@PathVariable String prodNo, @RequestBody ProdDTO prod) {
    System.out.println("good");

    ProdDTO updateProd = service.updateProd(prodNo, prod.getIncomePrice(), prod.getSellPrice(), prod.getProdCon());

    return updateProd;
  }

}
