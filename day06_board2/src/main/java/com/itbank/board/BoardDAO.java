package com.itbank.board;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface BoardDAO {

	@Select("select * from board2 where deleted != 'y' order by idx desc")
	List<BoardDTO> selectList();

	@Update("update board2 set viewCount = viewCount + 1 where idx = #{idx}")
	int updateViewCount(int idx);

	@Select("select * from board2 where idx = #{idx}")
	BoardDTO selectOne(int idx);

	@Insert("insert into board2 (category, title, writer, content, uploadFile, ipaddr) "
			+ "values (#{category}, #{title}, #{writer}, #{content}, #{uploadFile}, #{ipaddr})")
	int insert(BoardDTO dto);
}
