package org.kcm.service;

import java.util.List;

import org.kcm.domain.BoardAttachVO;
import org.kcm.domain.BoardVO;
import org.kcm.domain.Criteria;

public interface BoardService {
	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);
	public List<BoardVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	public List<BoardAttachVO> getAttachList(Long bno);
	//고유값 bno를 가지는 첨부파일의 리스트를 불러옴
}
