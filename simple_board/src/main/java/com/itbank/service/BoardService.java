package com.itbank.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.itbank.board.BoardDAO;
import com.itbank.board.BoardDTO;
import com.itbank.board.ReplyDAO;
import com.itbank.board.ReplyDTO;

@Service
public class BoardService {
	
	@Autowired private BoardDAO boardDAO;
	@Autowired private ReplyDAO replyDAO;
	
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
		if (dto.getUpload().getSize() != 0) {
			String fileName = makeNewFileName(dto);
			File dest = new File(uploadPath, fileName);
			dto.getUpload().transferTo(dest);
			dto.setUploadFile(fileName);
		} else dto.setUploadFile("");
		
		int row = boardDAO.insert(dto);
		return row;
	}

	public int delete(int idx) {
		return boardDAO.updateDeleted(idx);
	}

	public int modify(BoardDTO dto) throws IllegalStateException, IOException {
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
	

	public List<ReplyDTO> selectReplyList(int idx) {
		return replyDAO.selectList(idx);
	}

	public int insertReply(ReplyDTO dto) {
		return replyDAO.insert(dto);
	}

	public int deleteReply(int idx) {
		return replyDAO.delete(idx);
	}
}












