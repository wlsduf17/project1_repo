package com.raregames.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raregames.domain.Criteria;
import com.raregames.domain.MberManageVO;
import com.raregames.domain.PageDTO;
import com.raregames.domain.ReviewManageVO;
import com.raregames.service.ReviewManageService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/review/*")
@Controller
public class ReviewManageController {
	
	@Setter(onMethod_ = @Autowired)
	private ReviewManageService reviewManageService;
	
	/*
	 * 상품리뷰 화면 불러오기
	 */
	@GetMapping("/prod")
	public void prodReviewView(@RequestParam("prodNo") Integer prodNo, Criteria criteria, Model model)throws Exception {
		//페이지당 게시물 = 4
		criteria.setPageSize(4);
		
		List<ReviewManageVO> reviewList = reviewManageService.selectReviewListWithPaging(criteria, prodNo);
		int totalList = reviewManageService.getTotalCo(prodNo);
		
		PageDTO pageDTO = new PageDTO(criteria, totalList);
		
		model.addAttribute("paging", pageDTO);
		model.addAttribute("reviewList", reviewList);
		
	}
	
	/*
	 * 리뷰 등록 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/insert")
	public ResponseEntity<String> insertReviewAjax
			(		ReviewManageVO reviewManageVO,
					HttpSession session)throws Exception {
		
		ResponseEntity<String> entity = null;
		
		MberManageVO mberManageVO = (MberManageVO)session.getAttribute("loginMber");
		reviewManageVO.setMberId(mberManageVO.getMberId());
		reviewManageVO.setMberNicknm(mberManageVO.getMberNicknm());
		
		
		try {
			reviewManageService.insertReview(reviewManageVO);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/*
	 * 리뷰 수정 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/modify")
	public ResponseEntity<String> modifyReviewAjax
			(		ReviewManageVO reviewManageVO,
					HttpSession session)throws Exception {
		
		ResponseEntity<String> entity = null;
		
		try {
			reviewManageService.modifyReview(reviewManageVO);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/*
	 * 리뷰 삭제 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/delete")
	public ResponseEntity<String> deleteReviewAjax
			(		@RequestParam("reviewNo") Integer reviewNo,
					HttpSession session)throws Exception {
		
		ResponseEntity<String> entity = null;
		
		try {
			reviewManageService.deleteReview(reviewNo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
