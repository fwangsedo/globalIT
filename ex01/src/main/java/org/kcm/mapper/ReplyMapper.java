package org.kcm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kcm.domain.Criteria;
import org.kcm.domain.ReplyVO;

public interface ReplyMapper {

	public List<ReplyVO> getList();
	public int insert(ReplyVO vo);
	public ReplyVO read(Long rno);
	public int delete(Long rno);
	public int update(ReplyVO vo);
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno")Long bno);
	public int getCountByBno(Long bno);
}
