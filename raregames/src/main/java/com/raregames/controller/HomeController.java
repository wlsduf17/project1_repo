package com.raregames.controller;

import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.raregames.service.ProdManageService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Log4j
@Controller
public class HomeController {
	
	@Resource(name = "uploadFolder")
	private String uploadFolder;//업로드폴더
	
	@Setter(onMethod_ = @Autowired)
	private ProdManageService prodManageService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is " + locale);
		
		model.addAttribute("prodList", prodManageService.selectProdList());
		
		model.addAttribute("newReleaseProdList", prodManageService.selectNewReleaseProdList());
		
		model.addAttribute("onSaleProdList", prodManageService.selectOnSaleProdList());
		
		model.addAttribute("topSellerProdList", prodManageService.selectTopSellerProdList());
		
		return "index";
	}
	
	
	
}
