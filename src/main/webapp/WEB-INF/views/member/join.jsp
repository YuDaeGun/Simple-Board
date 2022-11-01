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
					<td id="dupCheckMessage"></td>
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

<script>
	// 1. 어떤 요소에 이벤트를 걸어야 하는가? 	<input type="text" name="userid">
	const input = document.querySelector('input[name="userid"]')
	
	// 2. 어떤 함수를 실행할 것인가?
	const dupCheckHandler = function(event) {
		
		// 3. 핸들러 내부에서 이벤트 소스 이외의 다른 요소를 참조하는가?
		const dupCheckMessage = document.getElementById('dupCheckMessage')
		const userid = event.target.value
		const url = '${cpath}/member/dupCheck/' + userid
		fetch(url)
		.then((resp) => {return resp.json()})
		.then(flag => {
			dupCheckMessage.innerText = flag ? '사용 가능한 ID입니다' : '이미 사용중인 ID입니다'
			dupCheckMessage.style.color = flag ? 'blue' : 'red'	
			dupCheckMessage.style.fontWeight = 'bold'
			if(flag == false) 
				event.target.select()	// 다른 곳을 클릭 못하도록 막자
		})
	}
	// 4. 어떤 종류의 이벤트에 의해 핸들러가 실행되도록 할 것인가?
	// blur : 흐릿해진다. 포커스를 잃는다 -> 포커스를 받았다가 포커스가 다른 요소로 이동할 경우	
	input.addEventListener('blur', dupCheckHandler)
	
</script>

</body>
</html>













