package com.tech.booksajo.mypage.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Service;

import com.tech.booksajo.mypage.vo.Myinfomation;
import com.tech.booksajo.payment.vo.PayInfomation;


public interface MypageService  {
	
	List<Map<String,Object>> getList();
	Myinfomation userinfotop(String userID);
	List<Map<String, Object>> userinfo(String userID);
	List<Map<String,Object>> getcolleclist(String userID);
	void addcolleclist(String userID, String myline_title, String isbn, String page, int line, String bookline, String myline);
	void deletecollect(String userID, String isbn);
	List<Map<String, Object>> getbuy(String userID);
	ArrayList<String> komoran(List<Map<String, Object>> getbuylist);
	ArrayList<String> getkeyword(List<Map<String, Object>> getbuylist);

}
