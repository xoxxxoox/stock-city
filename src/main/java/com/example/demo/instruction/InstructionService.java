package com.example.demo.instruction;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import com.example.demo.orderStock.OrderStockMapper;
import com.example.demo.prod.ProdDTO;
import jakarta.servlet.http.HttpSession;

@Service
@Transactional
public class InstructionService {
    @Autowired
    private InstructionMapper mapper;
    @Autowired
    private HttpSession session;
    @Autowired
    private OrderStockMapper orderStockMapper;

    public void instructionform(String cp, Model model) {

    }

    public void instructionwrite(String cp, Model model) {

    }

    @Autowired
    public InstructionService(InstructionMapper mapper) {
        this.mapper = mapper;
    }

    public List<InstructionDTO> getAllInstructionData() {
        List<InstructionDTO> instructionDTOList = mapper.instructionGroupList();
        instructionDTOList.addAll(mapper.prodList());
        instructionDTOList.addAll(mapper.orderStockList());
        instructionDTOList.addAll(mapper.cateList());
        instructionDTOList.addAll(mapper.colorList());

        return instructionDTOList;
    }

    public String instructionwriteProc(String prodNo, int respQuan, String storeName) {

        String id = (String) session.getAttribute("id");
        String sessionId = orderStockMapper.connectName(id);
        ProdDTO prod = new ProdDTO(null, null, null, null);
        prod.setStoreName(sessionId);
        prod.setProdNo(prodNo);
        ProdDTO totalQuan = mapper.findRootInst(prod); // prodNo 값은 유니크 값 => prodNo에 해당하는 수량을 가져와라
        if (respQuan <= totalQuan.getQuan()) { // 출고 수량보다 총 수량이 많으면 ok
            int result = mapper.instwriteProc(storeName, prodNo, respQuan); // 출고 기록용으로 db에 저장(orderStock)

            if (result > 0) {
                int updateRootQuan = totalQuan.getQuan() - respQuan;
                prod.setQuan(updateRootQuan);
                mapper.updateRootQuan(prod); // 요청 매장 재고 업데이트(보내는애)

                prod.setStoreName(storeName); // 요청 받은 매장 재고 업데이트(받는애)
                ProdDTO findStoreInst = mapper.findStoreInst(prod); // 매장의 product 정보를 가져옴

                InstructionDTO inst = new InstructionDTO();
                inst.setProdNo(findStoreInst.getProdNo());
                inst.setProdName(findStoreInst.getProdName());
                inst.setColorCode(findStoreInst.getColorCode());
                inst.setSize(findStoreInst.getSize());
                inst.setRespStore(findStoreInst.getStoreName());
                inst.setRespQuan(respQuan);
                mapper.insertStoreInst(inst);

                return "success";
            }

            return "failed";
        }
        return "재고 수량보다 입력한 수량이 많습니다. 다시 시도해 주세요.";
    }

    public List<InstructionDTO> instructionlist(String regDate) {
        List<InstructionDTO> instructionlist = mapper.getDate(regDate);
        System.out.println(instructionlist);
        return instructionlist;
    }

}
