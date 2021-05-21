package org.kcm.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kcm.service.SampleService;
import org.kcm.service.SampleTxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class SampleTxServiceTest {
	@Setter(onMethod_ = {@Autowired})
	private SampleTxService service;
	
	@Test
	public void testLong() {
		String str = "Starry\r\n"+
					"Starry night\r\n"+
					"Piamat your pallette blue and gray\r\n"+
					"Look out one summer dat!";
		log.info(str.getBytes().length);
		service.addData(str);
	}
}
