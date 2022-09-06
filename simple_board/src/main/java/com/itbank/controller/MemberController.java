package com.itbank.controller;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itbank.member.MemberDTO;
import com.itbank.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired private MemberService memberService;

	@GetMapping("/login")
	public void login() {}
	@PostMapping("/login")
	public String login(MemberDTO dto, String url, HttpSession session) throws NoSuchAlgorithmException {
		MemberDTO login = memberService.login(dto);
		session.setAttribute("login", login);
		return "redirect:" + (url == null ? "/" : url);
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:" + request.getHeader("referer");
	}
	
	@GetMapping("/join")
	public void join() {}
	@PostMapping("/join")
	public String join(MemberDTO dto) throws NoSuchAlgorithmException {
		int row = memberService.join(dto);
		System.out.println(row != 0 ? "가입 성공" : "가입 실패");
		return "redirect:/member/login";
	}
	
	// AJAX로 ID중복체크
	@GetMapping("/dupCheck/{userid}")
	@ResponseBody
	public boolean dupCheck(@PathVariable String userid) {
		int result = memberService.dupCheck(userid);
		return result == 0;
		// result == 0 -> 사용중인 ID가 아니다. 사용 가능하다
		// result != 0 -> 이미 사용중인 ID이다
	}	
}
