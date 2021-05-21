package org.kcm.test;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kcm.domain.BoardVO;
import org.kcm.domain.Criteria;
import org.kcm.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {

	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void testGetList() {
		/* service.getList().forEach(board->log.info(board)); */
		service.getList(new Criteria(2,5)).forEach(board->log.info(board));
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("새로운 글");
		board.setContent("새로운 내용");
		board.setWriter("치문짱123");
		service.register(board);
		log.info("생성된 게시글의 번호"+board.getBno());
	}
	
	@Test
	public void testGet() {
		log.info(service.get(6L).getTitle());
	}
	
	@Test
	public void testDelete() {
		log.info("REMOVE result : "+service.remove(6L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = service.get(7L);
		if(board==null) {
			return;//해당 게시글이 있는지 확인 후 수정
		}
		board.setTitle("제목 수정 from service");
		log.info("MODIFT result : "+service.modify(board));
	}
	
}
