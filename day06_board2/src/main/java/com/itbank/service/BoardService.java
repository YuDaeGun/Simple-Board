package com.itbank.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.itbank.board.BoardDAO;
import com.itbank.board.BoardDTO;

@Service
public class BoardService {
	
	@Autowired private BoardDAO boardDAO;
	private String uploadPath = "D:\\upload";
	
	public BoardService() {
		File dir = new File(uploadPath);
		if(dir.exists() && dir.isFile()) dir.delete();
		// 대상이 존재하지만 그것이 파일형식 이라면, 삭제 한다
		if(dir.exists() == false) dir.mkdirs();
		// 대상이 존재하지 않는다면, 디렉토리 형식으로 생성한다
	}

	public List<BoardDTO> selectList() {
		return boardDAO.selectList();
	}

	@Transactional
	public BoardDTO viewBoard(int idx) {
		int row = boardDAO.updateViewCount(idx);
		BoardDTO dto = boardDAO.selectOne(idx);
		return dto;
	}

	public int write(BoardDTO dto) throws IllegalStateException, IOException {
		// 1. 파일 이름을 변경해보자 (연-월-일_userid_원본명.확장자)
		if (dto.getUpload().getSize() != 0) {	// 첨부 파일이 있을 경우에만 수행한다
			String fileName = makeNewFileName(dto);
			File dest = new File(uploadPath, fileName);
			dto.getUpload().transferTo(dest);	// 파일명이 변경된 상태로 업로드 완료
			dto.setUploadFile(fileName);
		} else dto.setUploadFile("");	// 첨부 파일이 없을 시, DB에 빈 문자열(null)을 저장
		
		// 2. DB에 insert
		int row = boardDAO.insert(dto);
		return row;
	}
	
	private String makeNewFileName(BoardDTO dto) {
		MultipartFile f = dto.getUpload();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(new Date());
		String fileName = today + "_" + dto.getWriter() + "_" + f.getOriginalFilename();
		return fileName;
	}
}












