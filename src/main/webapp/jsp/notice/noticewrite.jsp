<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>공지사항 글쓰기</title>
            <!-- Bootstrap CSS -->
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
                integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
                crossorigin="anonymous">
            <!-- Main Quill library -->
            <script src="//cdn.quilljs.com/1.3.6/quill.min.js"></script>
            <!-- Theme included stylesheets -->
            <link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
            <!-- jQuery -->
            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
                crossorigin="anonymous"></script>
            <style>
                body {
                    padding-top: 0px;
                    padding-bottom: 30px;
                    font-family: 'Arial', sans-serif;
                    /* 기본 글꼴 지정 */
                }

                .container {
                    max-width: 600px;
                    margin: 0 auto;
                }

                .header-section {
                    text-align: center;
                    margin-bottom: 20px;
                }

                .page-name-box {
                    text-align: center;
                    margin-top: 30px;
                }

                .btn-box {
                    text-align: center;
                    margin-top: 15px;
                    margin-left: 24%;
                }

                .meddle {
                    margin-bottom: 15px;
                }

                .form-container {
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                }

                /* 추가된 부분 */
                @media (min-width: 768px) {
                    .form-container {
                        flex-direction: row;
                        justify-content: center;
                    }
                }

                .site-name {
                    font-size: 32px;
                    font-weight: 900;
                    color: #2895F4;
                    margin-right: 354px;
                }

                .page-name {
                    font-size: 32px;
                    font-weight: 900;
                    margin-top: -8%;
                }

                .label {
                    font-size: 18px;
                    color: #555;
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
                    margin-left: 11px;
                    background-color: #f5f5f5;

                }



                /* 추가된 스타일 */
                .top-line,
                .bottom-line {
                    height: 1px;
                    background-color: #ddd;
                    margin-bottom: 10px;
                    /* 수정된 부분: 간격 추가 */
                }

                #styleInfo {
                    display: none;
                    position: absolute;
                    background-color: black;
                    color: white;
                    padding: 5px;
                    border-radius: 5px;
                }

                #content {
                    height: 200px;
                    overflow-y: auto;
                }

                #editor {
                    width: 100%;
                    /* 또는 다른 원하는 값으로 설정하세요 */
                    height: 600px;
                    overflow-y: auto;
                }

                .fi-pa {
                    margin-left: 35%;
                }
            </style>
        </head>

        <body>
            <c:import url="/header" />
            <article>
                <div class="container" role="main">
                    <div class="header-section">
                        <div class="page-name-box">
                            <div class="site-name">Stock City | </div>
                            <div class="page-name">글쓰기</div>
                        </div>
                    </div>
                    <form name="form" id="form" method="post" enctype="multipart/form-data">
                        <div class="meddle">
                            <label for="title">제목</label>
                            <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
                        </div>

                        <!-- 추가된 부분: 상단 선 -->
                        <div class="top-line"></div>
                        <div id="styleInfo"></div>

                        <!-- 추가된 부분: 상단 선 -->
                        <div class="bottom-line "></div>

                        <div class="meddle">
                            <label for="content">내용</label>
                            <!-- Quill 에디터로 사용할 div -->
                            <div id="editor"></div>
                            <!-- 실제 내용을 전달할 input -->
                            <input type="hidden" id="content" name="content">
                        </div>
                </div>
                <div class="fi-pa">
                    <div class="meddle">
                        <label for="fileName">파일첨부</label>
                        <input type="file" name="fileName">
                    </div>

                </div>

                <div class="btn-box">
                    <input type="submit" class="btn btn-sm btn-primary custom-button" id="btnSave" value="저장">
                    <input type="button" class="btn btn-sm btn-primary custom-button" id="btnList" value="목록">
                </div>
                </form>
                </div>
            </article>

            <script>
                $(document).ready(function () {
                    var quill = new Quill('#editor', {
                        theme: 'snow',
                        modules: {
                            toolbar: [
                                [{ header: [1, 2, false] }],
                                ['bold', 'italic', 'underline', 'strike'],
                                ['blockquote', 'code-block'],
                                [{ 'header': 1 }, { 'header': 2 }],
                                [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                                [{ 'script': 'sub' }, { 'script': 'super' }],
                                [{ 'indent': '-1' }, { 'indent': '+1' }],
                                ['link', 'image', 'video'],
                                ['clean']
                            ]
                        },
                    });
                    quill.on('text-change', function () {
                        var htmlContent = $('#editor .ql-editor').html();
                        console.log(htmlContent); // 콘솔에서 HTML 내용 확인
                        $('#content').val(htmlContent);
                    });

                    $(document).on('click', '#btnList', function (e) {
                        e.preventDefault();
                        location.href = "/notice/noticeform";
                    });
                });
                $(document).on('click', '#btnSave', function (e) {
                    e.preventDefault();
                    $("#form").attr('action', "${pageContext.request.contextPath}/notice/noticewriteProc");
                    $("#form").submit();
                });

            </script>

        </body>

        </html>