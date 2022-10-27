<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cpath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>:: BOARD ::</title>
<style>
	.loginInfo {
		height: 50px;
		text-align: right;
		position: sticky;
		top: 0px;
		padding-top: 20px;
		padding-right: 20px;
		background-color: white;
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
	
	/* 댓글 */
	form.replyForm {
		height: 100px;
		margin-bottom: 10px;
	}
	form.replyForm input[type="submit"] {
		height: 80px;
		margin: 10px;
	}
	.sb {
		display: flex;
		justify-content: space-between;
	}
	form.replyForm .sb > div:last-child {
		display: flex;
		align-items: center;
	}
	.replyForm > .sb > div:last-child {
		padding: 10px;
	}
	textarea.replyText {
		height: 90px;
	}
	.reply {
		background-color: #f5f6f7;
		border: 5px solid #dadada;
		margin: 10px;
		border-radius: 5px 20px 5px 20px;
		box-sizing: border-box;
	}
	.reply > div:first-child {
		padding: 10px;
	}
	.reply > div:nth-child(2) {
		padding: 10px;
		background-color: white;
	}
	.reply > div:nth-child(2) > pre {
		width: inherit;
		min-height: 70px;
	} 
	.shadow {
		box-shadow: 0px 10px 20px black;
	}
	body {
		padding: 0;
		margin: 0;
	}
	h1 {
		padding-left: 20px;
	}
</style>
</head>
<body>

<h1><a href="${cpath }">BOARD3</a></h1>
<div class="loginInfo">
	<c:if test="${empty login }">
		<a id="nav_login" href="${cpath }/member/login"><button>로그인</button></a>
	</c:if>
	<c:if test="${not empty login }">
		<a href="${cpath }/member/mypage">${login.userid } (${login.name })</a>
		<a href="${cpath }/member/logout"><button>로그아웃</button></a>
	</c:if>
</div>
<hr>

<script>
	window.onscroll = function() {
		const loginInfo = document.querySelector('.loginInfo')
		if(loginInfo.classList.contains('shadow') == false && loginInfo.offsetTop > 86) {
			loginInfo.classList.add('shadow')
		}
		if(loginInfo.classList.contains('shadow') && loginInfo.offsetTop <= 86) {
			loginInfo.classList.remove('shadow')
		}
	}
</script>

<script>
	const nav_login = document.getElementById('nav_login')	// a 태그를 불러온다
	
	const nav_login_handler = function(event) {
		event.preventDefault()			// 링크를 클릭했으나 일단 이동을 보류한다
		let target = event.target		// 클릭된 대상을 불러온다 (이벤트는 a에 걸었으나 클릭당한 대상은 button이다)
		while(target.tagName != 'A') {	// target에 저장된 요소의 태그 이름이 A가 아니라면
			target = target.parentNode	// 현재 대상의 부모 노드를 target에 저장한다
		}
		const url = target.href + '?url=' + location.href	// target은 이제 A이므로, href를 참조할 수 있다
		location.href = url		// 만들어진 주소로 이동
	}
	if(nav_login != null) {
		nav_login.onclick = nav_login_handler
	}
</script>

<section>
	<div>
		<ul>
			<li><a href="${cpath }/member/login">로그인</a></li>
			<li><a href="${cpath }/board">게시판</a></li>
		</ul>
	</div>

