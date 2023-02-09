package com.raregames.domain;

import lombok.Getter;
import lombok.ToString;

/*
 * 페이지정보 DTO클래스
 */

@Getter
@ToString
public class PageDTO {
	
	//시작페이지
	private int startPage;
	//끝페이지
	private int endPage;
	//이전, 다음
	private boolean prev, next;		
	//리스트 총 갯수
	private int totalList;
	//검색정보
	private Criteria criteria;
		
	//생성자
	public PageDTO(Criteria criteria, int totalList) {
		
		this.criteria = criteria;
		this.totalList = totalList;
		
		//보여지는 페이지 개수
		int pageLength = 5;
		int endPageInfo = pageLength - 1;
		
		this.endPage = (int) (Math.ceil(criteria.getPageNo() / (double) pageLength)) * pageLength;
		this.startPage = this.endPage - endPageInfo;
		
		//끝페이지가 보여지는 페이지 갯수보다 적을시
		int realEnd = (int) Math.ceil(totalList / (double) criteria.getPageSize());
		
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		//시작페이지가 1보다 큰 경우에 prev 표시
		this.prev = this.startPage > 1;
		//전체 페이지가 끝 페이지보다 적을때 next 표시
		this.next = this.endPage < realEnd;
		
		
		
	}
	
	
	
}




