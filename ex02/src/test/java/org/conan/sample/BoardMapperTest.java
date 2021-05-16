package org.conan.sample;

import java.util.List;

import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;
import org.conan.mapper.BoardMapper;
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
public class BoardMapperTest {
	//mapper를 setting하기위한 Setter
	@Setter(onMethod = @__({@Autowired}))
	private BoardMapper mapper;
	//test용 함수 호출
	@Test
	public void testGetList() {
		mapper.getList().forEach(board->log.info("testGetList : "+board));
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("해바라기");
		board.setContent("어떤새끼가 재수없게 울고 지랄이야?");
		board.setWriter("나다");
		//mapper.insert(board);
		mapper.insertSelectKey(board);
		log.info("testInsert : "+board);
		
	}
	
	@Test
	public void testRead() {
		BoardVO board = mapper.read(4L);
		log.info("testRead : " + board);
	}
	
	@Test
	public void testDelete() {
		mapper.delete(4L);
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(3L);
		board.setTitle("해바라기2");
		board.setContent("꼭 그렇게 다 가져가야만...속이후련했냐! 씨발새끼들아");
		board.setWriter("저새끼가 돌았나, 오태식이 돌아왔구나");
		int count = mapper.update(board);
		log.info("testUpdate count : "+count);
	}
	@Test 
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setAmount(5);
		cri.setPageNum(2);
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board->log.info(board));
	}
}
