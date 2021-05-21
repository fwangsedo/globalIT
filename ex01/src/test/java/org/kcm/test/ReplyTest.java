package org.kcm.test;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kcm.domain.Criteria;
import org.kcm.domain.ReplyVO;
import org.kcm.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyTest {
	
	private Long[] bnoArr = {501L, 502L, 504L, 515L, 508L};
	
	@Setter(onMethod = @__({@Autowired}))
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	@Test
	public void getListTest() {
		log.info(mapper.getList());
	}
	
	@Test
	public void testCreate() {
		/*
		 * IntStream.range(1, 10).forEach(i->{ ReplyVO vo = new ReplyVO();
		 * vo.setBno(bnoArr[i%5]); vo.setReply("댓글 테스트"+i); vo.setReplyer("replyer"+i);
		 * mapper.insert(vo); });
		 */
		for(int i=1; i<10; i++) {
			ReplyVO vo = new ReplyVO();
			vo.setBno(bnoArr[i%5]);
			vo.setReply("댓글 테스트"+i);
			vo.setReplyer("replyer"+i);
			mapper.insert(vo);
		}
	}
	
	@Test
	public void testRead() {
		Long targetRno = 5L;
		ReplyVO vo = mapper.read(targetRno);
		log.info(vo);
	}
	
	@Test
	public void testDelete() {
		for(long i=10L; i<=23; i++) {
			Long rno = i;
			mapper.delete(rno);
		}

	}
	
	@Test
	public void testUpdate() {
		Long rno = 9L;
		ReplyVO vo = mapper.read(rno);
		vo.setReply("댓글 업데이트");
		vo.setReplyer("replyer9");
		int count = mapper.update(vo);
		log.info("Update Count : "+count);
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply->log.info(reply));
		
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(1, 10);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 504L);
		replies.forEach(reply->log.info(reply));
	}
	
}
