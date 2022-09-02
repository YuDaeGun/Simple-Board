package com.itbank.board;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

@Repository
public interface BoardDAO {

//	@Select("select * from board2 where deleted != 'y' order by idx desc")
	List<BoardDTO> selectList(HashMap<String, String> param);

	@Update("update board2 set viewCount = viewCount + 1 where idx = #{idx}")
	int updateViewCount(int idx);

	@Select("select * from board2 where idx = #{idx}")
	BoardDTO selectOne(int idx);

	@Insert("insert into board2 (category, title, writer, content, uploadFile, ipaddr) "
			+ "values (#{category}, #{title}, #{writer}, #{content}, #{uploadFile}, #{ipaddr})")
	int insert(BoardDTO dto);

	@Update("update board2 set deleted='y' where idx=#{idx}")
	int updateDeleted(int idx);

//	@Update("update board2 "
//			+ "	set category=#{category}, title=#{title}, content=#{content}, uploadFile=#{uploadFile} "
//			+ "	where idx=#{idx}")
	int update(BoardDTO dto);	// 동적 쿼리가 필요 없지만 굳이 한번 만들어 봤다
}
