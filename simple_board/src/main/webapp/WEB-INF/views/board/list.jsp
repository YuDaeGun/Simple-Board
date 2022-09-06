<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<c:set var="p" value="${empty param.page ? 1 : param.page }" />

<div>
	<h2>
		게시판
		<select id="category">
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
				<td><a href="${cpath }/board/view/${dto.idx}?page=${p}&category=${param.category}&column=${param.column}&search=${param.search}"><span>[${dto.category }]</span>${dto.title }</a></td>
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
	<div class="pagingNumber">
		<c:if test="${paging.prev }">
			<a href="${cpath }/board?page=${paging.begin - 1}&category=${param.category}&column=${param.column}&search=${param.search}">[이전]</a>
		</c:if>
		
		<c:forEach var="i" begin="${paging.begin }" end="${paging.end }">
			<span class="${p == i ? 'currentPage' : '' }">
				<a href="${cpath }/board?page=${i}&category=${param.category}&column=${param.column}&search=${param.search}">[${i }]</a>
			</span>
		</c:forEach>
		
		<c:if test="${paging.next }">
			<a href="${cpath }/board?page=${paging.end + 1}&category=${param.category}&column=${param.column}&search=${param.search}">[다음]</a>
		</c:if>
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
	const userList = document.querySelectorAll('section > div:last-child > table > tbody > tr > td:nth-child(3)')
	
	const contextMenuHandler = function(event) {
		event.preventDefault()
		const contextMenu = document.getElementById('contextMenu')
		contextMenu.style.position = 'absolute'
		contextMenu.style.top = event.clientY + 'px'
		contextMenu.style.left = event.clientX + 'px'
		contextMenu.style.display = 'block'
	}
	
	userList.forEach(user => user.addEventListener('contextmenu', contextMenuHandler))
	
	document.querySelector('body').addEventListener('click', function() {
		document.getElementById('contextMenu').style.display = 'none'
	})
</script>

<script>
	const categorySelect = document.getElementById('category')
	
	const changeHandler = function(event) {
		const url = '${cpath}/board'
		const value = event.target.value
		location.href = url + (value != '' ? '?category=' + value : '')
	}
	
	categorySelect.addEventListener('change', changeHandler)
</script>

</body>
</html>