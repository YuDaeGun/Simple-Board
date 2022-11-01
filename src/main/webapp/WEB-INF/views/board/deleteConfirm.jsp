<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<script>
	const flag = confirm('정말 삭제하시겠습니까')
	if(flag) {
		location.href = '${cpath}/board/delete/${idx}'
	}
	else {
		location.href = '${cpath}/board/view/${idx}'
	}
</script>

</body>
</html>