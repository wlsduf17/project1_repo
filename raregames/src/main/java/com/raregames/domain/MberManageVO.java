package com.raregames.domain;

import java.util.Date;

import lombok.Data;

/*
 * 일반회원VO클래스
 */

@Data
public class MberManageVO {

/*
 * MBERINFO 테이블
 * MBER_ID, MBER_PASSWORD, MBER_NM, MBER_NICKNM, INFO_RECEPT_AT, FRST_REGIST_DE, LAST_UPDT_DE, 
 * RCNT_CONECT_DE, MBTLNUM, ZIP, ADRES, DETAIL_ADRES
 */
	//회원ID
	private String mberId;
	//비밀번호
	private String mberPassword;
	//회원명
	private String mberNm;
	//닉네임
	private String mberNicknm;
	//정보수신여부
	private String infoReceptAt;
	//최초가입날짜
	private Date frstRegistDe;
	//최종수정날짜
	private Date lastUpdtDe;
	//최근접속날짜
	private Date rcntConectDe;
	//이동전화번호
	private String mbtlnum;
	//우편번호
	private String zip;
	//주소
	private String adres;
	//상세주소
	private String detailAdres;
	
	
}
