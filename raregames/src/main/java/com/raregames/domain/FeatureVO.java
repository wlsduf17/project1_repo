package com.raregames.domain;

import lombok.Data;

/*
 * 기능VO클래스 
 */

@Data
public class FeatureVO {
	
	/*
	 * FEATURE
	 * FEATURE_CD, FEATURE_NM
	 */
	
	//장르코드
	private String featureCd;
	//장르명
	private String featureNm;
	
}
