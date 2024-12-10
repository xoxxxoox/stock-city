package com.example.demo.admin;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.join.JoinDTO;

@Mapper
public interface AdminMapper {
    
    ArrayList<AdminDTO> findAll();

    int adminRegistProc(AdminDTO admins);

    AdminDTO findAdmin(String aId);

    ArrayList<JoinDTO> adminInfo(JoinDTO join);

    JoinDTO checkAccount(String email);

    int verifyProc(JoinDTO joins);

    int adminStatusActiveModify(JoinDTO join);

    int adminStatusInactiveModify(JoinDTO join);

    int adminRootDeleteProc(JoinDTO join);

    JoinDTO checkMainId(String mainId);

    void updateAdCount(JoinDTO joins);
}
