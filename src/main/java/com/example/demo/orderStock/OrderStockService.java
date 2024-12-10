package com.example.demo.orderStock;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.demo.prod.ProdDTO;

import jakarta.servlet.http.HttpSession;

@Service
public class OrderStockService {

    @Autowired
    private OrderStockMapper mapper;
    @Autowired
    private HttpSession session;

    public String storingProc(String prodNo, int reqQuan) {
        String id = (String) session.getAttribute("id");
        String storeName = mapper.connectName(id); // id값을 기준으로 user와 store테이블의 no값이 같은 매장 이름을 가져옴(최초 입고라면 storeName값이 없어서)
        ProdDTO prod = new ProdDTO(null, null, null, null);
        prod.setProdNo(prodNo);
        ProdDTO totalQuan = mapper.findRootProd(prod); // 본사의 제품 정보를 가져옴
        if (storeName != null) { // 매장이 존재한다면
            if (reqQuan <= totalQuan.getQuan() && totalQuan.getQuan() > 0) { // 본사 재고의 수량을 넘지 않는다면
                int result = mapper.storingProc(storeName, prodNo, reqQuan);
                if (result > 0)
                    return "success";

                return "failed";
            }
            return "재고 수량보다 신청 수량이 많습니다. 다시 시도해 주세요.";
        }
        return "MYPAGE에서 지점명 수정 후 다시 시도해 주세요.";
    }

    public List<ProdDTO> prodList(ProdDTO prod) {

        return mapper.searchProd(prod);
    }

    public void stockList(Model model) {
        ArrayList<OrderStockDTO> stocks = mapper.stockList();

        model.addAttribute("stocks", stocks);
    }

    // 입고 요청 승인
    public String storingApprove(OrderStockDTO store, Model model) {
        int searchProdQuan = mapper.searchRootQuan(store); // 본사가 등록한 재고 수량 확인
        OrderStockDTO searchProdInfo = mapper.searchProdInfo(store); // 매장에서 요청한 수량, prodNo 확인
        int updateRootQuan = searchProdQuan - searchProdInfo.getReqQuan();
        if (updateRootQuan >= 0) {
            ProdDTO prods = new ProdDTO(null, null, null, null);
            prods.setQuan(updateRootQuan);
            prods.setProdNo(searchProdInfo.getProdNo());

            int result = mapper.updateRootQuan(prods); // 본사의 product.quan 수정
            if (result > 0) {
                ProdDTO findRootProd = mapper.findRootProd(prods); // 본사의 product 정보를 가져옴

                prods.setStoreName(searchProdInfo.getReqStore());
                ProdDTO findStoreProd = mapper.findStoreProd(prods); // 매장의 product 정보를 가져옴
                if (findStoreProd != null) { // 기존 정보가 있다면
                    findStoreProd.setQuan(findStoreProd.getQuan() + searchProdInfo.getReqQuan()); // 기존 수량 + 입고 수량
                    mapper.updateStoreProd(findStoreProd); // 같은 매장 정보가 있다면 수량만 업데이트
                } else { // 새 정보라면
                    findRootProd.setQuan(searchProdInfo.getReqQuan());
                    findRootProd.setStoreName(store.getReqStore());
                    mapper.insertStoreProd(findRootProd); // product 테이블에 매장의 재고 정보를 기입
                }
                OrderStockDTO changeStatus = mapper.searchOrderStatus(store);
                mapper.updateOrderStatus(changeStatus); // 승인된 입고 요청 상태를 승인 완료로 변경

                return "success";
            }
            return "failed";
        }
        return "본사 재고 수량보다 많은 값을 입력했습니다. 확인 후 다시 시도해주세요.";
    }

    public String storingDenied(OrderStockDTO store) {
        int result = mapper.storingDenied(store);
        if (result > 0)
            return "success";

        return "failed";
    }

    // 출고
    public String unstoringProc(String prodNo, int respQuan, String storeName) {
        ProdDTO prod = new ProdDTO(null, null, null, null);
        prod.setProdNo(prodNo);
        ProdDTO totalQuan = mapper.findRootProd(prod); // prodNo 값은 유니크 값 => prodNo에 해당하는 수량을 가져와라
        if (respQuan <= totalQuan.getQuan() && totalQuan.getQuan() > 0) { // 출고 수량보다 총 수량이 많으면 ok
            int result = mapper.unstoringProc(prodNo, respQuan, storeName); // 출고 기록용으로 db에 저장(orderStock)

            if (result > 0) {
                int updateRootQuan = totalQuan.getQuan() - respQuan;
                prod.setQuan(updateRootQuan);
                mapper.updateRootQuan(prod); // 본사 재고 수량 업데이트

                prod.setStoreName(storeName);
                ProdDTO findStoreProd = mapper.findStoreProd(prod); // 매장의 product 정보를 가져옴

                if (findStoreProd != null) { // 기존 정보가 있다면
                    findStoreProd.setQuan(findStoreProd.getQuan() + respQuan); // 기존 수량 + 출고 수량
                    mapper.updateStoreProd(findStoreProd); // 같은 매장 정보가 있다면 수량만 업데이트
                } else { // 새 정보라면
                    ProdDTO findRootProd = mapper.findRootProd(prod);

                    findRootProd.setQuan(respQuan);
                    findRootProd.setStoreName(storeName);
                    mapper.insertStoreProd(findRootProd); // product 테이블에 매장의 재고 정보를 기입
                }

                return "success";
            }

            return "failed";
        }
        return "재고 수량보다 입력한 수량이 많습니다. 다시 시도해 주세요.";
    }

    public void storeList(Model model) {
        List<String> storeNames = mapper.storeList();

        model.addAttribute("storeNames", storeNames);
    }

    public List<String[]> listCsvString() { // null값 데이터는 다 버리고 모든 정보 출력
        List<OrderStockDTO> list = mapper.csvList();
        List<String[]> listStrings = new ArrayList<>();
        listStrings.add(new String[] { "매장명", "상품코드", "수량", "결재일", "입출고 상태" });
        for (OrderStockDTO csv : list) {
            String[] rowData = new String[5];
            if (csv.getRespStore() == null) { // 입고 정보
                rowData[0] = csv.getReqStore();
                rowData[1] = csv.getProdNo();
                rowData[2] = Integer.toString(csv.getReqQuan());
                rowData[3] = csv.getReqDate();
                rowData[4] = csv.getOrderStatus();
                listStrings.add(rowData);
            } else if (csv.getReqStore() == null) { // 출고 정보
                rowData[0] = csv.getRespStore();
                rowData[1] = csv.getProdNo();
                rowData[2] = Integer.toString(csv.getRespQuan());
                rowData[3] = csv.getRespDate();
                rowData[4] = csv.getOrderStatus();
                listStrings.add(rowData);
            }
        }
        return listStrings;
    }

}
