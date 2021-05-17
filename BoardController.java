package org.happy.controller;

import org.happy.domain.BoardVO;
import org.happy.domain.Criteria;
import org.happy.domain.PageDTO;
import org.happy.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	
	
	 /* @GetMapping("/list") 
	  public void list(Model model) { 
	  log.info("list" );
	  model.addAttribute("list", service.getList()); 
	  }
	  */
	 
	@PostMapping("/register") // post방식 게시글 저장
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register :" + board);
		service.register(board);
		rttr.addFlashAttribute("result" , board.getBno());
		return "redirect:/board/list";  // redirect를 하지 않는 경우는, 새로고침시 도배가 된다.
	}
	@GetMapping({"/get","/modify"}) // 해당 글 가져오는 방식
	public void get(@RequestParam("bno")Long bno,@ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get or /modify");
		model.addAttribute("board", service.get(bno));
	}
	@PostMapping("/modify") // post방식 게시글 수정
	public String get(BoardVO board, @ModelAttribute("cri")Criteria cri, RedirectAttributes rttr) {
		log.info("modify" + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
//		rttr.addAttribute("pageNum",cri.getPageNum());
//		rttr.addAttribute("amount",cri.getAmount());
//		rttr.addAttribute("keyword",cri.getKeyword());
//		rttr.addAttribute("type",cri.getType());
		return "redirect:/board/list"+ cri.getListLink();
	}
	@PostMapping("/remove")
	public String remove(@RequestParam("bno")Long bno, @ModelAttribute("cri")Criteria cri, RedirectAttributes rttr) {
		log.info("remove........:)"+bno);
		if(service.remove(bno)){
			rttr.addFlashAttribute("result","success"); // 한번만 저장되도록 하는 태그
		}
//		rttr.addAttribute("pageNum",cri.getPageNum());
//		rttr.addAttribute("amount",cri.getAmount());
//		rttr.addAttribute("keyword",cri.getKeyword());
//		rttr.addAttribute("type",cri.getType());
		return "redirect:/board/list"+ cri.getListLink();
	}
	@GetMapping("/register")
	public void register() {
		
	}
	/*
	 * @GetMapping("/modify") public void modify(@RequestParam("bno")Long bno, Model
	 * model) { log.info("modify-----------"); model.addAttribute("board",
	 * service.get(bno)); }
	 */
		
	@GetMapping("/list") 
		public void list(Criteria cri, Model model) {
		log.info("list : "+cri);
		 model.addAttribute("list",service.getList(cri));
		// model.addAttribute("pageMaker",new PageDTO(cri, 123));
		
		 int total = service.getTotal(cri);
		 log.info("getTotal : "+ total);
		 	model.addAttribute("pageMaker", new PageDTO(cri, total));
		 
	}
	
		 
}
