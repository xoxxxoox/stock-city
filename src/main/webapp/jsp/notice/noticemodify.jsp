<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>공지사항 글 수정</title>
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
                    /* 폼의 최대 너비 설정 */
                }

                .header-section {
                    display: flex;
                    align-items: center;
                    margin-bottom: 20px;
                }

                .page-name-box {
                    display: flex;
                    margin-top: 30px;
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

                .meddle {
                    margin-bottom: px;
                }

                .label {
                    font-size: 18px;
                    color: #555;
                }

                .form-control {
                    font-size: 16px;
                    /* 추가 스타일은 JavaScript로 조절합니다. */
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
                    background-color: #f5f5f5;
                }

                /* 추가된 스타일 */

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

                .btn-box {
                    margin-left: 55%;
                }


                .file {
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
                            <div class="page-name">글 수정</div>
                        </div>
                    </div>
                    <form action="/noticemodifyProc" method="post">
                        <input type="hidden" name="no" value="${notice.no }" />
                        <div class="meddle">
                            <label for="title">제목</label>
                            <input type="text" class="form-control" name="title" id="title" value="${notice.title }" />
                        </div>

                        <div id="styleInfo"></div>

                        <!-- 추가된 부분: 상단 선 -->
                        <div class="bottom-line "></div>

                        <div class="meddle">
                            <label for="content">내용수정</label>

                            <!-- Quill 에디터에서 가져온 내용이 담긴 숨겨진 textarea -->
                            <textarea name="content" id="content" style="display: none;"></textarea>
                            <div id="editor">${notice.content }</div>
                        </div>
                </div>
                </div>

                <div class="meddle">
                    <div class="file">
                        <label for="fileName">파일첨부</label>
                        <div style="display: flex; align-items: center;">
                            <input type="file" name="FileName" />
                            <span>${notice.fileName }</span>
                        </div>
                    </div>

                    <div class="btn-box">
                        <input type="submit" class="btn btn-sm btn-primary custom-button" id="btnSave" value="제출">
                        <button type="button" class="btn btn-sm btn-primary custom-button"
                            onclick="location.href='noticeform'">목록</button>
                        <button type="button" class="btn btn-sm btn-primary custom-button" id="btnbefore"
                            onclick="history.back()">이전</button>
                    </div>
                    </form>
                </div>
            </article>

            <script>
                // 스크립트를 여러 번 로드되는 것을 방지하기 위한 체크
                if (typeof quill === 'undefined') {
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
                        var textContent = quill.getText();
                        console.log(textContent); // 콘솔에서 텍스트 내용 확인
                        $('#content').val(textContent);
                    });

                }

                $(document).on('click', '#btnList', function (e) {
                    e.preventDefault();
                    location.href = "/notice/noticeform";
                });


            </script>
        </body>

        </html>