<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


        <html>

        <head>
            <meta charset="UTF-8">
            <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>


            <title>게시글 상세 페이지</title>
            <style>
                body {
                    padding-top: 0;
                    padding-bottom: 30px;
                    margin: 0;
                    font-family: Arial, sans-serif;
                }

                .header-section {
                    display: flex;
                    align-items: center;
                    margin-bottom: 20px;
                }

                .page-name-box {
                    display: flex;
                    margin-top: 20px;
                }

                .site-name {
                    font-size: 32px;
                    font-weight: 900;
                    color: #2895F4;
                    margin-right: 10px;
                }

                .page-name {
                    font-size: 32px;
                    font-weight: 900;
                }

                .container {
                    margin: 100px;
                    padding: 42px;
                }

                .custom-button {
                    color: #999;
                    font-family: 'Monument', 'Noto Sans KR', sans-serif;
                    border: solid 1px #ddd;
                    font-size: 13px;
                    padding: 4px 12px 5px;
                    line-height: 1.4;
                    border-radius: 5px;
                    text-align: left;
                    margin-left: 10px;


                }

                .user-form {
                    margin-bottom: -3px;
                    margin-top: -66px;

                }

                .admin {
                    margin-bottom: 4px;
                    padding-top: 10px;

                }

                .admin label {
                    margin-bottom: 5px;
                    font-weight: bold;
                }

                .form-control {
                    padding: 10px;
                    border: none;
                    /* Remove border */
                    border-radius: 5px;
                }

                .cobo {
                    border-top: 1px solid #ccc;
                    /* Add a line between 작성자 and 내용 */
                    padding-top: 10px;
                    /* Adjust the spacing above 내용 */
                }

                .cobo label {
                    margin-top: 20px;
                    display: block;
                    font-weight: bold;
                }

                .cobo .form-control {
                    margin-top: 10px;
                }

                .bu {
                    /* 버튼 스타일 */
                    margin-left: 7%;
                    margin-top: 1%;

                }

                .fileName {
                    margin-top: 20%;
                    margin-left: 7%;
                }
            </style>
        </head>

        <body>
            <c:import url="/header" />
            <article>
                <div class="header-section">
                    <div class="page-name-box">
                        <div class="site-name">STOCK CITY |</div>
                        <div class="page-name">공지사항</div>
                    </div>
                </div>
                <form name="form" id="form" role="form" method="post" enctype="multipart/form-data">
                    <div class="container" role="main">
                        <div class="user-form">
                            <label for="title">제목</label>
                            <div class="form-control" name="title" id="title">${notice.title}</div>
                        </div>

                        <div class="admin">
                            <label for="id">작성자</label>
                            <div class="form-control" name="id" id="id">${notice.id}</div>
                        </div>

                        <div class="cobo">
                            <label for="content">내용</label>
                            <div class="form-control" rows="5" name="content" id="content">${notice.content}</div>
                        </div>
                    </div>

                    <div test="${not empty notice.fileName}"></div>

                    <div class="meddle">
                        <div class="fileName">
                            <!-- <label for="fileName">파일 이름</label> -->
                            <!-- <div class="form-control" id="FileName">${notice.fileName}</div> -->
                            <a href="/noticeDownload?no=${notice.no}" class="custom-button">파일첨부: ${notice.fileName}</a>
                        </div>
                    </div>



                    <!-- <div class="meddle">
                        <c:if test="${not empty notice.fileName}">
                            <label for="fileName">파일 이름</label>
                            <div class="form-control" id="FileName">${notice.fileName}</div>
                            <a href="noticedownload?no=${notice.no}">파일 첨부</a>
                        </c:if>
                    </div> -->



                    <div>
                        <!-- <c:choose>
                            <c:when test="${sessionScope.id == 'admin'}">
                                <button type="button" class="btn btn-sm btn-primary custom-button"
                                    onclick="location.href='/notice/noticeform'">목록</button>
                                <button type="button" class="btn btn-sm btn-primary custom-button"
                                    onclick="location.href='noticemodify?no=${notice.no}'">수정</button>
                                <button type="button" class="btn btn-sm btn-primary custom-button" id="btnDelete"
                                    onclick="deleteCheck()">삭제</button>
                            </c:when>
                        </c:choose> -->
                        <div class="bu">
                            <button type="button" class="btn btn-sm btn-primary custom-button"
                                onclick="location.href='/notice/noticeform'">목록</button>
                            <button type="button" class="btn btn-sm btn-primary custom-button"
                                onclick="location.href='noticemodify?no=${notice.no}'">수정</button>
                            <button type="button" class="btn btn-sm btn-primary custom-button" id="btnDelete"
                                onclick="deleteCheck()">삭제</button>
                        </div>
                    </div>
                </form>
                </div>
            </article>
            <script>



                $(document).on('click', '#btnModify', function (e) {
                    e.preventDefault();
                    $("#form").attr('action', "/notice/noticemodify");
                    $("#form").submit();
                });

                function deleteCheck() {
                    result = confirm('진짜로 삭제하겠습니까?');
                    if (result == true) {
                        location.href = '/noticedeleteProc?no=${notice.no}';
                    }
                }

                $(document).on('click', '#btnDelete', function (e) {
                    e.preventDefault();
                    $("#form").attr('action', "/noticedeleteProc?no=${notice.no}");
                    $("#form").submit();
                });

            </script>


        </body>

        </html>