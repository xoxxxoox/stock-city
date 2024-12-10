package com.example.demo.orderStock;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.prod.ProdDTO;

@Mapper
public interface OrderStockMapper {

    int storingProc(@Param("storeName") String storeName, @Param("prodNo") String prodNo, @Param("reqQuan") int reqQuan);

    int unstoringProc(@Param("prodNo") String prodNo, @Param("respQuan") int respQuan, @Param("storeName") String storeName);

    List<ProdDTO> searchProd(ProdDTO prod);

    String connectName(String id);

    ArrayList<OrderStockDTO> stockList();

    int searchRootQuan(OrderStockDTO store);

    OrderStockDTO searchProdInfo(OrderStockDTO store);

    int updateRootQuan(ProdDTO prods);

    ProdDTO findRootProd(ProdDTO prods);

    ProdDTO findStoreProd(ProdDTO prods);

    void updateStoreProd(ProdDTO findStoreProd);

    void insertStoreProd(ProdDTO findRootProd);

    OrderStockDTO searchOrderStatus(OrderStockDTO store);

    void updateOrderStatus(OrderStockDTO changeStatus);

    int storingDenied(OrderStockDTO store);

    List<String> storeList();

    List<OrderStockDTO> csvList();

}
