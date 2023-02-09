package com.raregames.service;

import java.util.List;

import com.raregames.domain.ChartVO;

public interface ChartService {
	
	public List<ChartVO> totalSalesPerProd();

	public List<ChartVO> totalSalesPerYear();
	
	public List<ChartVO> totalSalesPerMonth(String purchseDe);
	
	public List<String> selectPurchseDeYear();
	
	public List<String> selectPurchseDeMonth(String year);
}
