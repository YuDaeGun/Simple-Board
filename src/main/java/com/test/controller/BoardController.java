package com.test.controller;

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

import com.test.board.BoardDTO;
import com.test.board.Paging;
import com.test.board.ReplyDTO;
import com.test.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired private BoardService boardService;
	
	@GetMapping("")
	public ModelAndView board(@RequestParam HashMap<String, Object> param, 
							  @RequestParam(defaultValue = "1") int page) {
		// page라는 이름의 파라미터가 없다면 -> [int page = 1]선언. 파라미터에 추가하는 것이 아니다
		
		ModelAndView mav = new ModelAndView("/board/list");
		int boardCount = boardService.selectBoardCount(param);	// 출력할 전체 게시물 개수를 받아와서
		Paging paging = new Paging(page, boardCount);			// 페이징 객체를 생성
		param.put("paging", paging);		// 리스트를 불러오기위해 param에 추가
		
		List<BoardDTO> list = boardService.selectList(param);	// 리스트를 불러와서
		mav.addObject("list", list);		// 리스트와,
		mav.addObject("paging", paging);	// paging 객체를 jsp로 보내준다
		return mav;
	}
	
	@GetMapping("/view/{idx}")
	public ModelAndView view(@PathVariable int idx, HttpServletRequest request, 
							 @RequestParam HashMap<String, Object> param, 
							 @RequestParam(defaultValue = "1") int page) {

		ModelAndView mav = board(param, page);
		mav.setViewName("board/view");
		
		String referer = request.getHeader("referer");	// 현재 페이지로 오기 전의  URL
		String requestURL = request.getRequestURL().toString();	// 현재 페이지의 URL (쿼리스트링 생략)
		
		// 새로고침 조회수 작업 막기
		if(requestURL.equals(referer.split("\\?")[0]) == false) {	// 쿼리스트링을 잘라낸 후 비교
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
		
		List<ReplyDTO> replyList = boardService.selectReplyList(idx);	// 댓글 리스트를 불러와서
		mav.addObject("replyList", replyList);							// mav에 추가한다
		
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
	
	// 댓글 작성
	@PostMapping("/view/{boardIdx}")
	public String replyWrite(ReplyDTO dto) {
		// {boardIdx}도 자동으로 ReplyDTO속에 들어가 있다
		System.out.println("입력한 댓글 : " + dto);
		
		int row = boardService.insertReply(dto);
		System.out.println(row != 0 ? "댓글 작성 성공" : "댓글 작성 실패");
		return "redirect:/board/view/" + dto.getBoardIdx();
	}
	
	// 댓글 삭제
	@GetMapping("/deleteReply/{boardIdx}/{idx}")
	public String deleteReply(@PathVariable int boardIdx, @PathVariable int idx) {
		int row = boardService.deleteReply(idx);
		System.out.println(row != 0 ? "댓글 삭제 성공" : "댓글 삭제 실패");
		return "redirect:/board/view/" + boardIdx;
	}
}








