package com.tech.booksajo.mypage.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
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



	@Override
	public List<Map<String, Object>> getbuy(String userID) {
		// 1.구매 책 가져오는 서비스 ..구매한 책은 임의로 테이블 만들어서 봐보기..
		return mmapper.getbuy(userID);
	}



	@Override
	public ArrayList<String> komoran(List<Map<String, Object>> getbuylist) {
		// [책 리스트가져가와서 책 제목에서  형태소 분석하기 연계 세트]
		
		for (Map<String, Object> map : getbuylist) {
			//리스트 내용 꺼내보기 제대로 들어갔나
			System.out.println(map.get("isbn"));
		}
	

		//책 리스트 isbn에서 책 제목 가져오기..네이버 api이용해보쟈.. => 이클립스에서 출력확인함

		
		String clientId = "tlTkArS2TLVhHt8EHhoo";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "aoT379DF4S";//애플리케이션 클라이언트 시크릿값";
        
		try {
		
			/*�닿��� ��諛���. 9788968481475(8968481474)*/
			String isbn = "9788968481475";
			String text = URLEncoder.encode("안녕", "UTF-8");
			String postParams="d_isbn="+isbn;
			String apiURL="https://openapi.naver.com/v1/search/book_adv.json?"+postParams;
			URL url=new URL(apiURL);
			
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			con.setRequestProperty("Content-Type", "text/json");
			con.setRequestProperty("charset", "utf-8");
			con.setUseCaches(false);
			con.setDoInput(true);
			con.setDoOutput(true);
			
			int responseCode=con.getResponseCode();
			System.out.println("responseCode >> "+responseCode);
			BufferedReader br;
			if (responseCode==200) { //�����몄���
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			}
			else { //���� 諛���
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			
			String inputLine;
			StringBuffer res= new StringBuffer();
			while ((inputLine=br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			System.out.println("응답 결과 >> "+res.toString());
			//이제 이결과를 제이슨 타입으로 파싱해준다.
			JSONParser json = new JSONParser();
			JSONObject jsonobj=(JSONObject) json.parse(res.toString());
			
			JSONArray jsonarr=(JSONArray) jsonobj.get("items");
			
			Object isbnobj=new Object();
			Object titleobj=new Object();
			Object urlobj=new Object();
			Object priceobj=new Object();
			Object saleobj=new Object();
			
			
			isbnobj="";
			titleobj="";
			urlobj="";
			priceobj="";
			saleobj="";
			
			
			for (Object object : jsonarr) {
				System.out.println(object);
				JSONObject jobj=(JSONObject) object; //제이슨오브제로 바꿔줘야 키와벨류로 가져온다.
				isbnobj=jobj.get("isbn");
				priceobj=jobj.get("price");
				saleobj=jobj.get("discount");
				urlobj=jobj.get("image");
				titleobj=jobj.get("title");
			}
			System.out.println("title오브제나와라:"+titleobj);
			
			
			
		} catch (Exception e) {
			System.out.println("--���몄�� ");
			System.out.println(e);
		}
		
		
		
		//책 제목 넣어주기
		String strToAnalyze="";
		
		Komoran komoran =new Komoran(DEFAULT_MODEL.FULL);
		
		KomoranResult analyzeResultList=komoran.analyze(strToAnalyze);
		
		
		//한줄 텍스트로 받기
		System.out.println(analyzeResultList.getPlainText());

		//토큰으로 리스트로 받기..
	       /* List<Token> tokenList = analyzeResultList.getTokenList();
	        for (Token token : tokenList) {
	            System.out.format("(%2d, %2d) %s/%s\n", token.getBeginIndex(), token.getEndIndex(), token.getMorph(), token.getPos());
	        }*/
		
		
		//결과는 여러게 책이니까 스트링타입 리스트로 보내줘야겠지..
		
		ArrayList<String> strlist=new ArrayList<String>();
		
		return strlist;
	}



	@Override
	public ArrayList<String> getkeyword(List<Map<String, Object>> getbuylist) {
		// isbn리스트에서 키워드 뽑아보는 작업
		
		ArrayList<Object> keywordlist = new ArrayList<Object>();
		System.out.println("getkeyword매소드 들어옴");
		
		
		//도서나루접속
/*		String serviceKey = "http://data4library.kr/api/keywordList?authKey=72e70652c089ddede639f01b2e237eebaf6f5ec4bbd2b6ceee0bc852b0ee32b2";
		String urlStr = serviceKey + "&isbn13=" + isbn13 + "&additionalYN=Y&format=json";

		URL url = new URL(urlStr);

		BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream()));

		try {

			String jstr = bf.readLine();

			String strJson = jstr;

			JSONParser jsonParser = new JSONParser();

			Object obj = jsonParser.parse(strJson);

			JSONObject jsonObj = (JSONObject) obj;

			//System.out.println(jsonObj.get("response")); 

			Object responseObj = jsonObj.get("response");
			JSONObject json1 = (JSONObject) responseObj;

			System.out.println();

			//System.out.println("json1.get아이템:" + json1.get("items")); 

			JSONArray jarr = (JSONArray) json1.get("items");

			SearchView sv = new SearchView();

			for (int i = 0; i < jarr.size(); i++) {
				jarr.get(i);
				System.out.println(jarr.get(i));
				keywordlist.add(jarr.get(i));
				sv.setWordlist(keywordlist);

			}

		} catch (

		Exception e) {

		}*/

		
		
		ArrayList<String> keylist=new ArrayList<String>();
		
		return keylist;
	}

}
