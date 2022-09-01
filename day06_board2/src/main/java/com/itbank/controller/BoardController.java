package com.itbank.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.board.BoardDTO;
import com.itbank.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired private BoardService boardService;
	
	@GetMapping
	public ModelAndView board() {
		ModelAndView mav = new ModelAndView("/board/list");
		List<BoardDTO> list = boardService.selectList();
		mav.addObject("list", list);
		return mav;
	} 
	
	@GetMapping("/view/{idx}")
	public ModelAndView view(@PathVariable int idx, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("board/view");
		
		// HttpServletRequest의 getHeader() 메서드를 이용하여 클라이언트의 다양한 정보를 얻을 수 있다
		String host = request.getHeader("host");		// 접속 IP
		String referer = request.getHeader("referer");	// 현재 페이지로 오기 전의  URL
		String requestURL = request.getRequestURL().toString();	// 요청받은 페이지
		System.out.println("host : " + host);
		System.out.println("referer : " + referer);
		System.out.println("requestURL : " + requestURL);
		System.out.println();
		
		BoardDTO dto = boardService.viewBoard(idx);
		mav.addObject("dto", dto);
		return mav;
	}
	
	@GetMapping("/write")
	public void write() {}
	@PostMapping("/write")
	public String write(BoardDTO dto) throws IllegalStateException, IOException {
		int row = boardService.write(dto);
		System.out.println(row != 0 ? "작성 성공" : "작성 실패");
		return "redirect:/board";
	}
}








