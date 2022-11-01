package com.test.interceptor;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.test.board.BoardDAO;
import com.test.board.BoardDTO;
import com.test.member.MemberDTO;

public class BoardInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired private BoardDAO boardDAO;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		MemberDTO login = (MemberDTO)request.getSession().getAttribute("login");
		String url = request.getRequestURL().toString();
		
		// 로그인이 되어 있지 않으면 로그인 페이지로 이동
		if(login == null) {
			response.sendRedirect(request.getContextPath() + "/member/login?url=" + URLEncoder.encode(url, "utf-8"));
			return false;
		}
		
		// 로그인이 되어 있으나 작성자와 로그인 사용자가 일치하지 않으면 view로 이동
		// 요청주소에서 수정 혹은 삭제를 원하는 게시글의 번호를 추출한다 ex) http://localhost:8080/day09/board/modify/1018 -> 1018
		String idx = url.substring(url.lastIndexOf("/") + 1);
		BoardDTO dto = boardDAO.selectOne(Integer.parseInt(idx));
		
		if(dto.getWriter().equals(login.getUserid()) == false) {
			url = url.replace("modify", "view");
			url = url.replace("deleteConfirm", "view");
			request.setAttribute("url", url);
			request.getRequestDispatcher("/WEB-INF/views/alert.jsp").forward(request, response);
		 	// RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/alert.jsp");
		 	// rd.forward(request, response);
			return false;
		}
		return true;
	}
}
