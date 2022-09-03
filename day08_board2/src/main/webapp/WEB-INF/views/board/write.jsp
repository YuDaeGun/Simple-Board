<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<div>
	<h2>글 쓰기</h2>
	<form method="POST" enctype="multipart/form-data">
		<p>
			<select name="category">
				<option>일반</option>
				<option>공지</option>
				<option>등산</option>
				<option>게임</option>
				<option>여행</option>
			</select>
			<input type="text" name="title" placeholder="제목" required autofocus>
		</p>
		<p><input type="text" name="writer" value="${login.userid }" readonly></p>
		<p><textarea name="content" placeholder="내용을 입력하세요" required></textarea></p>
		<p><input type="file" name="upload"></p>
		<p><input type="submit"></p>
		<input type="hidden" name="ipaddr" value="${pageContext.request.remoteAddr }">
	</form>
</div>

</section>

</body>
</html>

