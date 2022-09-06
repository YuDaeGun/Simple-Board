<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
	<form method="POST" class="replyForm">
		<input type="hidden" name="writer" value="${login.userid }">
		<c:set var="pl" value="로그인 중인 회원만 댓글을 작성할 수 있습니다" />
		<c:if test="${not empty login }">
			<c:set var="pl" value="바르고 고운 말을 사용합시다" />	
		</c:if>
		<div class="sb">
			<div></div>
			<div>
				<textarea class="replyText"
						  name="content"
						  placeholder="${pl }"></textarea>
				<input type="submit" value="댓글작성">
			</div>
		</div>
	</form>
	
	<div>
	<c:forEach var="reply" items="${replyList }">
		<div class="reply">
			<div class="sb">
				<div>${reply.writer } | ${reply.writeDate }</div>
				<div>
					<a href="">수정(미구현)</a>
					<a class="replyDeleteBtn"
					   href="${cpath }/board/deleteReply/${dto.idx }/${reply.idx}"
					   data-idx="${reply.idx }">삭제</a>
				</div>
			</div>
			<div><pre>${reply.content }</pre></div>
		</div>
	</c:forEach>
	</div>
	
</div>

<script>
	const replyDeleteBtnList = document.querySelectorAll('.replyDeleteBtn')
	
	const replyDeleteHandler = function(event) {
		event.preventDefault()
		const idx = event.target.dataset.idx
		const flag = confirm('댓글을 삭제하시겠습니까?')
		if(flag) {
			location.href = event.target.href
		}
	}
	
	for(let i = 0; i < replyDeleteBtnList.length; i++) {
		const replyDeleteBtn = replyDeleteBtnList[i]
		replyDeleteBtn.onclick = replyDeleteHandler
	}
</script>

<script>
	const replyText = document.querySelector('textarea.replyText')
	const replyForm = document.querySelector('form.replyForm')
	const replyWriter = document.querySelector('input[name="writer"]').value
	
	const replyLoginHandler = function(event) {
		event.preventDefault()
		
		if(replyWriter == '') {
			const flag = confirm('댓글을 작성하려면 로그인이 필요합니다.\n로그인 페이지로 이동하시겠습니까?')
			if(flag) {
				const currentURL = location.href
				location.href = '${cpath}/member/login?url=' + currentURL
			}
		}
		else if(event.target == replyForm && replyText.value == '') {
			alert('댓글 내용을 작성해야 합니다')
			replyText.focus()
		}
		else if(event.type == 'submit') {
			event.target.submit()
		}
	}
	replyText.onclick = replyLoginHandler
	replyForm.onsubmit = replyLoginHandler
</script>

</section>












