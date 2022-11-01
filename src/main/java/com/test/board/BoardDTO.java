package com.test.board;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

//	idx			number			default board2_seq.nextval primary key,
//	category	varchar2(100)	check(category in ('공지', '일반', '게임', '등산', '여행')),
//	title		varchar2(200)	not null,
//	writer		varchar2(100)	,
//	content		varchar2(2000)	not null,
//	writeDate	date			default sysdate,
//	viewCount	number			default 0,
//	uploadFile	varchar2(255)	,
//	ipaddr		varchar2(20)	not null,
//	deleted		char(1)			default 'n' check(deleted in ('y','n')),

public class BoardDTO {

	private MultipartFile upload; 	// 파일 형식의 파라미터를 받기 위함

	private int idx;
	private String category;
	private String title;
	private String writer;
	private String content;
	private Date writeDate;
	private int viewCount;
	private String uploadFile;		// 문자열 형식인 파일이름을 DB에 저장하기 위함
	private String ipaddr;
	private String deleted;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public String getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(String uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getIpaddr() {
		return ipaddr;
	}
	public void setIpaddr(String ipaddr) {
		this.ipaddr = ipaddr;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
}
