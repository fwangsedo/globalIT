package org.kcm.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.kcm.domain.BoardAttachVO;
import org.kcm.domain.BoardVO;
import org.kcm.domain.Criteria;
import org.kcm.domain.PageDTO;
import org.kcm.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public void getList(Criteria cri ,Model model) {
		//컨트롤러에 요청이 들어오면 메소드명.jsp가 되는 것이 아닌 요청 url.jsp가 된다.
		log.info("list"+cri+service.getTotal(cri));
		model.addAttribute("list",service.getList(cri));
		model.addAttribute("pageMaker",new PageDTO(cri,service.getTotal(cri)));
		model.addAttribute("count" ,service.getTotal(cri));
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		log.info("register : "+ board);
		if(board.getAttachList()!=null) {
			board.getAttachList().forEach(attach->log.info(attach));
		}
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
	
	@PreAuthorize("principal.username==#board.writer")
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
	
	@PreAuthorize("principal.username==#writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno")Long bno,@ModelAttribute("cri") Criteria cri,
			String writer, RedirectAttributes rttr) {
		log.info("remove-----"+bno);
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
			deleteFiles(attachList);
		}
		return "redirect:/board/list"+cri.getListLink();
	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register() {
		log.info("register------------");
	}
	
	@GetMapping({"/get","/modify"})
	public void modify(@RequestParam("bno")Long bno,@ModelAttribute("cri") Criteria cri ,Model model) {
		log.info("modify----------- or Get");
		model.addAttribute("board", service.get(bno));
	}
	
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody//Jackson 라이브러리 사용
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("get Attach List : " + bno);
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList==null||attachList.size()==0) {return;}
		log.info("delete attach files----------"); log.info(attachList);
		attachList.forEach(attach->{
			try {
				Path file = Paths.get("c:/upload/"+attach.getUploadPath()+"/"
						+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("c:/upload/"+attach.getUploadPath()+"/s_"
							+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}
				}catch (Exception e) {log.error(e);}
		});
	}
}
