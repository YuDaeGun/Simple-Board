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
		min-width: 800px;
		max-width: 1200px;
		margin: auto;
		min-height: 500px; 
	}
	section > div:first-child {
		width: 200px;
		background-color: #eee;
	}
	section > div:last-child {
		width: 100%;
		padding-left: 20px;
	}
	section > div:last-child > table {
		width: 100%;
		border: 5px double black;
		padding: 20px;
		margin-bottom: 20px;
	}
	section > div:last-child > table > thead > tr > th:nth-child(2) {
		min-width: 300px;
	}
	section > div:last-child > table > tbody > tr > td {
		text-align: center;
	}
	section > div:last-child > table > tbody > tr > td:nth-child(2) {
		text-align: left;
	}
	.menu {
		display: flex;
		justify-content: space-between;
	}
	form textarea {
		width: 500px;
		height: 300px;
		resize: none;
	}
	input[type="text"],
	input[type="search"],
	input[type="password"],
	select,
	textarea {
		padding: 5px 10px;
		box-sizing: border-box;
	}
	input[type="submit"],
	input[type="button"],
	button {
		background-color: white;
		color: black;
		width: 120px;
		height: 30px;
		line-height: 30px;
		cursor: pointer;
		font-weight: bold;
		border-radius: 10px;
		transition-duration: 0.3s;
	}
	input[type="submit"]:hover,
	input[type="button"]:hover,
	button:hover {
		background-color: black;
		color: white;
		transition-duration: 0.3s;
		box-shadow: 5px 10px 10px grey;
	}
	a {
		text-decoration: none;
		color: inherit;
	}
	a:hover {
		text-decoration: underline;
	}
	
	#contextMenu {
		display: none;
		border: 2px solid black;
		border-radius: 10px;
		padding: 10px;
		box-shadow: 5px 10px 10px grey;
		width: 150px;
		background-color: white;
	}
	section > div:last-child > table > tbody > tr > td:nth-child(3) {
		font-weight: bold;
		cursor: pointer;
	}
	.pagingNumber {
		text-align: center;
		color: #555;
		margin-top: 20px;
	}
	.currentPage {
		font-weight: bold;
		color: black;
	}
	pre {
		min-height: 300px;
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

