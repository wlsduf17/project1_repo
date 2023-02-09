package com.raregames.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.raregames.domain.Criteria;
import com.raregames.domain.MberManageVO;
import com.raregames.domain.PageDTO;
import com.raregames.domain.PurchseDetailList;
import com.raregames.domain.PurchseDetailVO;
import com.raregames.domain.PurchseManageVO;
import com.raregames.service.PurchseManageService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/user/purchse/*")
@Controller
public class PurchseManageController {
	
	@Setter(onMethod_ = @Autowired)
	private PurchseManageService purchseManageService;
	
	
	/*
	 * 구매 처리
	 */
	@PostMapping("/insert")
	public String insertPurchse(PurchseManageVO purchseManageVO, PurchseDetailList purchseDetailList,
			HttpSession session, RedirectAttributes rttr)throws Exception {
		
		//세션정보에서 데이터 입력
		MberManageVO mberManageVO = (MberManageVO)session.getAttribute("loginMber");
		purchseManageVO.setMberId(mberManageVO.getMberId());
		
		purchseManageService.insertPurchse(purchseManageVO, purchseDetailList);
		
		return "redirect:/";
	}
	
	/*
	 * 구매목록 화면으로 이동
	 */
	@GetMapping("/list")
	public void purchseListView(Criteria criteria ,Model model) {
		
		criteria.setPageSize(5);
		
		
		List<PurchseManageVO> purchseList = purchseManageService.selectPurchseListWithPaging(criteria);
		int totalList = purchseManageService.getTotalCo(criteria);
		
		PageDTO pageDTO = new PageDTO(criteria, totalList);
		
		model.addAttribute("purchseList", purchseList);
		model.addAttribute("paging", pageDTO);
		
	}
	
	/*
	 * 구매상세정보 처리
	 */
	@GetMapping("/detail")
	public void selectPurchseDetail(@RequestParam("purchseNo") Integer purchseNo, Model model) {
			
		List<PurchseDetailVO> purchseDetailList = purchseManageService.selectPurchseDetail(purchseNo);
		model.addAttribute("purchseDetailList", purchseDetailList);
		
	}
	
	/*
	 * 엑셀 다운로드
	 */
	@GetMapping("/excelDownload")
	public void excelDownload(HttpServletResponse response, Criteria criteria)throws Exception {
		
		criteria.setPageSize(5);
		//엑셀 데이터(내용)
		List<PurchseManageVO> purchseList = purchseManageService.selectPurchseListWithPaging(criteria);
		//MS-Office 2003년도 이전
		//Workbook wb = new HSSFWorkbook();
		//2003년 이후
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("판매데이터");
		Row row = null;
		Cell cell = null;
		int rowNo = 0;
		
		//제목행 스타일 적용
		CellStyle headStyle = wb.createCellStyle();
		
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THIN);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		headStyle.setFillBackgroundColor(IndexedColors.YELLOW.getIndex());
		headStyle.setFillPattern(FillPatternType.SPARSE_DOTS);
		
		//바디행 스타일
		CellStyle bodyStyle = wb.createCellStyle();
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		//제목설정
		row = sheet.createRow(rowNo++);
		cell = row.createCell(0);
		cell.setCellStyle(headStyle);
		cell.setCellValue("구매번호");
		cell = row.createCell(1);
		cell.setCellStyle(headStyle);
		cell.setCellValue("회원ID");
		cell = row.createCell(2);
		cell.setCellStyle(headStyle);
		cell.setCellValue("구매가격");
		cell = row.createCell(3);
		cell.setCellStyle(headStyle);
		cell.setCellValue("구매일");
		
		for(PurchseManageVO purchseManageVO : purchseList) {
			row = sheet.createRow(rowNo++);
			cell = row.createCell(0);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(purchseManageVO.getPurchseNo());
			cell = row.createCell(1);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(purchseManageVO.getMberId());
			cell = row.createCell(2);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(purchseManageVO.getPurchsePrice());
			cell = row.createCell(3);
			cell.setCellStyle(bodyStyle);
			cell.setCellValue(purchseManageVO.getPurchseDe());
		}
		//엑셀 출력
		String fileName = "상품데이터.xlsx";
		String outputFileName = new String(fileName.getBytes("KSC5601"), "8859_1");
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" + outputFileName);
		
		wb.write(response.getOutputStream());
		wb.close();
		
	}
	
	
}
