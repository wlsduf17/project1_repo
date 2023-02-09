package com.raregames.domain;

import java.util.Date;

import lombok.Data;

/*
 * 관리자관리VO클래스 
 */

@Data
public class UserManageVO {
	
	/*
	 * USERINFO 테이블
	 * USER_ID, USER_PASSWORD, USER_NM, RCNT_CONECT_DE
	 */
	
	//관리자 ID
	private String userId;
	//관리자 비밀번호
	private String userPassword;
	//관리자 이름
	private String userNm;
	//최근접속날짜
	private Date rcntConectDe;
	
	
}
