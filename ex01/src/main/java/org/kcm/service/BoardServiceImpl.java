package org.kcm.service;

import java.util.List;

import org.kcm.domain.BoardAttachVO;
import org.kcm.domain.BoardVO;
import org.kcm.domain.Criteria;
import org.kcm.mapper.BoardAttachMapper;
import org.kcm.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	/* @Setter(onMethod_ = {@Autowired}) */
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper bMapper;
	
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
		bMapper.deleteAll(board.getBno()); //부분 업데이트를 하는 방식이 아닌 다 지우고 나서
		boolean modifyResult = mapper.update(board)==1;
		if(modifyResult&&board.getAttachList()!=null&&board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach->{//다시 선택된 첨부파일을 반복문을 통해 넣는 방식
				attach.setBno(board.getBno());
				bMapper.insert(attach);
			});
		}
		return mapper.update(board)==1;
	}
	@Override
	public void register(BoardVO board) {
		log.info("---------register--------");
		mapper.insertSelectKey(board);
		if(board.getAttachList()==null||board.getAttachList().size()<=0) {
			return;
		}
		board.getAttachList().forEach(attach->{
			attach.setBno(board.getBno());
			bMapper.insert(attach);
		});
	}
	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("---------remove--------");
		bMapper.deleteAll(bno);
		return mapper.delete(bno)==1;
	}
	@Override
	public int getTotal(Criteria cri) {
		log.info("---------total--------");
		return mapper.getTotal(cri);
	} 
	
	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by Bno : "+bno);
		return bMapper.findByBno(bno);
	}
	
}
