package com.raregames.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.raregames.domain.Criteria;
import com.raregames.domain.FeatureVO;
import com.raregames.domain.GenreVO;
import com.raregames.domain.ProdManageVO;

public interface ProdManageMapper {
	
	public int insertProd(ProdManageVO prodManageVO);
	
	public List<GenreVO> selectGenreList();
	
	public List<FeatureVO> selectFeatureList();
	
	public List<ProdManageVO> selectProdList();
	
	public List<ProdManageVO> selectProdListWithPaging(Criteria criteria);
	
	public int getTotalCo(Criteria criteria);
	
	public ProdManageVO selectProd(Integer prodNo);
	
	public int deleteProd(Integer prodNo);
	
	public int updateProd(ProdManageVO prodManageVO);
	
	public String selectGenreNm(String genreCd);
	
	public String selectFeatureNm(String featureCd);
	
	public List<ProdManageVO> selectCategoryListWithPaging
			(		@Param("criteria") Criteria criteria,
					@Param("genreCd") String genreCd,
					@Param("featureCd") String featureCd);
	
	public int getCategoryTotalCo
			(		@Param("criteria") Criteria criteria,
					@Param("genreCd") String genreCd,
					@Param("featureCd") String featureCd);
	
	public List<ProdManageVO> selectOnSaleProdList();
	
	public List<ProdManageVO> selectNewReleaseProdList();
	
	public List<ProdManageVO> selectTopSellerProdList();
}
