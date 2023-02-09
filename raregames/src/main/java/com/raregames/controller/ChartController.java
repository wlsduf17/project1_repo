package com.raregames.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.raregames.domain.ChartVO;
import com.raregames.service.ChartService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/user/chart/*")
@Controller
public class ChartController {
	
	@Setter(onMethod_ = @Autowired)
	private ChartService chartService;
	
	/*
	 * 전체 통계 차트 페이지
	 */
	@GetMapping("/overall")
	public ModelAndView overAllChart(@RequestParam(value = "purchseDe", required = false) String purchseDe) throws Exception{
		
		//통계차트 데이터
		ModelAndView mv = new ModelAndView();
		
		//상품별 총매출
		List<ChartVO> totalSalesPerProdList = chartService.totalSalesPerProd();
		String totalSalesPerProdChart = "[['상품명', '매출'],";
		int i = 0;
		for(ChartVO vo : totalSalesPerProdList) {
			totalSalesPerProdChart += "[\"" + vo.getProdNm() + "\"," + vo.getTotalSalesPerProd() + "]"; 
			i++;
			if(i < totalSalesPerProdList.size()) totalSalesPerProdChart += ",";
		}
		totalSalesPerProdChart += "]";
		mv.addObject("totalSalesPerProdChart", totalSalesPerProdChart);
		
		//년도별 총매출
		List<ChartVO> totalSalesPerYearList = chartService.totalSalesPerYear();
		String totalSalesPerYearChart = "[['년도', '매출'],";
		int j = 0;
		for(ChartVO vo : totalSalesPerYearList) {
			totalSalesPerYearChart += "[\"" + vo.getYear() + "\"," + vo.getTotalSalesPerYear() + "]"; 
			j++;
			if(j < totalSalesPerYearList.size()) totalSalesPerYearChart += ",";
		}
		totalSalesPerYearChart += "]";
		mv.addObject("totalSalesPerYearChart", totalSalesPerYearChart);
		
		//월별 상품별 총매출
		if(StringUtils.isEmpty(purchseDe)) {
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM");
			purchseDe = sdf.format(now);
		}
		List<ChartVO> totalSalesPerMonthList = chartService.totalSalesPerMonth(purchseDe);
		String totalSalesPerMonthChart = "[['상품명', '매출'],";
		int k = 0;
		for(ChartVO vo : totalSalesPerMonthList) {
			totalSalesPerMonthChart += "[\"" + vo.getProdNm() + "\"," + vo.getTotalSalesPerMonth() + "]"; 
			k++;
			if(k < totalSalesPerMonthList.size()) totalSalesPerMonthChart += ",";
		}
		totalSalesPerMonthChart += "]";
		mv.addObject("totalSalesPerMonthChart", totalSalesPerMonthChart);
		
		//판매날짜 년도 표시
		mv.addObject("purchseDeYear", chartService.selectPurchseDeYear());
		
		mv.setViewName("/user/chart/overall");//jsp파일명
		return mv;
	}
	
	/*
	 * 판매날짜에서 년도에 해당하는 월을 리턴 Ajax처리
	 */
	@ResponseBody
	@GetMapping("/selectMonth")
	public ResponseEntity<List<String>> selectMonthAjax(@RequestParam("year") String year, Model model){
		
		ResponseEntity<List<String>> entity = null;
		
		entity = new ResponseEntity<List<String>>(chartService.selectPurchseDeMonth(year), HttpStatus.OK);
		
		return entity;
	}
	
	
}
