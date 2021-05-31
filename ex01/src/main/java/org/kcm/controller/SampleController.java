package org.kcm.controller;

import org.kcm.domain.Test;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/sample/*")
public class SampleController {

	@GetMapping("/all")
	public void doAll() {log.info("누구나 접근 가능");}
	
	@GetMapping("/member")
	public void doMember() {log.info("로그인한 회원들만 접근 가능");}
	
	@GetMapping("/admin")
	public void doAdmin() {log.info("관리자만 접근 가능");}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
	@GetMapping("/annoMember")
	public void doMember2() {
		log.info("어노테이션 멤버로 로그인");
	}
	
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/annoAdmin")
	public void doAdmin2() {
		log.info("어노테이션 어드민만 로그인");
	}
	
	@GetMapping("/test")
	public void test(@ModelAttribute("Test")Test t, Model model) {
		model.addAttribute("t", t);
	}
	
}
