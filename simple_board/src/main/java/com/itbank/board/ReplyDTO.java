package com.itbank.board;

import java.sql.Date;

//	idx		    number
//	boardIdx	number
//	writer		varchar2(100)
//	content		varchar2(1000)
//	writeDate	date

public class ReplyDTO {
	private int idx;
	private int boardIdx;
	private String writer;
	private String content;
	private Date writeDate;
	
	@Override
	public String toString() {	// 콘솔에서 확인하며 개발하기 위해 오버라이딩 해뒀다
		return String.format("{ %s, %s, %s, %s, %s }", idx, boardIdx, writer, content, writeDate);
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
}
