package org.kcm.mapper;

import java.util.List;

import org.kcm.domain.BoardAttachVO;
import org.springframework.transaction.annotation.Transactional;

public interface BoardAttachMapper {

	public void insert(BoardAttachVO vo);
	@Transactional
	public void delete(String uuid);
	public List<BoardAttachVO> findByBno(Long bno);
	public void deleteAll(Long bno);
	public List<BoardAttachVO> getOldFiles();
	
}
