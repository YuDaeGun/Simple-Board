package com.itbank.board;

import java.sql.Date;

public class ReplyDTO {
	private int idx, boardIdx;
	private String writer, content;
	private Date writeDate;
	
	@Override
	public String toString() {
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
