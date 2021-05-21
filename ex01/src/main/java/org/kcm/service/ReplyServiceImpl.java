package org.kcm.service;

import java.util.List;

import org.kcm.domain.BoardVO;
import org.kcm.domain.Criteria;
import org.kcm.domain.ReplyPageDTO;
import org.kcm.domain.ReplyVO;
import org.kcm.mapper.BoardMapper;
import org.kcm.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper bMapper;
	
	@Transactional
	@Override
	public int register(ReplyVO vo) {
		log.info("register---------"+vo);
		bMapper.updateReplyCnt(vo.getBno(), 1);
		return mapper.insert(vo);
	}
	
	@Override
	public ReplyVO get(Long rno) {
		log.info("get--------------"+rno);
		return mapper.read(rno);
	}
	
	@Override
	public int modify(ReplyVO vo) {
		log.info("modify-----------"+vo);
		return mapper.update(vo);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("remove-----------"+rno);
		ReplyVO vo = mapper.read(rno);
		bMapper.updateReplyCnt(vo.getBno(), -1);
		return mapper.delete(rno);
	}
	
	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("get reply list of a board---"+ bno);
		return mapper.getListWithPaging(cri, bno);
	}
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		log.info(bno+"의 댓글 개수 : "+mapper.getCountByBno(bno));
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}
}
