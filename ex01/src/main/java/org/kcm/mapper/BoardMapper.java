package org.kcm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kcm.domain.BoardVO;
import org.kcm.domain.Criteria;

public interface BoardMapper {
	//해당 인터페이스에서는 구체적인 SQL문이 적혀있는 BoardMapper.xml과 관련이 있음
	public List<BoardVO> getList();
	public void insert(BoardVO board);
	public void insertSelectKey(BoardVO board);
	public BoardVO read(long bno);
	public int delete(long bno);
	public int update(BoardVO board);
	public List<BoardVO> getListWithPaging(Criteria cri);
	public int getTotal(Criteria cri);
	public void updateReplyCnt(@Param("bno")Long bno, @Param("amount")int amount);
}