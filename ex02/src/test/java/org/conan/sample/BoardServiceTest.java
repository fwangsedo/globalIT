package org.conan.sample;

import static org.junit.Assert.assertNotNull;

import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;
import org.conan.service.BoardService;
import org.conan.service.BoardServiceImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTest {
	@Setter(onMethod = @__({@Autowired}))
	private BoardService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	@Test
	public void testGetList() {
		//service.getList().forEach(board->log.info(board));
		service.getList(new Criteria(2,5)).forEach(board->log.info(board));
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("해바라기3");
		board.setContent("내가더슬프게해줄게");
		board.setWriter("어디갔나했더니 너가갖고있었구나");
		service.register(board);
		log.info("생성된 게시물"+board.getBno());
	}
	
	@Test
	public void testGet() {
		log.info(service.get(6L).getTitle());
	}
	
	@Test
	public void testDelete() {
		log.info("Remove result : " + service.remove(6L));
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = service.get(6L);
		if(board == null) {return;}
		board.setTitle("제목수정");
		log.info("modify result : "+service.modify(board));
	}
	
	
}
