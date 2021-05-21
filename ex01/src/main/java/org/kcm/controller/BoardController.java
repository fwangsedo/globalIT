package org.kcm.controller;

import org.kcm.domain.BoardVO;
import org.kcm.domain.Criteria;
import org.kcm.domain.PageDTO;
import org.kcm.service.BoardService;
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
	
	@GetMapping("/list")
	public void list(Criteria cri ,Model model) {
		log.info("list"+cri+service.getTotal(cri));
		model.addAttribute("list",service.getList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,service.getTotal(cri)));
		model.addAttribute("count" ,service.getTotal(cri));
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register : "+ board);
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno());
		//딱 한번만 전달하는 메소드 / 같은 글로 계속 도배되는 현상을 방지하기 위해서 사용함
		return "redirect:/board/list";
	}
	
	/*
	 * @GetMapping("/get") //동일한 동작을 하는 경우에는 배열로 해줘도 됨 public void
	 * get(@RequestParam("bno") Long bno, Model model) { log.info("/get");
	 * model.addAttribute("board", service.get(bno)); }
	 */
	
	@PostMapping("/modify")
	public String get(BoardVO board, @ModelAttribute("cri")Criteria cri ,RedirectAttributes rttr) {
		log.info("modify : "+board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno")Long bno,@ModelAttribute("cri") Criteria cri ,RedirectAttributes rttr) {
		log.info("remove-----"+bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list"+cri.getListLink();
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("register------------");
	}
	
	@GetMapping({"/get","/modify"})
	public void modify(@RequestParam("bno")Long bno,@ModelAttribute("cri") Criteria cri ,Model model) {
		log.info("modify----------- or Get");
		model.addAttribute("board", service.get(bno));
	}
}
