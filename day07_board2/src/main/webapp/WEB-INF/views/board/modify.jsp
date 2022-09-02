<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<div>
	<h2>게시글 수정</h2>
	<form method="POST" enctype="multipart/form-data">
		<input type="hidden" name="idx" value="${dto.idx }">
		<p>
			<select name="category">
				<option ${dto.category == '일반' ? 'selected' : ''}>일반</option>
				<option ${dto.category == '공지' ? 'selected' : ''}>공지</option>
				<option ${dto.category == '등산' ? 'selected' : ''}>등산</option>
				<option ${dto.category == '게임' ? 'selected' : ''}>게임</option>
				<option ${dto.category == '여행' ? 'selected' : ''}>여행</option>
			</select>
			<input type="text" name="title" placeholder="제목" required autofocus value="${dto.title }">
		</p>
		<p>수정중 -> <input type="text" name="writer" value="${login.userid }" readonly></p>
		<p><textarea name="content" placeholder="내용을 입력하세요" required>${dto.content }</textarea></p>
		<p><input type="file" name="upload"></p>
		<p><input type="submit"></p>
	</form>
</div>

</section>

</body>
</html>

