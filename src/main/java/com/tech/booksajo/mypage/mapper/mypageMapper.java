package com.tech.booksajo.mypage.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;

import com.tech.booksajo.mypage.vo.Myinfomation;

@MapperScan
public interface mypageMapper {
	
	List<Map<String,Object>> getList();	
	Myinfomation userinfotop(String userID);
	List<Map<String, Object>> userinfo(String userID);
	List<Map<String,Object>> getcolleclist(String userID);
	void addcolleclist(String userID, String myline_title, String isbn, String page, int line, String bookline, String myline);
	void deletecollect(String userID, String isbn);
	List<Map<String, Object>> getbuy(String userID);
	void addtitle(Object isbnobj);
	void updatecount(String userID, String noun);
	int getcount(String userID, String noun);
	void updatecount2(String userID, Integer no);
	void insertcount(String userID, String noun);
	void updatecount3(String userID, Integer no);
	List<Map<String, Object>> getmychart(String userID);

}
