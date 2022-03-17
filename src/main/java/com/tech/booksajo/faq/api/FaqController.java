package com.tech.booksajo.faq.api;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tech.booksajo.faq.mapper.FaqMapper;
import com.tech.booksajo.faq.service.FaqService;
import com.tech.booksajo.faq.util.Constant;
import com.tech.booksajo.faq.vo.SearchVO;


@Controller
public class FaqController {
	FaqService faqService;
	
	public JdbcTemplate template;
	
	public void setTemplate(JdbcTemplate template) {
		this.template = template;
		Constant.template=this.template;
	}
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/faqlist")
	public String faqlist(HttpServletRequest request, SearchVO searchVO, Model model) {
		System.out.println("pass by faqlist()");
		
		FaqMapper faqmapper=sqlSession.getMapper(FaqMapper.class);
	
		model.addAttribute("faqlist",faqmapper.faqlist());

		return "faqlist";
	}
	
	
	@RequestMapping("/faqreplyform")
	public String faqreplyform(HttpServletRequest request,Model model) {
		System.out.println("pass by faqreplyform()");
		String fid=request.getParameter("f_id");
		System.out.println("fid : "+ fid);
		model.addAttribute("fid",fid);
		
		return "faqreplyform";
	}
	
	@RequestMapping("/faqreply")
	public String faqreply(HttpServletRequest request) {
		System.out.println("pass by faqreply()");
		String fid=request.getParameter("fid");
		String fcontent=request.getParameter("fcontent");
		System.out.println("fid : "+ fid);
		System.out.println("fid : "+ fcontent);
		FaqMapper faqmapper=sqlSession.getMapper(FaqMapper.class);
		faqmapper.faqreply(Integer.parseInt(fid),fcontent);

		return  "redirect:faqlist";
	}

	@RequestMapping("/faqwriteform")
	public String faqwriteform(HttpServletRequest request,Model model) {
		System.out.println("pass by faqwriteform()");
		
		
		return "faqwriteform";
	}
	
	@RequestMapping("/faqwrite")
	public String faqwriter(HttpServletRequest request) {
		
		System.out.println("pass by faqwriter()");
		
		String fwriter=request.getParameter("fwriter");
		System.out.println("fwriter : "+ fwriter);
		
		String fcontent=request.getParameter("fcontent");
		System.out.println("fcontent : "+ fcontent);
		
		FaqMapper faqmapper=sqlSession.getMapper(FaqMapper.class);
		faqmapper.faqwrite(fwriter,fcontent);

		return  "redirect:faqlist";
	}
	
	@RequestMapping("/faqdelete")
	public String faqdelete(HttpServletRequest request) {
		
		System.out.println("pass by faqdelete()");
		
		String fid=request.getParameter("f_id");
		System.out.println("fid : "+ fid);
		
		String fcontent=request.getParameter("fcontent");
		
		FaqMapper faqmapper=sqlSession.getMapper(FaqMapper.class);
		faqmapper.faqdelete(fid);

		return  "redirect:faqlist";
	}
}
	

	
