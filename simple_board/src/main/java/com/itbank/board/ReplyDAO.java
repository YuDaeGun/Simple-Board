package com.itbank.board;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface ReplyDAO {

	@Select("select * from reply where boardIdx = #{boardIdx} order by idx desc")
	List<ReplyDTO> selectList(int boardIdx);

	@Insert("insert into reply (boardIdx, writer, content) "
			+ "values (#{boardIdx}, #{writer}, #{content})")
	int insert(ReplyDTO dto);

	@Delete("delete reply where idx = #{idx}")
	int delete(int idx);

}
