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

		/*		for (Map<String, Object> map : getbuylist) { //확인완료
					// 리스트 내용 꺼내보기 제대로 들어갔나
					System.out.println("getbuylist:" + map);
				}*/

		// 책 리스트 isbn에서 책 제목 가져오기..네이버 api이용해보쟈.. => 이클립스에서 출력확인함

		List<Token> adtokenList = new ArrayList<Token>();
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
				String isbn13 = "";
				String titlestr = "";

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
				isbn13 = isbnobj.toString().substring(11, 24);
				System.out.println("title오브제나와라:" + titleobj);
				// isbn에 맞는 도서타이틀을 추가해준다...tellcate 함수에서 쓰려는 목적..
				// 가져가야할것.. isbn
				mmapper.addtitle(isbn13);

				// 의도: 디비 테이블에 책제목이 포함안되있으니 일일히 다 넣어주는 작업을 해준다.

				// 디비 테이블 확인해보면 다 isbn에 맞게 타이틀 들어갔음..

				// 책 제목 에서 토큰 뽑아내기 작업
				titlestr = titleobj.toString();
				String strToAnalyze = titlestr;

				Komoran komoran = new Komoran(DEFAULT_MODEL.FULL);

				KomoranResult analyzeResultList = komoran.analyze(strToAnalyze);

				// 한줄 텍스트로 받기
				// System.out.println(analyzeResultList.getPlainText());

				// 토큰으로 리스트로 받기..

				// tokenList = analyzeResultList.getTokenList();
				tokenList.addAll(analyzeResultList.getTokenList());

				/*				 for (Token token : tokenList) {  //모든 제목에서 토큰 얻은것 확인함.
								 System.out.format("(%2d, %2d) %s/%s\n", token.getBeginIndex(),
								 token.getEndIndex(), token.getMorph(), token.getPos()); 
								 
								 int beginIndex=token.getBeginIndex();
								 int endIndex=token.getEndIndex();
								 String morph=token.getMorph();
								 String pos=token.getPos();
								 
								 }*/

				// 토큰 갯수 확인해보기

				System.out.println("토큰사이즈:" + tokenList.size());

				// 결과는 여러게 책이니까 스트링타입 리스트로 보내줘야겠지..

				// strlist.add(analyzeResultList.getPlainText());

			} catch (Exception e) {
				System.out.println("--���몄�� ");
				System.out.println(e);
			}
		}

		// System.out.println("전체 토큰사이즈:"+tokenList.size()); //토큰갯수 9로 나오는 걸로봐서 마지막것만
		// 들어오는것같네.. 추가되서 다 들어와야 하는데.
		// 수정 후 102개 넘게 된거보니 다 들어옴 확인

		return tokenList;
	}

	@Override
	public ArrayList<Object> getkeyword(List<Map<String, Object>> getbuylist) throws Exception {
		// isbn리스트에서 키워드 뽑아보는 작업

		// ArrayList<Object> keywordlist = new ArrayList<Object>();
		System.out.println("getkeyword매소드 들어옴");
		ArrayList<Object> keylist = new ArrayList<Object>();
		ArrayList<Integer> keylistSize = new ArrayList<Integer>();
		JSONArray jarr = null;

		String isbn13 = "";
		for (int i = 0; i < getbuylist.size(); i++) {
			isbn13 = getbuylist.get(i).toString().substring(6, 19);

			// 도서나루접속

			String serviceKey = "http://data4library.kr/api/keywordList?authKey=72e70652c089ddede639f01b2e237eebaf6f5ec4bbd2b6ceee0bc852b0ee32b2";
			String urlStr = serviceKey + "&isbn13=" + isbn13 + "&additionalYN=Y&format=json";

			URL url = new URL(urlStr);

			BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream()));

			try { // 응답결과 -> 확인

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

				// System.out.println(json1.get("items"));
				// System.out.println("jarr의 사이즈:" + jarr.size());
				// System.out.println("getbuylist사이즈:" + getbuylist.size());

				// SearchView sv = new SearchView();
				// 키워드가 너무 많은데.. 중간에 끊어야하는데

				/*				for (int z = 0; z < 3; z++) { // 0.1.2 3개만 뽑기
									jarr.get(z);
									System.out.println(jarr.get(z));
									// sv.setWordlist(keywordlist);
									keylist.add(jarr.get(z).toString());
								}*/

				// 3반복이 추가가 아니라...꺼내면서 넣어줘야하는듯.. 틀린이유... 계속 같은게 들어간이유. for 반복문이 아니라 요소를 꺼내주는
				// foreach를 써야했음

				for (int z = 0; i < jarr.size(); z++) {
					JSONObject str = (JSONObject) jarr.get(z);
					// System.out.println(jarr.get(z));
					// System.out.println("str:"+str);
					JSONObject str2 = (JSONObject) str.get("item");
					// System.out.println("str2:"+str2.get("word"));
					keylist.add(str2);
					keylistSize.add(keylist.size());
				}

				keylist.clear();
				keylistSize.clear();

			} catch (Exception e) {

			}

		}

		return keylist;

	}

	@Override
	public ArrayList<Integer> getcate(List<Map<String, Object>> getbuylist) throws Exception {

		System.out.println("getcate매소드 들어옴");

		// 도서구매 리스트에서 카테고리 대 .중.소 카테고리 뽑아서 리스트에 담아서 보내주기 -> 문제 요청에서 카테고리 사용할수있지 리스폰에서
		// 카테고리 받아오는게 없다. -> 도서나루 이용해야할덧.

		ArrayList<Integer> catelist = new ArrayList<Integer>();
		ArrayList<Object> catenmlist = new ArrayList<Object>();
		ArrayList<Integer> catelistSize = new ArrayList<Integer>();
		JSONArray jarr = null;

		String isbn13 = "";
		for (int i = 0; i < getbuylist.size(); i++) {
			// 여기서는 요청시에 isbn13이 아니라 10자리가 들어감 조정하기
			isbn13 = getbuylist.get(i).toString().substring(6, 19);

			// 도서나루접속 -> 카테고리 응답나오는 주소로
			// http://data4library.kr/api/loanItemSrch?authKey=[발급받은키]&startDt=2017-01-01&endDt=2017-03-27&gender=0&from_age=6&to_age=10&region=11;22&addCode=0&kdc=6&pageNo=1&pageSize=10
			// http://data4library.kr/api/loanItemSrch?authKey=72e70652c089ddede639f01b2e237eebaf6f5ec4bbd2b6ceee0bc852b0ee32b2&addCode=9788960515529&pageNo=1&pageSize=10&format=json
			// http://data4library.kr/api/srchDtlList?authKey=[발급받은키]&isbn13=9788972756194&loaninfoYN=Y&displayInfo=age

			String serviceKey = "http://data4library.kr/api/srchDtlList?authKey=72e70652c089ddede639f01b2e237eebaf6f5ec4bbd2b6ceee0bc852b0ee32b2";
			String urlStr = serviceKey + "&isbn13=" + isbn13 + "&format=json";

			URL url = new URL(urlStr);

			BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream()));

			try { // 응답결과 -> 확인

				String jstr = bf.readLine();

				String strJson = jstr;

				JSONParser jsonParser = new JSONParser();

				Object obj = jsonParser.parse(strJson);

				JSONObject jsonObj = (JSONObject) obj;

				// System.out.println("리스폰:"+jsonObj.get("response"));

				Object responseObj = jsonObj.get("response");

				JSONObject json1 = (JSONObject) responseObj;

				System.out.println();

				// System.out.println("디테일:" + json1.get("detail"));

				jarr = (JSONArray) json1.get("detail");

				for (int z = 0; z < jarr.size(); z++) {

					// 제이슨오브젝트 에서 제이슨 어레이로 형변환 안됌. 그래서 오브젝트로 담아줌
					JSONObject str = (JSONObject) jarr.get(z);
					System.out.println("1:" + str);
					Object str2 = (Object) str.get("book");
					JSONObject strobj = (JSONObject) str2;
					// System.out.println("2:"+strobj.get("class_no"));
					Object str3 = strobj.get("class_no");
					Object str4 = strobj.get("class_nm");

					catelist.add((Integer) str3);
					catenmlist.add(str4);
					catelistSize.add(catelist.size());
				}

			} catch (Exception e) {

			}

		}

		return catelist;

	}

	@Override
	public List<Token> tellcate(List<Token> strlist) {

		// 조인을 써야할듯함.. 카테고리 테이블과... 명사추출한 것의 카테고리명을 비교해서 똑같으면 카테고리번호 가져오기 **
		// 형태소 토큰으로 가져와야겠네->완료

		// 도서명이 없어서 안돼겠네.. 어케하지 isbn에 맞는 도서명을 테이블에 필드추가해준다... ->완료

		return null;
	}

	@Override
	public void nounCount(List<Token> strlist, ArrayList<Object> keylist, ArrayList<Integer> catelist, String userID) {
		// 1.명사일치하면 카운트 올려주는 서비스. 2.관심키워드 명사형태로 보여주는 것도 (잡플래닛 평점 키워드같이보이도록.. 몇개만)
		// strlist: 도서제목에서 명사추출 리스트 keylist:도서 키워드에서 명사추출 리스트 catelist:도서 카테고리에서 kdc숫자
		// 추출 리스트

		System.out.println("nounCount매소드 들어옴");

		// << strlist: 도서제목에서 명사추출 리스트 >>
		// 1.카테고리나 키워드 명 일 경우 : kdc랑 조인해서 해당 카테고리에 카운트 올리고 2. kdc일경우 카테고리 번호일경우 가장 앞자리와
		// 중간까지 -> kdc숫자 기준으로 카운트 올려주고 첫째랑 두째자리숫자까지만 반영하여 카운트 업

		// 반복문 하면서 카운트 올려야 겠네. 리스트에서 명사 하나나올때마다 비교해서 넣어줘야하니까..
		String hung = "";
		String noun = "";

		for (Token token : strlist) { // 토큰에서 명사만 꺼내기
			// System.out.format("(%2d, %2d) %s/%s\n", token.getBeginIndex(),
			// token.getEndIndex(), token.getMorph(),token.getPos());

			hung = token.getPos();
			noun = token.getMorph();

			System.out.println("hung:" + hung + " noun:" + noun);
			System.out.println("0~2까지 형태이름:" + hung.substring(0, 2));

			if (hung.substring(0, 2).equals("NN")) { // 형태소가 NNP or NNG일때 틀린이유.. 0이상 1미만이니까. 미만이니까.. 2로 해줘야했음
				// 그리고 hung.substring(0, 2).equals("NN") 로하니까 됨 hung.substring(0, 2)=="NN"으로 하니까
				// 안됌...

				System.out.println("들어옴");
				System.out.println("형태:" + hung + "명사뽑기:" + noun);

				// 책제목 명사를 통한 명사로 -> 카테고리 조인해서 kdc 번호찾기 -> 존재 -> 해당 kdc에 카운드 +1 하기
				// 책제목 명사를 통한 명사로 -> 카테고리 조인해서 kdc 번호찾기 -> 없음 -> 테이블에 레이블 없을때 사용할수있는 함수로 처리하기
				// (생각 더 해보기)

				// 그럼 일단 셀렉트로 가져와보고 셀렉트 값이 없을때 있을때를 조건으로 나눠서 업데이트하던가 추가한던가 해서 경로 진행 만들어주기

				int count = mmapper.getcount(userID, noun);

				if (count == 1) {
					// 존재 -> 해당 kdc에 카운드 +1 하기

					mmapper.updatecount(userID, noun);

				} else if (count == 0) {
					// 없음 -> 테이블에 레이블 없을때 사용할수있는 함수로 처리하기 (생각 더 해보기)

					mmapper.insertcount(userID, noun);

				} else {// 기타 널이라던가.. 추가적 상황

					System.out.println("문제발생");

					// mmapper.expectcount(userID,noun);
				}
			}
		}

		// << keylist:도서 키워드에서 명사추출 리스트 >>
		
		
		
		for (int i = 0; i < keylist.size(); i++) {

			String keynoun=(String)keylist.get(i);
			
			int count=mmapper.getcount(userID, keynoun);
					
			if (count == 1) {
				// 존재 -> 해당 kdc에 카운드 +1 하기

				mmapper.updatecount(userID, keynoun);

			} else if (count == 0) {
				// 없음 -> 테이블에 레이블 없을때 사용할수있는 함수로 처리하기 (생각 더 해보기)

				mmapper.insertcount(userID, keynoun);

			} else {// 기타 널이라던가.. 추가적 상황

				System.out.println("문제발생");

				// mmapper.expectcount(userID,noun);
			}

		}
		// << catelist:도서 카테고리에서 kdc숫자 추출 리스트 >> 

		for (Integer no : catelist) { // 리스트 내용 빼면서 카운트 올려 주기
			//kdc 숫자3자리인데.. 첫째숫자 카운트올리고 두째숫자 카운트도 올리는것으로 사용하는것으로 
			mmapper.updatecount2(userID, no);
			mmapper.updatecount3(userID, no);
		}
	}

	public List<Map<String, Object>> getmychart(String userID) {
		// mychart에 쓰일 테이블 정보가져오기
		//셀렉트로 가져온다.. 위에서 열심히 카운트한 테이블
		
		return mmapper.getmychart(userID);
		
		
		
		
		
	}

}
