<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:: BOARD2 ::</title>
<style>
	.loginInfo {
		height: 50px;
		text-align: right;
	}
	section {
		display: flex;
		width: 100%;
		min-height: 500px; 
	}
	section > div:first-child {
		width: 150px;
		background-color: #eee;
	}
	li {
		list-style: none;
	}
</style>
</head>
<body>

<h1><a href="${cpath }">BOARD2</a></h1>
<div class="loginInfo">
	<c:if test="${not empty login }">
		<a href="${cpath }/member/mypage">${login.userid } (${login.name })</a>
		<a href="${cpath }/member/logout"><button>로그아웃</button></a>
	</c:if>
</div>
<hr>

<section>
	<div>
		<ul>
			<li><a href="${cpath }/member/login">로그인</a></li>
			<li><a href="${cpath }/board">게시판</a></li>
		</ul>
	</div>

