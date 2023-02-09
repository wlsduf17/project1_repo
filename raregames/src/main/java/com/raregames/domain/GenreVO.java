package com.raregames.domain;

import lombok.Data;

/*
 * 장르VO클래스 
 */

@Data
public class GenreVO {
	
	/*
	 * GENRE
	 * GENRE_CD, GENRE_NM
	 */
	
	//장르코드
	private String genreCd;
	//장르명
	private String genreNm;
	
}
