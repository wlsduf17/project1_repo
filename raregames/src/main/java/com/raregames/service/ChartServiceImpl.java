package com.raregames.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.raregames.domain.ChartVO;
import com.raregames.mapper.ChartMapper;

import lombok.Setter;

@Service
public class ChartServiceImpl implements ChartService{
	
	@Setter(onMethod_ = @Autowired)
	private ChartMapper chartMapper;
	
	@Override
	public List<ChartVO> totalSalesPerProd() {
		return chartMapper.totalSalesPerProd();
	}

	@Override
	public List<ChartVO> totalSalesPerYear() {
		return chartMapper.totalSalesPerYear();
	}

	@Override
	public List<ChartVO> totalSalesPerMonth(String purchseDe) {
		return chartMapper.totalSalesPerMonth(purchseDe);
	}

	@Override
	public List<String> selectPurchseDeYear() {
		return chartMapper.selectPurchseDeYear();
	}

	@Override
	public List<String> selectPurchseDeMonth(String year) {
		return chartMapper.selectPurchseDeMonth(year);
	}
	
	
	
	
}
