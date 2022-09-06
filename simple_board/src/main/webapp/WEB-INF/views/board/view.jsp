<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<div>	
	
	<h2>게시글 읽기</h2>
	
	<div class="sb">
		<div class="sb">
			${dto.idx } | ${dto.category } | ${dto.title } | ${dto.writer } |&nbsp;
		</div>
		<div>
			${dto.viewCount } | ${dto.writeDate } | ${dto.ipaddr }
		</div>
	</div>
	<pre>${dto.content }</pre>
	<c:if test="${not empty dto.uploadFile }">
		<img src="${cpath }/upload/${dto.uploadFile }" height="200px">
	</c:if>
	<div class="menu">
		<div>
			<a href="${cpath }/board"><button>목록</button></a>
		</div>
		<div>
<%-- 		<c:if test="${sessionScope.login.userid == dto.writer }"> --%>
			<a href="${cpath }/board/modify/${dto.idx}"><button>수정</button></a>
			<button id="deleteBtn">삭제</button>
<%-- 		</c:if> --%>
		</div>
	</div>
</div>
</section>

<section>
	<div></div>
	<%@ include file="reply.jsp" %>

<section>
	<div></div>
	<%@ include file="footer.jsp" %>

<script>
	const deleteBtn = document.getElementById('deleteBtn')
	
	const deleteHandler = function() {
			location.href = '${cpath}/board/deleteConfirm/${dto.idx}'
	}
	
	deleteBtn.addEventListener('click', deleteHandler)
</script>


</body>
</html>