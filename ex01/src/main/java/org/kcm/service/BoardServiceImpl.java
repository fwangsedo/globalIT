package org.kcm.service;

import java.util.List;

import org.kcm.domain.BoardVO;
import org.kcm.domain.Criteria;
import org.kcm.mapper.BoardMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	/* @Setter(onMethod_ = {@Autowired}) */
	private BoardMapper mapper;
	
	@Override
	public List<BoardVO> getList(Criteria cri){
		log.info("---------getList--------");
		return mapper.getListWithPaging(cri);
	}
	@Override
	public BoardVO get(Long bno) {
		log.info("---------get--------");
		return mapper.read(bno);
	}
	@Override
	public boolean modify(BoardVO board) {
		log.info("---------modify--------");
		return mapper.update(board)==1;
	}
	@Override
	public void register(BoardVO board) {
		log.info("---------register--------");
		mapper.insertSelectKey(board);
	}
	@Override
	public boolean remove(Long bno) {
		log.info("---------remove--------");
		return mapper.delete(bno)==1;
	}
	@Override
	public int getTotal(Criteria cri) {
		log.info("---------total--------");
		return mapper.getTotal(cri);
	}
	
}
