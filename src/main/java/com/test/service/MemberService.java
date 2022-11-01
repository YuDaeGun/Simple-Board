package com.test.service;

import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.component.HashComponent;
import com.test.member.MemberDAO;
import com.test.member.MemberDTO;

@Service
public class MemberService {

	@Autowired private MemberDAO memberDAO;
	@Autowired private HashComponent hashComponent;
	
	public MemberDTO login(MemberDTO dto) throws NoSuchAlgorithmException {
		dto.setUserpw(hashComponent.getHash(dto.getUserpw()));
		
		MemberDTO login = memberDAO.login(dto);
		return login;
	}

	public int join(MemberDTO dto) throws NoSuchAlgorithmException {
		dto.setUserpw(hashComponent.getHash(dto.getUserpw()));
		
		int row = memberDAO.insert(dto);
		return row;
	}

	public int dupCheck(String userid) {
		return memberDAO.selectUserid(userid);
	}
}
