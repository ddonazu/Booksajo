package com.tech.booksajo.faq.mapper;

import java.util.ArrayList;

import com.tech.booksajo.faq.vo.FaqDto;

public interface FaqMapper {
	public ArrayList<FaqDto> faqlist();
	public void faqreply(int fid, String fcontent);
	public void faqwrite(String fwriter, String fcontent);
	public void faqdelete(String fid);
}
