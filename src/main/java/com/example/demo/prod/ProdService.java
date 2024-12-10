package com.example.demo.prod;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ProdService {

  @Autowired
  private ProdMapper mapper;

  public String addBrand(BrandDTO brand) {
    int result = mapper.addBrand(brand);
    if (result <= 0) {
      return "fail";
    }
    return "success";
  }

  public String addCategory(CateDTO cate) {
    int result = mapper.addCategory(cate);
    if (result <= 0) {
      return "fail";
    }
    return "success";
  }

  public String addColor(ColorDTO color) {
    int result = mapper.addColor(color);
    if (result <= 0) {
      return "fail";
    }
    return "success";
  }

  public String prodInsertProc(ProdDTO prods) {
    int result = mapper.prodInsertProc(prods);
    if (result <= 0) {
      return "상품등록 실패. 다시 시도해주세요";
    }
    return "상품등록 성공";
  }

  public List<CateDTO> cateGroupList() {
    List<CateDTO> cates = mapper.cateGroupList();
    return cates;
  }

  public List<CateDTO> cateCodeList() {
    List<CateDTO> cates = mapper.cateCodeList();
    return cates;
  }

  public List<BrandDTO> brandCodeList() {
    List<BrandDTO> brands = mapper.brandCodeList();
    return brands;
  }

  public List<ColorDTO> colorCodeList() {
    List<ColorDTO> colors = mapper.colorCodeList();
    return colors;
  }

  public List<ProdDTO> prodList(ProdDTO prod) {

    return mapper.searchProd(prod);
  }

  public List<StockStatusDTO> stockStatusList(StockStatusDTO ss) {

    return mapper.stockStatus(ss);
  }

  public ProdDTO findById(String prodNo) {
    return mapper.findById(prodNo);
  }

  public ProdDTO updateProd(String prodNo, int incomePrice, int sellPrice, String prodCon) {
    mapper.updateProd(prodNo, incomePrice, sellPrice, prodCon);

    return null;
  }

  public List<String> storeNameList() {
    List<String> storeNames = mapper.storeNameList();
    
    return storeNames;
  }

}