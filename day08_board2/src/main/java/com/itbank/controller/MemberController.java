package com.itbank.controller;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itbank.member.MemberDTO;
import com.itbank.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired private MemberService memberService;

	@GetMapping("/login")
	public void login() {}
	@PostMapping("/login")
	public String login(MemberDTO dto, HttpSession session) throws NoSuchAlgorithmException {
		MemberDTO login = memberService.login(dto);
		session.setAttribute("login", login);
		return "redirect:/";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/join")
	public void join() {}
	@PostMapping("/join")
	public String join(MemberDTO dto) throws NoSuchAlgorithmException {
		int row = memberService.join(dto);
		System.out.println(row != 0 ? "가입 성공" : "가입 실패");
		return "redirect:/member/login";
	}
}
