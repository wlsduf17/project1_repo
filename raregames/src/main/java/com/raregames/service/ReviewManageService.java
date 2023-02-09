package com.raregames.service;

import java.util.List;

import com.raregames.domain.Criteria;
import com.raregames.domain.ReviewManageVO;

public interface ReviewManageService {
	
	public int insertReview(ReviewManageVO reviewManageVO);
	
	public List<ReviewManageVO> selectReviewListWithPaging(Criteria criteria, Integer prodNo);
	
	public int getTotalCo(Integer prodNo);
	
	public int modifyReview(ReviewManageVO reviewManageVO);
	
	public int deleteReview(Integer reviewNo);
}
