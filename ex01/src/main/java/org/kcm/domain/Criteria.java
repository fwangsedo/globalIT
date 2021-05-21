package org.kcm.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;//페이지 번호
	private int amount;// 한페이지에 출력되는 데이터 수
	private String type;//검색항목
	private String keyword;//사용자가 입력하는 검색어
	
	public String[] getTypeArr() {
		return type==null? new String[] {} : type.split("");
	}
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.amount = amount; this.pageNum = pageNum;
	}
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.getPageNum())
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		return builder.toUriString();
	}
}
