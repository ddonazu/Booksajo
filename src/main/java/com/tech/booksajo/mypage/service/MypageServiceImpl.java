package com.tech.booksajo.mypage.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tech.booksajo.mypage.mapper.mypageMapper;
import com.tech.booksajo.mypage.vo.Myinfomation;


@Service(value="mypageService")
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	mypageMapper mmapper;

	@Override
	public List<Map<String, Object>> getList() {
		return mmapper.getList();
	}



	@Override
	public Myinfomation userinfotop(String userID) {
		// TODO Auto-generated method stub
		return mmapper.userinfotop(userID);
	}

	@Override
	public List<Map<String, Object>> userinfo(String userID) {
		// TODO Auto-generated method stub
		return mmapper.userinfo(userID);
	}



	@Override
	public List<Map<String,Object>> getcolleclist(String userID) {
		
		return mmapper.getcolleclist(userID);
	}





	@Override
	public void addcolleclist(String userID, String myline_title, String isbn, String page, int line,
			String bookline, String myline) {
		mmapper.addcolleclist(userID,myline_title,isbn,page,line,bookline,myline);
		
	}



	@Override
	public void deletecollect(String userID, String isbn) {
		mmapper.deletecollect(userID,isbn);
		
	}

}
