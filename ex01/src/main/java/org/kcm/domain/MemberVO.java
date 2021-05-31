package org.kcm.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userId;
	private String userPwd;
	private String userName;
	private boolean enabled;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;
}
