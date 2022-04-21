package com.tech.booksajo.mypage.api;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tech.booksajo.mypage.service.MypageService;
import com.tech.booksajo.mypage.vo.Myinfomation;

import kr.co.shineware.nlp.komoran.model.Token;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class MypageController {
	
	@Autowired
	MypageService mypageService;
	
	@RequestMapping(value = "/mypage/api/getList", method = RequestMethod.GET  )
	@ResponseBody
	public List<Map<String,Object>> getList(){
		return mypageService.getList();
	}
	
	@RequestMapping("/mypage")
	public String mypage(Model model) {
		
		
		/*System.out.println(map.get("userId"));
		String userID=map.get("userId").toString();
		
		List<Map<String,Object>> meme=mypageService.userinfo(userID);
*/
		
		//model.addAttribute("myinfo", meme);
		
		return "mypage";
	}
	

	
	
	@RequestMapping("/mycontents")
	public String mycontents(Model model) {
		
		System.out.println("mycontents 맵핑 들어옴");
		
		return "mycontents";
	}
	

	@RequestMapping("/myinfo")
	public String myInfo(Model model) {
	
		System.out.println("mypage인포 맵핑들어옴");
		//회원 정보 가져와서 뿌려주기
		
		//Myinfomation meme=new Myinfomation();
		
		//meme=mypageService.userinfo();
		
/*		System.out.println(map.get("userId"));
		String userID=map.get("userId").toString();
		
		
		List<Map<String,Object>> meme=mypageService.userinfo(userID);
		
		
		model.addAttribute("myinfo", meme);*/
		
		//리턴 받은것 모델에 담아서 보내주긔
		
		return "myinfo";
	}
	
	
	@RequestMapping("/mypage_center2")
	public String mypage_center2(Model model) {
		
		System.out.println("주문배송조회 맵핑 들어옴");
		
		return "mypage_center2";
	}
	
	
	@RequestMapping("/mypageuser")
	@ResponseBody
	public Myinfomation mypageuser(@RequestBody Map<String,Object> map) {
	
		
		/*리스폰스 바디 안붙여주면 바디를 찾을수없다고 자바스크립트 리턴받는부분에서 에러남/ 해결.. 공부해야할덧*/
		System.out.println("mypageuser들어왔나요?================");
		System.out.println(map.get("userId"));
		String userID=map.get("userId").toString();
		
		
		return mypageService.userinfotop(userID);

	}
	
	
	@RequestMapping("/mypage_detail_info")
	@ResponseBody
	public List<Map<String,Object>> mypage_detail_info(@RequestBody Map<String,Object> map) {
	
		
		/*리스폰스 바디 안붙여주면 바디를 찾을수없다고 자바스크립트 리턴받는부분에서 에러남/ 해결.. 공부해야할덧*/
		System.out.println("mypageuser들어왔나요?================");
		System.out.println(map.get("userId"));
		String userID=map.get("userId").toString();
		
		
		return mypageService.userinfo(userID);

	}
	
	
	
	
	@RequestMapping("/mycollection")
	public String mycollection(HttpServletRequest request,Model model) {
		System.out.println("mycollection들어왔나요?================");

		//콜렉션 리스트를 불러오는 매소드 호출
		
/*		String userId = (String) session.getAttribute("userid");
		System.out.println("userID:" + userId);
		
		*/
		String userID=request.getParameter("userId");
		System.out.println("유저아이디:"+userID);
		
		ArrayList<Object> collectlist=new ArrayList<Object>();
		
		//collectlist=mypageService.getcolleclist(userID);
		
		
		//model.addAttribute("collist", collectlist);
		
		
		return "mycollection";
	}
	
	
	@RequestMapping("/mylog")
	public String mylog(Model model) {
		System.out.println("mylog들어왔나요?================");
		
		
		
		return "mylog";
	}
	
	
	
	@RequestMapping("/mywrite")
	public String mywrite(Model model) {
		System.out.println("mywrite들어왔나요?================");
		
		
		
		return "mywrite";
	}
	
	
	
	
	@RequestMapping("/mystatistics")
	public String mystatistics(HttpServletRequest request,Model model) {
		
		System.out.println("mystatistics들어왔나요?================");
		

		
		
		return "mystatistics";
	}
	
	
	@RequestMapping("/getbuy")
	@ResponseBody
	public String getbuy(HttpServletRequest request,Model model,@RequestBody Map<String,Object> map) throws Exception {
		
		System.out.println("getbuy들어왔나요?================");
		
		System.out.println(map.get("userId"));
		String userID=map.get("userId").toString();
		
		//1.구매 책 가져오는 서비스
		
/*		List<Map<String,Object>> getbuylist=new ArrayList<Map<String,Object>>();
		getbuylist=mypageService.getbuy(userID);*/
		
		List<Map<String,Object>> getbuylist=new ArrayList<Map<String,Object>>(mypageService.getbuy(userID));
		
/*		for (Map<String, Object> map2 : getbuylist) { //확인완료
			System.out.println("getbuylist내용물 꺼내보기:"+map2.toString());
		}
		*/
		
		//책 제목에서 형태소 분석.. 명사 추출 ->한줄 텍스트로 받아볼것임(완료) ->사용하기편하게 토큰으로 받아오기(완료)
		List<Token> strlist=new ArrayList<Token>();
		strlist=mypageService.komoran(getbuylist);
		
		System.out.println("strlist 갯수:"+strlist.size());
		
/*		for (Token token : strlist) {
			 System.out.format("(%2d, %2d) %s/%s\n", token.getBeginIndex(),
			 token.getEndIndex(), token.getMorph(), token.getPos()); 
		}
		*/

		
		//2.구매 책에서 키워드 뽑아내는 서비스 (3개 뽑기) 

		/*키워드는 ..도서나루 api에서밖에 없으니까 도서나루 호출..*/
		
		
		ArrayList<Object> keylist=new ArrayList<Object>();
		keylist=mypageService.getkeyword(getbuylist);
		
		
		for (Object string : keylist) {
			System.out.println(string);
/*				JSONObject str=(JSONObject)string;
				JSONObject str2=(JSONObject)str.get("word");
			//System.out.println("keylist꺼내기:"+string);
*/		}
		
		
		//리스트 내용 없애기
		
		keylist.clear();
		
		
		//3.구매 책에서 카테고리 뽑아내는 서비스(대 . 중 . 소)   -> 네이버 API는 무리.. 결과에서 카테고리 보여주는게 없으니.. 
		//이것도 도서정보나루 에서 카테고리 뽑아야겠다.
		
		ArrayList<String> catelist=new ArrayList<String>();
		catelist=mypageService.getcate(getbuylist);
		
		for (String string : catelist) {
			System.out.println("catelist꺼내기:"+catelist);
		}
		
		
		//4.코모란 형태소 분석 서비스 1~3번 결과에서 명사추출
		
		
		
		
		//5.KDC카테고리와 비교해서 카테고리와 매치시켜주고 그 매치된 카테고리 리스트에 담아서 가져옴	
		
		List<Token> telllist=new ArrayList<Token>();
		
		telllist=mypageService.tellcate(strlist);
		
		
		//6.중목 명사 카운트 올리는 서비스 
		
		
		

		
		//7. 그래프에 쓰일 JSON타입으로 값을 변환해주는 서비스
		
		
		
		
		
		//8. 7번 ->그래프로 표시
		
		strlist.clear();
		
		return "mystatistics";
	}
	
	
	@RequestMapping("/memewrite")
	public String memewrite(HttpServletRequest request,Model model) {
		System.out.println("memewrite들어왔나요?================");

		//글귀 디비에 인설트해주는 매소드 실행
		
		String userID=request.getParameter("userId"); //틀린이유 i는 대문자 d는 소문자로.. 해줘야 앞에서 name명 잘보기..
		String myline_title=request.getParameter("cTitle");
		String isbn=request.getParameter("cBook");
		String page=request.getParameter("cPage");
		int line=Integer.parseInt(request.getParameter("cLine"));
		String bookline=request.getParameter("cContent");
		String myline=request.getParameter("cMemo");
		
		System.out.println(userID+myline_title+isbn+page+line+bookline+myline);



		mypageService.addcolleclist(userID,myline_title,isbn,page,line,bookline,myline);
		
		

		
		return "mycollection";
	}
	
	
	@RequestMapping("/getmycollection")
	@ResponseBody
	public List<Map<String,Object>> getmycollection(@RequestBody Map<String,Object> map) {
	
		
		/*리스폰스 바디 안붙여주면 바디를 찾을수없다고 자바스크립트 리턴받는부분에서 에러남/ 해결.. 공부해야할덧*/
		System.out.println("getmycollection들어왔나요?================");
		System.out.println(map.get("userId"));
		String userID=map.get("userId").toString();
		
		
		return mypageService.getcolleclist(userID);

	}
	
	
	@RequestMapping("/collectmodify")
	public String collectmodify(HttpServletRequest request,Model model) {
		System.out.println("collectmodify들어왔나요?================");

		//글귀 디비에 업데이트해주는 매소드 실행
		
		String userID=request.getParameter("userId"); //틀린이유 i는 대문자 d는 소문자로.. 해줘야 앞에서 name명 잘보기..
		String isbn=request.getParameter("isbn");
		System.out.println("isbn:"+isbn);
		
		//바꿀것 다 가지고 와야함.. 그래야 없데이트해줌 파람대입해서

		//mypageService.modifycollect(userID,isbn);
		
		

		
		return "mycollection";
	}
	
	@RequestMapping("/collectdelete")
	public String collectdelete(HttpServletRequest request,Model model) {
		
		System.out.println("collectdelete들어왔나요?================");

		//글귀 디비에 삭제하는 매소드
		
		String userID=request.getParameter("userId"); //틀린이유 i는 대문자 d는 소문자로.. 해줘야 앞에서 name명 잘보기..
		String isbn=request.getParameter("isbn");
		System.out.println("isbn:"+isbn);

		
		mypageService.deletecollect(userID,isbn);
		
		

		
		return "mycollection";
	}
	
	
	
}
