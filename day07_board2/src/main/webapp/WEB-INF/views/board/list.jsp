<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<div>
	<h2>
		게시판
		<select id="category"><!-- form태그로 값을 제출할 용도가 아니므로, name이 필요없다 -->
			<option ${empty param.category ? 'selected' : '' } value="">전체</option>
			<option ${param.category == '공지' ? 'selected' : '' } value="공지">공지</option>
			<option ${param.category == '게임' ? 'selected' : '' } value="게임">게임</option>
			<option ${param.category == '일반' ? 'selected' : '' } value="일반">일반</option>
			<option ${param.category == '등산' ? 'selected' : '' } value="등산">등산</option>
			<option ${param.category == '여행' ? 'selected' : '' } value="여행">여행</option>
		</select>
	</h2>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일시</th>
				<th>IP</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="dto" items="${list }">
			<tr>
				<td>${dto.idx }</td>
				<td><a href="${cpath }/board/view/${dto.idx}"><span>[${dto.category }]</span>${dto.title }</a></td>
				<td>${dto.writer }</td>
				<td>${dto.viewCount }</td>
				<td><fmt:formatDate value="${dto.writeDate }" pattern="yyyy-MM-dd hh:mm" /></td>
				<td>${dto.ipaddr }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="menu">
		<div>
		<form>
			<input type="hidden" name="category" value="${param.category }">
			<select name="column" required>
				<option ${param.column == 'title' ? 'selected' : '' } value="title">제목으로 검색</option>
				<option ${param.column == 'writer' ? 'selected' : '' } value="writer">작성자로 검색</option>
				<option ${param.column == 'content' ? 'selected' : '' } value="content">내용으로 검색</option>
			</select>
			<input type="search" name="search" placeholder="검색어를 입력하세요" value="${param.search }">
			<input type="submit" value="검색">
		</form>
		</div>
		<div>
			<a href="${cpath }/board/write"><button>작성</button></a>
		</div>
	</div>
</div>
</section>

<div id="contextMenu"><!-- 우클릭 -->
	<ul>
		<li><a href="">프로필 보기</a></li>
		<li><a href="">쪽지 보내기</a></li>
		<li><a href="">신고하기</a></li>
	</ul>
</div>

<script>
	// 사용자 이름을 우클릭 하면 메뉴가 뜨는 코드
	const userList = document.querySelectorAll('section > div:last-child > table > tbody > tr > td:nth-child(3)')
	
	const contextMenuHandler = function(event) {
		event.preventDefault()	// 기본작동을 막는다 (우클릭 기본 메뉴가 안뜬다)
		const contextMenu = document.getElementById('contextMenu')
		contextMenu.style.position = 'absolute'
		contextMenu.style.top = event.clientY + 'px'
		contextMenu.style.left = event.clientX + 'px'
		contextMenu.style.display = 'block'
	}
	
	userList.forEach(user => user.addEventListener('contextmenu', contextMenuHandler))
	
	// 다른 곳을 클릭하면 나타났던 메뉴가 닫히게 하자
	document.querySelector('body').addEventListener('click', function() {
		document.getElementById('contextMenu').style.display = 'none'
	})
</script>

<script>
	// 카테고리를 선택하면 자동으로 요청하는 코드
	const categorySelect = document.getElementById('category')	// 이벤트 소스
	
	const changeHandler = function(event) {						// 이벤트 핸들러
		const url = '${cpath}/board'
		const value = event.target.value	// select의 현재 선택된 값을 불러온다
		location.href = url + (value != '' ? '?category=' + value : '')
	}
	
	categorySelect.addEventListener('change', changeHandler)	// 이벤트 리스너
	// [event.source]가	[listener]되면, 		[handler]를 호출하여 실행한다 
	// categorySelect가 		change되면,	changeHandler를 호출하여 실행한다
</script>

</body>
</html>