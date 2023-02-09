package com.raregames.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

/*
 * 구매정보관리 VO클래스
 */

@Data
public class PurchseManageVO {
	
	/*
	 * PURCHSE_INFO
	 * PURCHSE_NO, MBER_ID, PURCHSE_PRICE, PURCHSE_DE
	 */
	
	//구매번호
	private Integer purchseNo;
	//회원ID
	private String mberId;
	//구매가격
	private int purchsePrice;
	//구매일
	private Date purchseDe;
	
}
