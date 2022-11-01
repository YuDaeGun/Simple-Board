package com.test.member;

import java.sql.Date;

//	idx			number 			default member4_seq.nextval primary key,
//	userid		varchar2(100)	unique not null,
//	userpw		varchar2(255)	not null,
//	name		varchar2(100)	not null,
//	email		varchar2(200)	not null,
//	birth		date			not null,
//	deleted		char(1)			default 'n' check(deleted in ('y', 'n'))

public class MemberDTO {
	private int idx;
	private String userid;
	private String userpw;
	private String name;
	private String email;
	private Date birth;
	private String deleted;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getDeleted() {
		return deleted;
	}
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
}
