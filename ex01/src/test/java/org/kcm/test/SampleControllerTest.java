package org.kcm.test;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kcm.domain.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class SampleControllerTest {
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	private MockMvc mockMvc;
	
	@Before public void setup() {this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();}
	
	/*
	 * @Test public void testList() throws Exception{
	 * log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
	 * .andReturn().getModelAndView().getModelMap()); }
	 * 
	 * @Test public void testRegister() throws Exception{ String resultPage =
	 * mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
	 * .param("title", "test from controller") .param("content",
	 * "test from controller") .param("writer", "user0000"))
	 * .andReturn().getModelAndView().getViewName(); log.info(resultPage); }
	 * 
	 * @Test public void testGet() throws Exception{
	 * log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get").param(
	 * "bno", "2")) .andReturn().getModelAndView().getModelMap()); }
	 * 
	 * @Test public void testModify() throws Exception { String resultPage =
	 * mockMvc.perform(MockMvcRequestBuilders.post("/board/modify") .param("bno",
	 * "1") .param("title", "일번일번") .param("content", "일반 일반") .param("writer",
	 * "일반유저")).andReturn().getModelAndView().getViewName();
	 * 
	 * log.info(resultPage); }
	 * 
	 * @Test public void testRemove() throws Exception{ String resultPage =
	 * mockMvc.perform(MockMvcRequestBuilders.post("/board/remove") .param("bno",
	 * "6")).andReturn().getModelAndView().getViewName(); log.info(resultPage); }
	 * 
	 * @Test public void testListPaging() throws Exception{
	 * log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
	 * .param("pageNum", "2").param("amount", "50"))
	 * .andReturn().getModelAndView().getModelMap()); }
	 */
	
	@Test
	public void testConvert() throws Exception {
		Ticket ticket = new Ticket();
		ticket.setTno(123); ticket.setOwner("admin"); ticket.setGrade("SSS");
		String jsonStr = new Gson().toJson(ticket);
		log.info(jsonStr);
		mockMvc.perform(post("/rsample/ticket").contentType(MediaType.APPLICATION_JSON)
				.content(jsonStr)).andExpect(status().is(200));
	}
}