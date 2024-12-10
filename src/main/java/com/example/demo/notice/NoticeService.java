package com.example.demo.notice;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.demo.PageService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class NoticeService {
    @Autowired
    private NoticeMapper mapper;
    private String filePath = "/mountPoint/";

    private NoticeMapper noticeMapper;

    public void noticeform(String cp, Model model, Object jdbcTemplate) {
        // 페이징 처리 변수 설정
        int currentPage = 1;
        try {
            currentPage = Integer.parseInt(cp);
        } catch (Exception e) {
            currentPage = 1;
        }
        // 페이징 변수 계산(그냥 공식 외구기)
        int size = 7; // 한 페이지에 보일 데이터의 수 limit, size
        int start = (currentPage - 1) * size;
        int end = start + size;// 테이블에서 가져올 마지막 행번호

        // 데이터 조회
        List<NoticeDTO> Notices = mapper.noticeform(start, end);
        // 데이터 수 조회
        int totalCount = mapper.totalCount();
        if (totalCount == 0) {
            return;
        }

        // 페이징 처리 결과 생성
        String url = "noticeform?currentPage=";
        String result = PageService.printPage(url, totalCount, size, currentPage);

        // 모델에 데이터 추가
        model.addAttribute("Notices", Notices);
        model.addAttribute("result", result);
    }

    @Autowired
    public NoticeService(NoticeMapper noticeMapper) {
        this.noticeMapper = noticeMapper;
    }

    @Autowired
    private HttpSession session;

    public String noticewriteProc(MultipartHttpServletRequest multi) {
        // System.out.println("title : " + multi.getParameter("title"));

        // 세션에서 사용자 아이디 확인
        String sessionId = (String) session.getAttribute("id"); // 세션 아이디 확인
        if (sessionId == null)
            // sessionId = "admin";

            return "redirect:/";

        // 글 제목 확인 및 공백 처리
        String title = multi.getParameter("title");
        if (title == null || title.trim().isEmpty()) {
            return "redirect:/notice/noticewrite";
        }

        // NoticeDTO 생성 및 데이터 설정
        NoticeDTO noticeDTO = new NoticeDTO();
        noticeDTO.setId(sessionId);
        noticeDTO.setTitle(title);
        noticeDTO.setContent(multi.getParameter("content"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        noticeDTO.setWriteDate(sdf.format(new Date()));
        noticeDTO.setFileName("");

        // 파일 업로드 처리
        MultipartFile file = multi.getFile("fileName");
        if (file != null && !file.isEmpty()) {

            // 파일의 이름
            sdf = new SimpleDateFormat("yyyyMMddHHmmss-");
            String fileTime = sdf.format(new Date());
            String fileName = file.getOriginalFilename();

            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
            System.out.println("NoticeService-notice writeProc-suffix : " + suffix);
            if (suffix.equalsIgnoreCase("pdf") == false) {
                return "redirect:/notice/noticewrite";
            }
            // 파일의 저장 경로
            String fileSaveDirectory = filePath + sessionId;
            System.out.println("경로 : " + fileSaveDirectory);
            File f = new File(fileSaveDirectory);
            if (f.exists() == false) {
                f.mkdirs();
            }

            String fullPath = fileSaveDirectory + "/" + fileTime + fileName;
            System.out.println("풀경로 : " + fullPath);
            noticeDTO.setFileName(fullPath);
            f = new File(fullPath);
            try {
                file.transferTo(f);
            } catch (Exception e) {
                e.printStackTrace();
                noticeDTO.setFileName("");
            }

        }

        mapper.noticewriteProc(noticeDTO); // 글쓰기 데이터 저장:
        return "redirect:/notice/noticeform";
    }

    public NoticeDTO noticecontent(String no) {
        int n = 1;
        try {
            n = Integer.parseInt(no);
        } catch (Exception e) {
            return null;
        }

        NoticeDTO notice = mapper.noticecontent(n);
        if (notice != null && notice.getFileName() != null) {
            String[] names = notice.getFileName().split("/");
            System.out.println("글내용" + notice.getContent());
            System.out.println("글제목" + notice.getTitle());
            for (String name : names)
                System.out.println("NoticeService-noticecontent name : " + name);

            // names 배열의 길이가 충분한지 확인
            if (names.length > 4) {
                String[] fileNames = names[4].split("-", 2);

                // fileNames 배열의 길이가 충분한지 확인
                if (fileNames.length > 1) {
                    for (String fileName : fileNames)
                        System.out.println("NoticeService-noticecontent fileName : " + fileName);

                    // 유효한 인덱스에만 접근
                    notice.setFileName(fileNames[1]);
                } else {
                    // 적절한 에러 처리 또는 로깅
                }
            } else {
                // 적절한 에러 처리 또는 로깅
            }

            mapper.incrementViews(n);
            notice.setContent(notice.getContent());
            notice.setViews(notice.getViews() + 1);

        }

        return notice;
    }

    public void noticeDownload(String no, HttpServletResponse response) {
        int n = 1;
        try {
            n = Integer.parseInt(no);
        } catch (Exception e) {
            return;
        }

        String fullPath = mapper.noticeDownload(n);
        if (fullPath == null)
            return;

        String[] names = fullPath.split("/");
        String[] fileNames = names[4].split("-", 2);

        try {
            File file = new File(fullPath);
            if (file.exists() == false)
                return;

            response.setHeader("Content-Disposition",
                    // attachment;filename=pom.xml
                    "attachment;filename=" + URLEncoder.encode(fileNames[1], "UTF-8"));

            FileInputStream fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, response.getOutputStream());
            fis.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public String noticemodify(String no, Model model) {
        int n = 0;
        try {
            n = Integer.parseInt(no);
        } catch (Exception e) {
            return "redirect:noticeform";
        }

        NoticeDTO notice = mapper.noticecontent(n);

        if (notice == null)
            return "redirect:noticeform";

        if (notice.getFileName() != null) {
            String[] names = notice.getFileName().split("/");
            if (names.length >= 5) { // 배열 길이 확인
                String[] fileNames = names[4].split("-", 2);
                if (fileNames.length >= 2) { // 배열 길이 확인
                    notice.setFileName(fileNames[1]);
                }
            }
        }

        model.addAttribute("notice", notice);
        return "/notice/noticemodify";
    }

    public String noticemodifyProc(NoticeDTO notice) {

        NoticeDTO check = mapper.noticecontent(notice.getNo());
        if (check == null)
            return "게시글 번호에 문제가 발생했습니다. 다시 시도하세요.";

        // 세션 아이디 확인
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null) {
            return "세션에 로그인 정보가 없습니다."; // 세션 아이디가 null인 경우 처리
        }

        // 작성자와 세션 아이디가 같은지 확인
        if (!check.getId().equals(sessionId)) {
            return "작성자만 수정할 수 있습니다.";
        }

        if (notice.getTitle() == null || notice.getTitle().trim().isEmpty()) {
            return "제목을 입력하세요.";
        }

        int result = mapper.noticemodifyProc(notice);
        if (result == 0)
            return "게시글 수정에 실패했습니다. 다시 시도하세요.";

        return "게시글 수정 성공";
    }

    public void modifyNoticeFile(NoticeDTO notice, String newFileName) {
        String existingFileName = notice.getFileName();

        if (newFileName != null && !newFileName.isEmpty()) {
            // 새로운 파일이 업로드된 경우
            if (existingFileName != null && !existingFileName.isEmpty()) {
                // 기존 파일이 존재하면 삭제 또는 보관 등의 로직 수행
                // 예를 들어, 파일 시스템에서 파일을 삭제하거나 다른 디렉토리로 이동하는 등의 작업이 필요
                // 이 작업을 수행한 후에 새로운 파일로 교체
                notice.setFileName(newFileName);
            } else {
                // 기존 파일이 없으면 그냥 새로운 파일로 설정
                notice.setFileName(newFileName);

            }
        }
    }

    public String noticedeleteProc(String no) {
        // 파일이 존재하면 삭제
        int n = 0;
        try {
            n = Integer.parseInt(no);
        } catch (Exception e) {
            return "게시글 번호에 문제가 발생했습니다. 다시 시도하세요.";
        }

        NoticeDTO notice = mapper.noticecontent(n);
        if (notice == null)
            return "게시글 번호에 문제가 발생했습니다. 다시 시도하세요.";

        // 로그인한 아이디와 작성자 아이디가 같은지 확인
        String sessionId = (String) session.getAttribute("id");
        // if(Notice.getId().equals(sessionId) == false)
        // return "작성자만 삭제 할 수 있습니다.";

        String fullPath = notice.getFileName();
        if (fullPath != null) { // 테이블에 파일의 경로와 이름이 있다면
            File f = new File(fullPath);
            if (f.exists() == true) // 파일 저장소에 파일이 존재한다면
                f.delete();
        }

        // 테이블에서 게시글번호와 일치하는 행(row)삭제
        mapper.noticedeleteProc(n);
        return "게시글 삭제 완료";
    }

    public List<NoticeDTO> searchTitle(NoticeDTO notice) {

        return mapper.searchTitle(notice);
    }

}
