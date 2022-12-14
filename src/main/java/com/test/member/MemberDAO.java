package com.test.member;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberDAO {

	@Select("select * from member4 where userid=#{userid} and userpw=#{userpw}")
	MemberDTO login(MemberDTO dto);

	@Insert("insert into member4 (userid, userpw, name, email, birth) values ("
			+ "	#{userid}, #{userpw}, #{name}, #{email}, #{birth}"
			+ ")")
	int insert(MemberDTO dto);

	@Select("select count(*) from member4 where userid = #{userid}")
	int selectUserid(String userid);
	
}
