<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<div>
	<h2>게시판</h2>
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
				<td><fmt:formatDate value="${dto.writeDate }" pattern="yyyy-MM-dd a hh:mm" /></td>
				<td>${dto.ipaddr }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="menu">
		<div></div>
		<div>
			<a href="${cpath }/board/write"><button>작성</button></a>
		</div>
	</div>
</div>
</section>

</body>
</html>