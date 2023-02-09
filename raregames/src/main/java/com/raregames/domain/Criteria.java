package com.raregames.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

/*
 * 검색정보 클래스  
 */
@ToString
@Getter
@Setter
public class Criteria {
	
	//페이지 번호
	private int pageNo;
	//페이지당 게시물 갯수
	private int pageSize;
	//검색 종류
	private String searchType;
	//검색어
	private String searchTerm;
	
	//기본생성자
	public Criteria() {
		this(1, 10);
	}
	
	//생성자
	public Criteria(int pageNo, int pageSize) {
		this.pageNo = pageNo;
		this.pageSize = pageSize;
	}
	
	//searchTypeArr getter(Mybatis foreach구문에서 호출) 
	public String[] getSearchTypeArr() {
		return searchType == null ? new String[] {} : searchType.split(",");
	}
	
	//주소 파라미터 전달 메서드
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNo", this.pageNo)
				.queryParam("pageSize", this.pageSize)
				.queryParam("searchType", this.searchType)
				.queryParam("searchTerm", this.searchTerm);

		return builder.toUriString();
	}
	
}
