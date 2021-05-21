package org.kcm.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kcm.domain.BoardVO;
import org.kcm.domain.Criteria;
import org.kcm.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardTest {
	@Setter(onMethod = @__({@Autowired}))
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board->log.info(board));
	}
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newable");
		mapper.insertSelectKey(board);
		log.info(board);
	}
	@Test
	public void testRead() {
		BoardVO board = mapper.read(5L);
		log.info(board);
	}
	@Test
	public void testDelete() {
		int result = mapper.delete(1L);
		log.info(result);
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(7L);
		board.setTitle("수정한 제목");
		board.setContent("수정한 내용");
		board.setWriter("updateMember");
		int count = mapper.update(board);
		log.info("Update Count : "+count);
	}
	
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(5);
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board->log.info(board));
	}
	
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("bb");
		cri.setType("CTW");
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board->log.info(board));
	}
	
	@Test
	public void getTotalTest() {
		Criteria cri = new Criteria();
		cri.setKeyword("aa");
		cri.setType("CTW");
		int result = mapper.getTotal(cri);
		log.info(result);
	}
}
