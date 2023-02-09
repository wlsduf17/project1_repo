package com.raregames.controller;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.raregames.domain.Criteria;
import com.raregames.domain.FeatureVO;
import com.raregames.domain.GenreVO;
import com.raregames.domain.PageDTO;
import com.raregames.domain.ProdManageVO;
import com.raregames.service.ProdManageService;
import com.raregames.utils.UploadFileUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
/*
 * 상품관리에 대한 controller 클래스 정의
 * 주요기능 : 상품 입력, 리스트, 수정, 삭제
 * 부가기능 : CkEditor 이미지 업로드
 */
@Log4j
@RequestMapping("/prod/*")
@Controller
public class MberProdManageController {
	
	@Resource(name = "uploadFolder")
	private String uploadFolder;//업로드폴더
	
	@Setter(onMethod_ = @Autowired)
	private ProdManageService prodManageService;
	
	/*
	 * 상품상세 화면으로 이동
	 */
	@GetMapping("/detail")
	public void prodDetailView(@RequestParam("prodNo") Integer prodNo, Model model)throws Exception {
		//상품정보 전달
		ProdManageVO prodManageVO = prodManageService.selectProd(prodNo);
		model.addAttribute("prodManageVO", prodManageVO);
		//장르명 전달
		List<GenreVO> genreList = prodManageService.selectGenreNm(prodManageVO.getGenreCd());
		model.addAttribute("genreList", genreList);
		//기능명 전달
		List<FeatureVO> featureList = prodManageService.selectFeatureNm(prodManageVO.getFeatureCd());
		model.addAttribute("featureList", featureList);
		//사이드바 추천상품
		model.addAttribute("prodList", prodManageService.selectProdList());
		
	}
	
	/*
	 * 상품 이미지 출력
	 * - 파라미터 
	 * 		prodImg 		: 이미지파일명
	 * 		frstRegistDe	: 최초등록날짜
	 * - 최초등록날짜로 파일경로를 구성해 이미지를 byte[]로 클라이언트에 전송
	 */
	@ResponseBody
	@GetMapping("/showProdImg")
	public ResponseEntity<byte[]> showThumbnail
			(		String prodImg, 
					String frstRegistDe){
		
		ResponseEntity<byte[]> entity = null;
		//날짜포맷을 파일경로로 변경
		String filePath = frstRegistDe.replace("-", File.separator);
		
		entity = UploadFileUtils.getFileByte(uploadFolder, filePath, prodImg);
		
		return entity;
	}
	
	/*
	 * 상품카테고리 화면으로 이동
	 */
	@GetMapping("/categories")
	public void prodCategoryView
			(		@ModelAttribute(value="genreCd") String genreCd, 
					@ModelAttribute(value="featureCd") String featureCd,
					Criteria criteria,
					Model model)throws Exception {
		
		criteria.setPageSize(9);
		List<ProdManageVO> prodList = prodManageService.selectCategoryListWithPaging(criteria, genreCd, featureCd);
		int totalList = prodManageService.getCategoryTotalCo(criteria, genreCd, featureCd);
		
		PageDTO pageDTO = new PageDTO(criteria, totalList);
		
		model.addAttribute("paging", pageDTO);
		model.addAttribute("prodList", prodList);
		
		//장르명 전달
		if(!StringUtils.isEmpty(genreCd)) {
			List<GenreVO> genreList = prodManageService.selectGenreNm(genreCd);
			model.addAttribute("genreList", genreList);
		}
		//기능명 전달
		if(!StringUtils.isEmpty(featureCd)) {
			List<FeatureVO> featureList = prodManageService.selectFeatureNm(featureCd);
			model.addAttribute("featureList", featureList);
		}
		
		
		
	}
	
	
}
