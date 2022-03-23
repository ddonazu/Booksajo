package com.tech.booksajo.mypage.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tech.booksajo.mypage.mapper.mypageMapper;
import com.tech.booksajo.mypage.vo.Myinfomation;
import com.tech.booksajo.search.vo.SearchView;

import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import kr.co.shineware.nlp.komoran.model.Token;

@Service(value = "mypageService")
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
	public List<Map<String, Object>> getcolleclist(String userID) {

		return mmapper.getcolleclist(userID);
	}

	@Override
	public void addcolleclist(String userID, String myline_title, String isbn, String page, int line, String bookline,
			String myline) {
		mmapper.addcolleclist(userID, myline_title, isbn, page, line, bookline, myline);

	}

	@Override
	public void deletecollect(String userID, String isbn) {
		mmapper.deletecollect(userID, isbn);

	}

	@Override
	public List<Map<String, Object>> getbuy(String userID) {
		// 1.구매 책 가져오는 서비스 ..구매한 책은 임의로 테이블 만들어서 봐보기..
		return mmapper.getbuy(userID);
	}

	@Override
	public List<Token> komoran(List<Map<String, Object>> getbuylist) {
		// [책 리스트가져가와서 책 제목에서 형태소 분석하기 연계 세트]

		for (Map<String, Object> map : getbuylist) {
			// 리스트 내용 꺼내보기 제대로 들어갔나
			System.out.println("getbuylist:" + map);
		}

		// 책 리스트 isbn에서 책 제목 가져오기..네이버 api이용해보쟈.. => 이클립스에서 출력확인함

		List<Token> tokenList = new ArrayList<Token>();
		String isbn = "";
		for (int i = 0; i < getbuylist.size(); i++) {
			System.out.println("번호만 추출후:" + getbuylist.get(i).toString().substring(6, 19));
			isbn = getbuylist.get(i).toString().substring(6, 19);

			String clientId = "tlTkArS2TLVhHt8EHhoo";// 애플리케이션 클라이언트 아이디값";
			String clientSecret = "aoT379DF4S";// 애플리케이션 클라이언트 시크릿값";

			try {

				/* �닿��� ��諛���. 9788968481475(8968481474) */
				// String text = URLEncoder.encode("안녕", "UTF-8");
				String postParams = "d_isbn=" + isbn;
				String apiURL = "https://openapi.naver.com/v1/search/book_adv.json?" + postParams;
				URL url = new URL(apiURL);

				HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("GET");
				con.setRequestProperty("X-Naver-Client-Id", clientId);
				con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
				con.setRequestProperty("Content-Type", "text/json");
				con.setRequestProperty("charset", "utf-8");
				con.setUseCaches(false);
				con.setDoInput(true);
				con.setDoOutput(true);

				int responseCode = con.getResponseCode();
				System.out.println("responseCode >> " + responseCode);
				BufferedReader br;
				if (responseCode == 200) { // �����몄���
					br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				} else { // ���� 諛���
					br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				}

				String inputLine;
				StringBuffer res = new StringBuffer();
				while ((inputLine = br.readLine()) != null) {
					res.append(inputLine);
				}
				br.close();
				System.out.println("응답 결과 >> " + res.toString());
				// 이제 이결과를 제이슨 타입으로 파싱해준다.
				JSONParser json = new JSONParser();
				JSONObject jsonobj = (JSONObject) json.parse(res.toString());

				JSONArray jsonarr = (JSONArray) jsonobj.get("items");

				Object isbnobj = new Object();
				Object titleobj = new Object();
				Object urlobj = new Object();
				Object priceobj = new Object();
				Object saleobj = new Object();
				String isbn13="";
				String titlestr="";
				
				isbnobj = "";
				titleobj = "";
				urlobj = "";
				priceobj = "";
				saleobj = "";
				
				for (Object object : jsonarr) {
					System.out.println(object);
					JSONObject jobj = (JSONObject) object; // 제이슨오브제로 바꿔줘야 키와벨류로 가져온다.
					isbnobj = jobj.get("isbn");
					priceobj = jobj.get("price");
					saleobj = jobj.get("discount");
					urlobj = jobj.get("image");
					titleobj = jobj.get("title");
				}
				isbn13=isbnobj.toString().substring(11, 24);
				System.out.println("title오브제나와라:" + titleobj);
				//isbn에 맞는 도서타이틀을 추가해준다...tellcate 함수에서 쓰려는 목적..
				//가져가야할것.. isbn
				mmapper.addtitle(isbn13);
				
				//테이블 확인해보면 다 isbn에 맞게 타이틀 들어갔음.. 제목
				
				
				// 책 제목 넣어주기
				titlestr=titleobj.toString();
				String strToAnalyze = titlestr;

				Komoran komoran = new Komoran(DEFAULT_MODEL.FULL);

				KomoranResult analyzeResultList = komoran.analyze(strToAnalyze);

				// 한줄 텍스트로 받기
				//System.out.println(analyzeResultList.getPlainText());

				// 토큰으로 리스트로 받기..
				
				 tokenList = analyzeResultList.getTokenList(); 
/*
				 for (Token token : tokenList) { 
				 System.out.format("(%2d, %2d) %s/%s\n", token.getBeginIndex(),
				 token.getEndIndex(), token.getMorph(), token.getPos()); 
				 
				 }
				*/
				 
				// 결과는 여러게 책이니까 스트링타입 리스트로 보내줘야겠지..

				//strlist.add(analyzeResultList.getPlainText());

			} catch (Exception e) {
				System.out.println("--���몄�� ");
				System.out.println(e);
			}

		}

		return tokenList;
	}

	@Override
	public ArrayList<String> getkeyword(List<Map<String, Object>> getbuylist) throws Exception {
		// isbn리스트에서 키워드 뽑아보는 작업

		// ArrayList<Object> keywordlist = new ArrayList<Object>();
		System.out.println("getkeyword매소드 들어옴");
		ArrayList<String> keylist = new ArrayList<String>();
		JSONArray jarr = null;
		

		String isbn13 = "";
		for (int i = 0; i < getbuylist.size(); i++) {
			isbn13 = getbuylist.get(i).toString().substring(6, 19);

			// 도서나루접속

			String serviceKey = "http://data4library.kr/api/keywordList?authKey=72e70652c089ddede639f01b2e237eebaf6f5ec4bbd2b6ceee0bc852b0ee32b2";
			String urlStr = serviceKey + "&isbn13=" + isbn13 + "&additionalYN=Y&format=json";

			URL url = new URL(urlStr);

			BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream()));

			try {

				String jstr = bf.readLine();

				String strJson = jstr;

				JSONParser jsonParser = new JSONParser();

				Object obj = jsonParser.parse(strJson);

				JSONObject jsonObj = (JSONObject) obj;

				// System.out.println(jsonObj.get("response"));

				Object responseObj = jsonObj.get("response");
				JSONObject json1 = (JSONObject) responseObj;

				System.out.println();

				// System.out.println("json1.get아이템:" + json1.get("items"));

				jarr = (JSONArray) json1.get("items");
				//System.out.println("jarr의 사이즈:" + jarr.size());
				//System.out.println("getbuylist사이즈:" + getbuylist.size());
				
				
				// SearchView sv = new SearchView();
				// 키워드가 너무 많은데.. 중간에 끊어야하는데
				
				
				
/*				for (int z = 0; z < 3; z++) { // 0.1.2 3개만 뽑기
					jarr.get(z);
					System.out.println(jarr.get(z));
					// sv.setWordlist(keywordlist);
					keylist.add(jarr.get(z).toString());
				}*/
				
				//3반복이 추가가 아니라...꺼내면서 넣어줘야하는듯.. 틀린이유... 계속 같은게 들어간이유. for 반복문이 아니라 요소를 꺼내주는 foreach를 써야했음
				
				for (Object object : jarr) {
					
					JSONObject jj = (JSONObject)object;
					System.out.println("키워드뽑기:"+jj.get("keyword").toString());
					String jjstr=jj.get("keyword").toString();
					keylist.add(jjstr);
				}
				
				jarr.clear();
				
			} catch (Exception e) {
				
			}
				
				
			

		}

		return keylist;

	}

	@Override
	public ArrayList<String> getcate(List<Map<String, Object>> getbuylist) {
		//도서구매 리스트에서 카테고리 대 .중.소 카테고리 뽑아서 리스트에 담아서 보내주기
		
		String isbn = "";
		for (int i = 0; i < getbuylist.size(); i++) {//반복문... 반복시킨다	
			isbn = getbuylist.get(i).toString().substring(6, 19);

			String clientId = "tlTkArS2TLVhHt8EHhoo";// 애플리케이션 클라이언트 아이디값";
			String clientSecret = "aoT379DF4S";// 애플리케이션 클라이언트 시크릿값";

			try {

				/* �닿��� ��諛���. 9788968481475(8968481474) */
				// String text = URLEncoder.encode("안녕", "UTF-8");
				String postParams = "d_isbn=" + isbn;
				String apiURL = "https://openapi.naver.com/v1/search/book_adv.json?" + postParams;
				URL url = new URL(apiURL);

				HttpURLConnection con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("GET");
				con.setRequestProperty("X-Naver-Client-Id", clientId);
				con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
				con.setRequestProperty("Content-Type", "text/json");
				con.setRequestProperty("charset", "utf-8");
				con.setUseCaches(false);
				con.setDoInput(true);
				con.setDoOutput(true);

				int responseCode = con.getResponseCode();
				System.out.println("responseCode >> " + responseCode);
				BufferedReader br;
				if (responseCode == 200) { // �����몄���
					br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				} else { // ���� 諛���
					br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				}

				String inputLine;
				StringBuffer res = new StringBuffer();
				while ((inputLine = br.readLine()) != null) {
					res.append(inputLine);
				}
				br.close();
				System.out.println("응답 결과 >> " + res.toString());
				// 이제 이결과를 제이슨 타입으로 파싱해준다.
				JSONParser json = new JSONParser();
				JSONObject jsonobj = (JSONObject) json.parse(res.toString());

				JSONArray jsonarr = (JSONArray) jsonobj.get("items");
		
			
				
				
				
			} catch (Exception e) {
				System.out.println("--���몄�� ");
				System.out.println(e);
			}
		}
		
		
		return null;
	}

	@Override
	public List<Token> tellcate(List<Token> strlist) {
		
		//조인을 써야할듯함.. 카테고리 테이블과... 명사추출한 것의 카테고리명을 비교해서 똑같으면 카테고리 가져오기
		//형태소 토큰으로 가져와야겠네
		
		
		//구매목록이랑... 카테고리명 비교안해도 쿼리문으로만 조인이 가능한가...?? 해봐야겠다
		//도서명이 없어서 안돼겠네.. 어케하지  isbn에 맞는 도서명을 테이블에 필드추가해준다...
		
		
		
		
		return null;
	}

}
