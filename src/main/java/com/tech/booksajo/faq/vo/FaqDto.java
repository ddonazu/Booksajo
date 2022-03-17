package com.tech.booksajo.faq.vo;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

//import lombok.Getter;
//import lombok.Setter;

@Getter
@Setter
public class FaqDto {

	private int f_id;
	private String f_writer;
	private String f_title;
	private String f_reply_content;
	private Date f_date;
	private String f_reply_writer;

	public FaqDto() {
		// TODO Auto-generated constructor stub
	}
}

