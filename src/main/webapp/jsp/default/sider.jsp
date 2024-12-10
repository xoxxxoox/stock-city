<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <link rel="stylesheet" href="/css/sider.css">
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var imageSources1 = ["/image/ad.png"];
                    var currentIndex1 = 0;

                    function rotateImage1() {
                        var rotatingImage1 = document.getElementById('rotating-image');
                        currentIndex1 = (currentIndex1 + 1) % imageSources1.length;
                        rotatingImage1.src = imageSources1[currentIndex1];
                        rotatingImage1.style.width = "20%"; // 이미지 크기 조절 (원하는 크기로 변경)
                    }

                    setInterval(rotateImage1, 1000);
                });

                document.addEventListener('DOMContentLoaded', function () {
                    var imageSources2 = ["/image/son.jpg"];
                    var currentIndex2 = 0;

                    function rotateImage2() {
                        var rotatingImage2 = document.getElementById('rotating-image2');
                        currentIndex2 = (currentIndex2 + 1) % imageSources2.length;
                        rotatingImage2.src = imageSources2[currentIndex2];
                        rotatingImage2.style.width = "100%"; // 이미지 크기 조절 (원하는 크기로 변경)
                    }

                    setInterval(rotateImage2, 1000);
                });

                document.addEventListener('DOMContentLoaded', function () {
                    var imageSources3 = ["/image/ibk.jpg"];
                    var currentIndex3 = 0;

                    function rotateImage3() {
                        var rotatingImage3 = document.getElementById('rotating-image3');
                        currentIndex3 = (currentIndex3 + 1) % imageSources3.length;
                        rotatingImage3.src = imageSources3[currentIndex3];
                        rotatingImage3.style.width = "100%"; // 이미지 크기 조절 (원하는 크기로 변경)
                    }

                    setInterval(rotateImage3, 1000);
                });
            </script>
        </head>

        <body>
            <div class="sidebar">
                <!-- 사이드바 내용 -->
                <div class="sidebar-content">
                    <div style="position: absolute; bottom: 92%; right: 0;">
                        <div id="image-container" style="margin-top: 20px;">
                            <img id="rotating-image" src="/image/loading.gif" style="width: 0%;" alt="Rotating Image">
                        </div>
                    </div>
                    <div style="position: absolute; bottom: 35%; right: 0;">
                        <div id="image-container" style="margin-top: 20px;">
                            <img id="rotating-image2" src="/image/loading.gif" style="width: 100%;" alt="Rotating Image">
                        </div>
                    </div>
                    <div style="position: absolute; bottom: 10%; right: 0;">
                        <div id="image-container" style="margin-top: 20px;">
                            <img id="rotating-image3" src="/image/loading.gif" style="width: 0%;" alt="Rotating Image">
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>