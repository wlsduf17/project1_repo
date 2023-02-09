package com.raregames.domain;

import java.util.Date;

import lombok.Data;

/*
 * 리뷰관리VO클래스 
 */

@Data
public class ReviewManageVO {
	
	/*
	 * REVIEW_INFO
	 * REVIEW_NO, PROD_NO, MBER_ID, MBER_NICKNM, REVIEW_CN, REVIEW_SCORE, FRST_REGIST_DE, LAST_UPDT_DE
	 */
	
	//리뷰번호
	private Integer reviewNo;
	//상품번호
	private Integer prodNo;
	//회원ID
	private String mberId;
	//닉네임
	private String mberNicknm;
	//리뷰내용
	private String reviewCn;
	//리뷰점수
	private int reviewScore;
	//최초등록날짜
	private Date frstRegistDe;
	//최종수정날짜
	private Date lastUpdtDe;
	
}
