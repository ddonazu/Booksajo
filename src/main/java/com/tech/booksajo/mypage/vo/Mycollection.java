package com.tech.booksajo.mypage.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Mycollection {

	private String user_id;
	private int collection_id;
	private String myline_title;
	private String isbn;
	private String page;
	private int line;
	private String bookline;
	private String myline;

	
	public Mycollection() {
		// TODO Auto-generated constructor stub
	}


	public Mycollection(String user_id, int collection_id, String myline_title, String isbn, String page, int line,
			String bookline, String myline) {
		this.user_id = user_id;
		this.collection_id = collection_id;
		this.myline_title = myline_title;
		this.isbn = isbn;
		this.page = page;
		this.line = line;
		this.bookline = bookline;
		this.myline = myline;
	}



	
}
