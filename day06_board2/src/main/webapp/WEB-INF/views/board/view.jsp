<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<div>
	<h2>게시글 읽기</h2>
	
	<div class="sb">
		<div>
			${dto.idx } | ${dto.category } | ${dto.title } | ${dto.writer }
		</div>
		<div>
			${dto.viewCount } | ${dto.writeDate } | ${dto.ipaddr }
		</div>
	</div>
	<pre>${dto.content }</pre>
	<c:if test="${not empty dto.uploadFile }">
		<img src="${cpath }/upload/${dto.uploadFile }">
	</c:if>
	<div class="menu">
		<div>
			<button onclick="history.back()">목록</button>
		</div>
		<div>
			<a href=""><button>수정(미구현)</button></a>
			<a href=""><button>삭제(미구현)</button></a>
		</div>
	</div>
</div>
</section>
</body>
</html>