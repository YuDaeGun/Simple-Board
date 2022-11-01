package com.test.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.test.board.BoardDAO;
import com.test.board.BoardDTO;
import com.test.board.ReplyDAO;
import com.test.board.ReplyDTO;

@Service
public class BoardService {
	
	@Autowired private BoardDAO boardDAO;
	
	private String uploadPath = "D:\\upload";
	
	public BoardService() {
		File dir = new File(uploadPath);
		if(dir.exists() && dir.isFile()) dir.delete();
		if(dir.exists() == false) dir.mkdirs();
	}

	public List<BoardDTO> selectList(HashMap<String, Object> param) {
		return boardDAO.selectList(param);
	}

	public void updateViewCount(int idx) {
		boardDAO.updateViewCount(idx);
	}
	
	public BoardDTO selectOne(int idx) {
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

	public int delete(int idx) {
		return boardDAO.updateDeleted(idx);
	}

	public int modify(BoardDTO dto) throws IllegalStateException, IOException {
		// if/else 부분은 write때와 똑같다
		if (dto.getUpload().getSize() != 0) {
			String fileName = makeNewFileName(dto);
			File dest = new File(uploadPath, fileName);
			dto.getUpload().transferTo(dest);
			dto.setUploadFile(fileName);
		} else dto.setUploadFile("");
		
		int row = boardDAO.update(dto);
		return row;
	}
	
	private String makeNewFileName(BoardDTO dto) {
		MultipartFile f = dto.getUpload();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(new Date());
		String fileName = today + "_" + dto.getWriter() + "_" + f.getOriginalFilename();
		return fileName;
	}

	public int selectBoardCount(HashMap<String, Object> param) {
		int boardCount = boardDAO.selectBoardCount(param);
		return boardCount;
	}
	
	
	// 여기부터 댓글 관련 내용
	@Autowired private ReplyDAO replyDAO;

	public List<ReplyDTO> selectReplyList(int idx) {
		return replyDAO.selectList(idx);	// reply의 idx가 아니고, board의 idx
	}

	public int insertReply(ReplyDTO dto) {
		return replyDAO.insert(dto);
	}

	public int deleteReply(int idx) {
		return replyDAO.delete(idx);
	}
}












