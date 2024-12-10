package com.example.demo.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface NoticeMapper {

    List<NoticeDTO> noticeform(@Param("begin") int begin, @Param("end") int en);

    int totalCount();

    void noticewriteProc(NoticeDTO notice);

    NoticeDTO noticecontent(@Param("no") int n);

    String noticeDownload(int n);

    int noticemodifyProc(NoticeDTO notice);

    void noticedeleteProc(int n);

    void incrementViews(int n);

    List<NoticeDTO> searchTitle(NoticeDTO notice);

}
