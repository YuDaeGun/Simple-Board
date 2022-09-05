<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

	<div>
		<h2>로그인</h2>
		
		<form method="POST">
			<p><input type="text" name="userid" placeholder="ID" required autofocus></p>
			<p><input type="password" name="userpw" placeholder="Password" required></p>
			<p><input type="submit" value="로그인"></p>
		</form>
		
		<div>
			<a href="${cpath }/member/join">아직 회원이 아니십니까?</a>
		</div>
	</div>
</section>

</body>
</html>