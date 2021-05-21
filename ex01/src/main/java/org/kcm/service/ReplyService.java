package org.kcm.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kcm.domain.Criteria;
import org.kcm.domain.ReplyPageDTO;
import org.kcm.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	public ReplyVO get(Long rno);
	public int modify(ReplyVO vo);
	public int remove(Long rno);
	public List<ReplyVO> getList(@Param("cri")Criteria cri, @Param("bno")Long bno);
	public ReplyPageDTO getListPage(@Param("cri")Criteria cri,@Param("bno")Long bno);
	
}
