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
		
/*		확인완료
		for (Object string : keylist) { 
			System.out.println(string);
				JSONObject str=(JSONObject)string;
				JSONObject str2=(JSONObject)str.get("word");
			//System.out.println("keylist꺼내기:"+string);
		}
	*/	
		

		
		
		//3.구매 책에서 카테고리 뽑아내는 서비스(대 . 중 . 소)   -> 1.카테고리명 얻는거 가능하고 2.kdc번호 얻는거 가능
		//이것도 도서정보나루 에서 카테고리 뽑아야겠다.(네이버 API는 결과에서 카테고리정보 보여주는게 없음) 
		
		ArrayList<Integer> catelist=new ArrayList<Integer>();
		ArrayList<Integer> catelistSize=new ArrayList<Integer>();
		catelist=mypageService.getcate(getbuylist);
		
/*		for (Object string : catelist) { //확인완료
			System.out.println("catelist꺼내기:"+string);
		}
		*/


		
		//4.코모란 형태소 분석 서비스 1~3번 결과에서 "명사추출"
		
		
		
		//1번 구매한 책목록의 책 제목!! 에서 형태소 분석  
		//->위에서 형태소분석 완료함 -> 명사부분만 가져오면됌
		
		
		//2번 구매한 첵목록의 키워드에서 !! 형태소 분석
		//->키워드 자체가 명사로만 되어있어 분석안해도됨
		
		
		//3번 구매한 책목록의 카테고리에서!! 형태소 분석
		
		
		
		
		//(5.KDC카테고리와 비교해서 구매한 책의 카테고리와 조인으로 매치시켜보고 -> 그 매치된 카테고리 번호와 이름 리스트에 담아서 게시판형태로 정보 가져옴) -> 필요가 없을것같음 위에서 kdc번호 바로 추출가능	
		
/*		
		List<Token> telllist=new ArrayList<Token>();
		
		telllist=mypageService.tellcate(strlist);
		*/
		
		
		//6.중목 명사 카운트 올리는 서비스 
		//이퀄함수이용 . 위에서 결과 리턴받은  모든 명사 리스트 다 가지고들어가서 사용하기 ->DB에다가 카운트 결과 입력해주기
		
		
		/* 테이블정보	
		 * MYSTATISTICS
			kdc number,
			user_id varchar2(20),
			count number,
			weight number,
		 */
		
		
		mypageService.nounCount(strlist,keylist,catelist,userID);
		
		
		
		
		

		//7. 7번에서 얻은 DB에다가 카운트 받은 결과를  -> 그래프로 웹상에 표현해주기
		//springwebt_chart프로젝트 참고(막대,파이,도넛)
		//select 문으로 디비에서 테이블 가져오고 -> map으로 제이슨타입으로 받을수있게해주기 보내주기-> jsp페이지에서 자바스크립트로 받아오기
		
		mypageService.getmychart(userID);
		
		
		//작업다 끝나고 리스트 내용 비우기 -> 다음실행시 쌓이지않도록
		
		strlist.clear();
		keylist.clear();
		catelist.clear();
		catelistSize.clear();
		
		
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
