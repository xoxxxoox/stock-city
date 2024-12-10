package com.example.demo.instruction;

import java.util.Collection;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.prod.ProdDTO;

@Mapper
public interface InstructionMapper {

    List<InstructionDTO> instructionGroupList();

    Collection<? extends InstructionDTO> prodList();

    Collection<? extends InstructionDTO> orderStockList();

    Collection<? extends InstructionDTO> cateList();

    Collection<? extends InstructionDTO> colorList();

    void updateRootQuan(ProdDTO prod);

    int instwriteProc(@Param("storeName") String storeName, @Param("prodNo") String prodNo,
            @Param("respQuan") int respQuan);

    ProdDTO findStoreInst(ProdDTO prod);

    void insertStoreInst(InstructionDTO inst);

    void updateStoreInst(InstructionDTO inst);

    ProdDTO findRootInst(ProdDTO prod);

    List<InstructionDTO> getDate(@Param("regDate") String regDate);

}
