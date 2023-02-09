package com.raregames.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
 * 제품관리VO클래스
 */

@Data
public class ProdManageVO {

	/*
	 * PROD_INFO
	 * PROD_NO, PROD_NM, GENRE_CD, FEATURE_CD, PROD_PRICE, DISCNT_RATE, 
	 * GAME_RATING, DEVELOPER, PUBLISHER, PLATFORM, RELEASE_DE, PROD_IMG, PROD_CN,  
	 * PURCHASE_AT, FRST_REGIST_DE, LAST_UPDT_DE
	 */
	
	//상품번호
	private Integer prodNo;
	//상품명
	private String prodNm;
	//장르코드
	private String genreCd;
	//기능코드
	private String featureCd;
	//상품가격
	private int prodPrice;
	//할인율
	private double discntRate;
	//게임등급
	private String gameRating;
	//개발사
	private String developer;
	//퍼블리셔
	private String publisher;
	//플랫폼
	private String platform;
	//출시일
	private Date releaseDe;
	//상품 이미지
	private String prodImg;
	//상품 내용
	private String prodCn;
	//판매여부
	private String purchaseAt;
	//최초등록날짜
	private Date frstRegistDe;
	//최종수정날짜
	private Date lastUpdtDe;
	
	
}
