package com.raregames.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.raregames.domain.Criteria;
import com.raregames.domain.ReviewManageVO;

public interface ReviewManageMapper {
	
	public int insertReview(ReviewManageVO reviewManageVO);
	
	public List<ReviewManageVO> selectReviewListWithPaging
			(		@Param("criteria") Criteria criteria,
					@Param("prodNo") Integer prodNo);
	
	public int getTotalCo(Integer prodNo);
	
	public int updateReview(ReviewManageVO reviewManageVO);
	
	public int deleteReview(Integer reviewNo);
	
	public int deleteProdAll(Integer prodNo);
	
	public int deleteMberAll(String mberId);
	
}
