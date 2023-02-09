package com.raregames.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.multipart.MultipartFile;

import com.raregames.domain.Criteria;
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
@RequestMapping("/user/prod/*")
@Controller
public class UserProdManageController {
	
	@Resource(name = "uploadFolder")
	private String uploadFolder;//업로드폴더
	
	@Setter(onMethod_ = @Autowired)
	private ProdManageService prodManageService;
	
	/*
	 * 상품등록 화면으로 이동
	 */
	@GetMapping("/insert")
	public void insertProdView(Model model) throws Exception{
		
		//장르목록 전달
		model.addAttribute("genreList", prodManageService.selectGenreList());
		//기능목록 전달
		model.addAttribute("featureList", prodManageService.selectFeatureList());
		
	}
	
	/*
	 * 상품등록 처리후 상품목록 화면으로 이동
	 */
	@PostMapping("/insert")
	public String insertProd(ProdManageVO prodManageVO, MultipartFile upload) throws Exception{
		
		prodManageService.insertProd(prodManageVO, upload);
		
		return "redirect:/user/prod/list";
	}
	
	/*
	 * CKEditor 이미지 업로드 처리
	 * 1)파일 업로드 작업
	 * 2)업로드된 파일정보를 다시 클라이언트에 전송
	 */
	@PostMapping("/editor/imageUpload")
	public void ckeditorImageUpload(HttpServletRequest request, HttpServletResponse response, MultipartFile upload){
		
		response.setCharacterEncoding("utf-8");	
		response.setContentType("text/html;charset=utf-8");

		OutputStream out = null;
		PrintWriter printWriter = null;
		try {
			//1)파일업로드 작업
			String fileName = upload.getOriginalFilename();//업로드파일명
			byte[] bytes = upload.getBytes();//업로드파일의 바이트
			//업로드파일 서버 저장경로
			String uploadPath = request.getSession().getServletContext().getRealPath("/resources/upload/") + fileName;
			//경로확인 로그
			log.info("업로드파일 저장경로 : " + uploadPath);
			//업로드파일 저장
			out = new FileOutputStream(new File(uploadPath));
			out.write(bytes);
			out.flush();
			
			//2)업로드 파일정보를 브라우저에 재전송
			String callback = request.getParameter("CKEditorFuncNum");
			
			log.info(callback);
			
			printWriter = response.getWriter();
			
			//Servlet설정 /resources/upload/ - > /upload/
			String fileUrl = "/upload/" + fileName;
			
			printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction("
								+ callback
								+ ",'"
								+ fileUrl
								+ "',' 이미지를 업로드 하였습니다.'"
								+ ")</script>");
			printWriter.flush();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			try {
				if(out != null) out.close();
				if(printWriter != null) printWriter.close();
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		}
		
	}
	
	
	/*
	 * 상품목록 화면으로 이동
	 * - paging : 페이징 정보 Model전송
	 * - prodList : 제품리스트 Model전송 
	 */
	@GetMapping("/list")
	public void listProdView(Criteria criteria, Model model) throws Exception{
		
		criteria.setPageSize(5);
		
		List<ProdManageVO> prodList = prodManageService.selectProdListWithPaging(criteria);
		int totalList = prodManageService.getTotalCo(criteria);
		
		PageDTO pageDTO = new PageDTO(criteria, totalList);
		
		model.addAttribute("paging", pageDTO);
		model.addAttribute("prodList", prodList);
		
	}
	
	
	/*
	 * 상품목록 썸네일 이미지 출력
	 * - 파라미터 
	 * 		prodImg 		: 이미지파일명
	 * 		frstRegistDe	: 최초등록날짜
	 * - 최초등록날짜로 파일경로를 구성해 이미지를 byte[]로 클라이언트에 전송
	 */
	@ResponseBody
	@GetMapping("/showThumbnail")
	public ResponseEntity<byte[]> showThumbnail
			(		String prodImg, 
					String frstRegistDe){
		
		ResponseEntity<byte[]> entity = null;
		//날짜포맷을 파일경로로 변경
		String filePath = frstRegistDe.replace("-", File.separator);
		String thumbnailFileName = "s_" + prodImg;
		
		entity = UploadFileUtils.getFileByte(uploadFolder, filePath, thumbnailFileName);
		
		return entity;
	}
	
	/*
	 * 상품삭제 처리
	 */
	@PostMapping("/delete")
	public String deleteProd(@RequestParam("prodNo") Integer prodNo) throws Exception{
		
		prodManageService.deleteProd(prodNo);
		
		return "redirect:/user/prod/list";
	}
	
	/*
	 * 상품선택삭제 Ajax처리
	 */
	@ResponseBody
	@PostMapping("/checkDelete")
	public ResponseEntity<String> checkDeleteProdAjax
			(		@RequestParam("prodNoArr[]") List<Integer> prodNoArr) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		try {
			for(Integer prodNo : prodNoArr) {
				
				prodManageService.deleteProd(prodNo);
				entity = new ResponseEntity<String>("success", HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	/*
	 * 상품수정 화면으로 이동
	 */
	@GetMapping("/modify")
	public void modifyProdView(@RequestParam("prodNo") Integer prodNo, Model model) throws Exception{
		
		//장르목록 전달
		model.addAttribute("genreList", prodManageService.selectGenreList());
		//기능목록 전달
		model.addAttribute("featureList", prodManageService.selectFeatureList());
		//상품정보 전달
		model.addAttribute("prodManageVO", prodManageService.selectProd(prodNo));
		
	}
	
	/*
	 * 상품수정 처리
	 */
	@PostMapping("/modify")
	public String modifyProd(ProdManageVO prodManageVO, MultipartFile upload) throws Exception{

		prodManageService.modifyProd(prodManageVO, upload);
		
		return "redirect:/user/prod/list";
	}
	
}
