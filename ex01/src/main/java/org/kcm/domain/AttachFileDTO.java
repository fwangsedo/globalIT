package org.kcm.domain;

import lombok.Data;

@Data
public class AttachFileDTO {

	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;//파일이 이미지인지 아닌지를 파악
	
}
