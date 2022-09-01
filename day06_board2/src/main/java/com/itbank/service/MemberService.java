package com.itbank.service;

import java.security.NoSuchAlgorithmException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.component.HashComponent;
import com.itbank.member.MemberDAO;
import com.itbank.member.MemberDTO;

@Service
public class MemberService {

	@Autowired private MemberDAO memberDAO;
	@Autowired private HashComponent hashComponent;
	
	public MemberDTO login(MemberDTO dto) throws NoSuchAlgorithmException {
		String hash = hashComponent.getHash(dto.getUserpw());
		dto.setUserpw(hash);
		
		MemberDTO login = memberDAO.login(dto);
		return login;
	}

	public int join(MemberDTO dto) throws NoSuchAlgorithmException {
		String hash = hashComponent.getHash(dto.getUserpw());
		dto.setUserpw(hash);
		
		int row = memberDAO.insert(dto);
		return row;
	}
}
