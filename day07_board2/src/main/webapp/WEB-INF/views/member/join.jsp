<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

	<div>
		<h2>회원가입</h2>
		<form method="POST">
			<table>
				<tr>
					<td>ID</td>
					<td><input type="text" name="userid" placeholder="ID" autofocus required></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" name="userpw" placeholder="Password" required></td>
				</tr>
				<tr>
					<td>Name</td>
					<td><input type="text" name="name" placeholder="이름" required></td>
				</tr>
				<tr>
					<td>Email</td>
					<td><input type="email" name="email" placeholder="foo@bar.com" required></td>
				</tr>
				<tr>
					<td>Birth</td>
					<td><input type="date" name="birth"></td>
				</tr>
			</table>
			<input type="submit" value="가입신청">
		</form>
	</div>
</section>

</body>
</html>