package org.conan.domain;


import java.sql.Date;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private Date updateDate;
	//안녛하세요
	//세도형 컴에서 추가
}
