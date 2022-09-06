package com.itbank.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.board.BoardDTO;
import com.itbank.board.Paging;
import com.itbank.board.ReplyDTO;
import com.itbank.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired private BoardService boardService;
	
	@GetMapping("")
	public ModelAndView board(@RequestParam HashMap<String, Object> param, 
							  @RequestParam(defaultValue = "1") int page) {
		
		ModelAndView mav = new ModelAndView("/board/list");
		int boardCount = boardService.selectBoardCount(param);
		Paging paging = new Paging(page, boardCount);
		param.put("paging", paging);
		
		List<BoardDTO> list = boardService.selectList(param);
		mav.addObject("list", list);
		mav.addObject("paging", paging);
		return mav;
	}
	
	@GetMapping("/view/{idx}")
	public ModelAndView view(@PathVariable int idx, HttpServletRequest request, 
							 @RequestParam HashMap<String, Object> param, 
							 @RequestParam(defaultValue = "1") int page) {

		ModelAndView mav = board(param, page);
		mav.setViewName("board/view");
		
		String referer = request.getHeader("referer");
		String requestURL = request.getRequestURL().toString();
		
		// 새로고침 조회수 작업 막기
		if(requestURL.equals(referer.split("\\?")[0]) == false) {
			boardService.updateViewCount(idx);
			String url = "board/view/" + idx + "?";
			for(Entry<String, Object> set :  param.entrySet()) {
//				if(set.getKey().equals("paging") == false) {
					url += set.getKey() + "=" + set.getValue() + "&";
//				}
			}
			mav.addObject("url", url);
			mav.setViewName("rd");
			return mav;
		}
		
		BoardDTO dto = boardService.selectOne(idx);
		mav.addObject("dto", dto);
		
		List<ReplyDTO> replyList = boardService.selectReplyList(idx);
		mav.addObject("replyList", replyList);
		
		System.out.println("댓글 리스트 : " + replyList + "\n");
		
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
	
	@GetMapping("/deleteConfirm/{idx}")
	public ModelAndView deleteConfirm(@PathVariable int idx) {
		ModelAndView mav = new ModelAndView("/board/deleteConfirm");
		mav.addObject("idx", idx);
		return mav;
	}
	@GetMapping("/delete/{idx}")
	public String delete(@PathVariable int idx) {
		int row = boardService.delete(idx);
		System.out.println(row != 0 ? "삭제 성공" : "삭제 실패");
		return "redirect:/board";
	}
	
	@GetMapping("/modify/{idx}")
	public ModelAndView modify(@PathVariable int idx) {
		ModelAndView mav = new ModelAndView("board/modify");
		BoardDTO dto = boardService.selectOne(idx);
		mav.addObject("dto", dto);
		return mav;
	}
	@PostMapping("/modify/{idx}")
	public String modify(BoardDTO dto) throws IllegalStateException, IOException {
		int row = boardService.modify(dto);
		System.out.println(row != 0 ? "수정 성공" : "수정 실패");
		return "redirect:/board/view/" + dto.getIdx();
	}
	
	@PostMapping("/view/{boardIdx}")
	public String replyWrite(ReplyDTO dto) {
		System.out.println("입력한 댓글 : " + dto);
		
		int row = boardService.insertReply(dto);
		System.out.println(row != 0 ? "댓글 작성 성공" : "댓글 작성 실패");
		return "redirect:/board/view/" + dto.getBoardIdx();
	}
	
	@GetMapping("/deleteReply/{boardIdx}/{idx}")
	public String deleteReply(@PathVariable int boardIdx, @PathVariable int idx) {
		int row = boardService.deleteReply(idx);
		System.out.println(row != 0 ? "댓글 삭제 성공" : "댓글 삭제 실패");
		return "redirect:/board/view/" + boardIdx;
	}
}








