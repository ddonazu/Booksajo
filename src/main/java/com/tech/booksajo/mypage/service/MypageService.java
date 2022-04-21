package com.tech.booksajo.mypage.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Service;

import com.tech.booksajo.mypage.vo.Myinfomation;
import com.tech.booksajo.payment.vo.PayInfomation;

import kr.co.shineware.nlp.komoran.model.Token;


public interface MypageService  {
	
	List<Map<String,Object>> getList();
	Myinfomation userinfotop(String userID);
	List<Map<String, Object>> userinfo(String userID);
	List<Map<String,Object>> getcolleclist(String userID);
	void addcolleclist(String userID, String myline_title, String isbn, String page, int line, String bookline, String myline);
	void deletecollect(String userID, String isbn);
	List<Map<String, Object>> getbuy(String userID);
	List<Token> komoran(List<Map<String, Object>> getbuylist);
	ArrayList<Object> getkeyword(List<Map<String, Object>> getbuylist) throws Exception;
	ArrayList<Integer> getcate(List<Map<String, Object>> getbuylist) throws Exception;
	List<Token> tellcate(List<Token> strlist);
	void nounCount(List<Token> strlist, ArrayList<Object> keylist, ArrayList<Integer> catelist,String userID);
	List<Map<String,Object>> getmychart(String userID);


}
