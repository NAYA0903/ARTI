<%@page import="com.smhrd.Arti.Model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<link rel="stylesheet" href="/css/Header.css" />	
</head>
<body>
		<header class="Top-Container">
            <div id="top-content">
                <a href="/"><img src="/img/ArtiLogo.png"></a>
                <div id="menu">
                    <div class="menu-container">
                        <a href="#">심리검사</a>
                        <a href="#">스케치북</a>
                        <a href="#">분석결과</a>
                    </div>
                    <div class="AccountContainer">
                    <%
                        // 세션에서 로그인 상태 확인
                        User user = (User) session.getAttribute("user");
                        if (user != null) {
                    %>
                        <!-- 로그인 상태일 때 프로필 표시 -->
                        <div class="auth-button" onclick="location.href='/profile'">
                            <a href="#"><%=user.getNickname() %>님</a>
                        </div>
                    <%
                        } else {
                    %>
                    	<div class="auth-button" onclick="location.href='/welcome'">
                        	<a href="/welcome">로그인</a>
                        <span>|</span>
                        	<a href="#">회원가입</a>
                    	</div>
                    <%
                        }
                    %>
                    </div>
                </div>
            </div>
        </header>
</body>
</html>