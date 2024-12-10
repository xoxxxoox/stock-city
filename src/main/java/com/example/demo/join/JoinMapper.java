package com.example.demo.join;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface JoinMapper {

    int registProc(JoinDTO joins);

    void insertStoreNo(StoreDTO store);

    void updateStoreNo(StoreDTO stores);

    JoinDTO findJoin(String id);

    JoinDTO findBN(String businessNo);

    JoinDTO findEmail(String email);

    JoinDTO findDbName(String uniqueDbName);

    StoreDTO findStoreNo(String uniqueStoreNo);

    JoinDTO checkStatus(String id);

    int updateProc(JoinDTO joins);

    ArrayList<JoinDTO> manageInfo(JoinDTO join);

    int statusModify(JoinDTO join);

    int storeDeleteProc(JoinDTO join);
}
