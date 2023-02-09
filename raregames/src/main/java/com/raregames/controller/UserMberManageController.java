package com.raregames.controller;

import java.util.List;

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
import com.raregames.service.MberManageService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/user/mber/*")
@Controller
public class UserMberManageController {
	
	@Setter(onMethod_ = @Autowired)
	private MberManageService mberManageService;
	
	/*
	 * 회원목록 화면으로 이동
	 */
	@GetMapping("/list")
	public void selectMberListView(Criteria criteria ,Model model) {
		
		criteria.setPageSize(10);
		
		List<MberManageVO> mberList = mberManageService.selectMberListWithPaging(criteria);
		int totalList = mberManageService.getTotalCo(criteria);
		
		PageDTO pageDTO = new PageDTO(criteria, totalList);
		
		model.addAttribute("mberList", mberList);
		model.addAttribute("paging", pageDTO);
		
	}
	
	/*
	 * 회원 삭제 처리
	 */
	@PostMapping("/delete")
	public String deleteMber(@RequestParam("mberId") String mberId) throws Exception{
		
		mberManageService.deleteMber(mberId);
		
		return "redirect:/user/mber/list";
	}
	
	/*
	 * 체크박스 회원 삭제 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/checkDelete")
	public ResponseEntity<String> checkDeleteMberAjax
			(		@RequestParam("mberIdArr[]") List<String> mberIdArr){
		
		ResponseEntity<String> entity = null;
			
		try {
			for(String mberId : mberIdArr) {
				mberManageService.deleteMber(mberId);
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
}
