Project Naeilro
================

 ### 프로젝트 링크 : [Naeilro](https://bit.ly/3iNIjDn)



* 계정 정보
   * ID : rrrrr
   * PW : rrrrr
------------------------------

사용 기술
-----------------
>Language : Java(8), JavaScript(ES5), HTML5, CSS3      
>Framework : Spring (5), MyBatis      
>Library : jQuery, Bootstrap (4)        
>Server : Tomcat (9.0)        
>DBMS : Oracle (11g)        
>Tool : Git / GIthub, Maven (3.6.1)                

</br>

개발 기간 & 참여 인원  
-----------------
* 개발 기간 : 2021-07-09 ~ 2021-08-03        
* 팀 프로젝트 (팀장, 4명)

</br>


ERD 설계
-----------------
[![ERD.png](https://i.postimg.cc/vZgt05C7/ERD.png)](https://postimg.cc/68KZ34WT)

</br>

프로젝트 기능
-----------------
  * 회원 기능   
    * 아이디 찾기 / 비밀번호 찾기     
   
  * 여행 플래너
    * 플래너 CRUD
    * 플래너 상세보기
             
  * 포토스토리
    * 포토스토리 CRUD
    * 해시태그
    * 회원간 팔로우
    * 좋아요
    * 댓글 CRUD
    * 게시글, 댓글 신고 기능   
 
   * 마이페이지 
      * 플래너 / 포토스토리 연동
      * 비밀번호 변경
      * 회원탈퇴
      * 프로필 편집

   * 관리자 기능
     * 회원 관리 (정지)
     * 포토스토리 신고 처리
     * 댓글 신고 처리
     
 </br>
 
 핵심 기능
 -----------
<details>
<summary>회원 가입</summary>
<div markdown="1">

회원가입

</div>
</details>
 
<details>
<summary>로그인</summary>
<div markdown="1">



</div>
</details>

 <details>
<summary>비밀번호 관련 인증</summary>
<div markdown="1">

인증

</div>
</details>

<details>
<summary>마이페이지</summary>
<div markdown="1">

마이페이지

</div>
</details>
  </br>
  
  트러블 슈팅
 -----------
 <details>
<summary>마이페이지 이미지 관련</summary>
<div markdown="1">
 
 ### 원인

- 프로필 이미지 변경시memberProfile 테이블에 ProfileSaveName 데이터가 삭제되지 않고 추가 되기 때문에   
기존 사용했던 selectone으로 조회하지 못해 이미지 데이터를 찾아오는데 에러 발생

### 해결

- ProfileSaveName 의 마지막 데이터만 불러오게 SQL 구문 수정

```sql
SELECT * FROM(
    SELECT 
        * 
    FROM member_profile
    	ORDER BY ROWNUM DESC)
		WHERE ROWNUM = 1 and member_id = #{memberId}
```
 </div>
</details>
 
  <details>
<summary>정지된 회원 메시지 출력</summary>
<div markdown="1">
	
	정지된 회원 메시지 출력

```java
// 로그인 처리
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto, HttpSession httpSession,Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MemberDto check = memberDao.login(memberDto);
		
		// 정지 상태일 경우 처리
		if (check!=null && check.getMemberState().equals("정지")) {
			// 정지 해제 체크
			boolean blockCheck = memberBlockDao.checkBlock(check.getMemberNo());
			// 정지 기간이 지났을 경우
			if (blockCheck) {
				memberBlockService.unblock(check.getMemberNo());
			}
			// 정지 기간이 지나지 않았을 경우
			else {
				// 어느 페이지로 보낼지, 보낸 후 어떤 알림창을 띄울 것인지 미정 
				MemberBlockDto memberBlockDto = memberBlockDao.getBlockInfo(check.getMemberNo());
				System.out.println(memberBlockDto);
				
				// 정지회원 블럭페이지로 이동
//				model.addAttribute("block", memberBlockDto);
				model.addAttribute("msg", "관리자에 의해 계정이 정지 되었습니다.");
				model.addAttribute("reason", memberBlockDto.getBlockReason());
				model.addAttribute("blockEndDate", memberBlockDto.getBlockEndDate());
				model.addAttribute("url", request.getContextPath()); 
				return "member/block";
				}
			return "redirect:/";
		}
if (check != null) {
			httpSession.setAttribute("memberNo", check.getMemberNo());
			httpSession.setAttribute("memberId", check.getMemberId());
			httpSession.setAttribute("memberContextNick", check.getMemberNick());
			return "redirect:/";
		} else {
			return "redirect:login?error";
		}
	}
	
	// 정지회원 로그인 블럭 페이지
	@GetMapping("block")
	public String block() {
		return "redirect:block";
	}
```

```java
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정지 페이지</title>

<script>
	//정지회원 알림 메시지
	var reason1 = '${reason}';
	var message = '${msg}';
	var blockEndDate1 = '${blockEndDate}';
	var url1 = '${url}';
	
	alert(message + "\n정지 종료 일자 : " + blockEndDate1 + "\n정지 사유 : " + reason1);
	document.location.href = url1;
</script>
```
 </div>
</details>
	
 <details>
<summary>오토와이어드</summary>
<div markdown="1">
	
오토와이어드 하나만 등록하고 두줄 연속으로 씀

이래서 널포인터예외 뜸 

3시간 보냄. ㅎ

```java
@Autowired
	HttpSession httpSession;
	ResultPlanService resultPlanService;
```

계진님이 알려주셔서 한방에 해결...

```java
@Autowired
	HttpSession httpSession;
	
	@Autowired
	ResultPlanService resultPlanService;
```	
 </div>
</details>	
	
<details>
<summary>닉네임 중복 검사</summary>
<div markdown="1">
	
	## 프로필 편집시 현재 사용하고 있는 닉네임을 수정없이 다른 항목만 변경 하여 저장하면 기존의 방식으로는 사용하지 못함

### 기존 코드

memberController

```java
// 회원 가입 닉네임 중복체크
	@PostMapping("/nickCheck")
	@ResponseBody
	public boolean nickCheck(@ModelAttribute MemberVo memberVo) {
		System.out.println("닉네임 중복값 체크 : " + memberVo);
		boolean Nickresult = memberFindService.nickCheck(memberVo) > 0;
		System.out.println("닉네임 체크값 반환 : " + Nickresult);
		return Nickresult;
		}
```

기존 방식은 회원가입시 닉네임 중복 체크와 프로필 편집시 닉네임 처리를 하나의 메소드에서 처리함

```java
<!-- 닉네임 중복 체크 -->
<select id="jNickCheck" parameterType="MemberVo" resultType="int">
select count(*) from member where member_nick = #{memberNick}
</select>
```

원하는 조건

프로필 편집 시 현재 사용하는 닉네임 값을 그대로 입력해도 변경되도록 수정하고 싶음

프론트에서 true나 false값을 반환시키고 있었음 동일한 방식으로 반환하고 싶음

생각한 해결 방법

1. DB에서 검색할 때 if같은 조건을 줘서 결과값이 한번에 true / false 반환되게 하기

    마이바티스 매퍼 파일에서 sql문을 작성하려고 노력함

    ```java
    <!-- 닉네임 중복 체크 -->
    <select id="jNickCheck" parameterType="MemberVo" resultType="int">
    		select count(*) from member where member_nick = #{memberNick}
    	if (Vo로 넘어온 memberNick 값의 조회 결과가 null 이거나 
    			memberNick 조회 결과가 폼에서 입력한 값과 일치할 경우 0 반환
    			그게 아니면 1 반환 
    	</select>
    ```

 작성하다가 폼에서 입력한 값과 조회 결과 값이 같은지 비교 하려는 부분에서 sql 구문이 막힘

1. 매퍼파일을 두번 조회해서 둘의 값을 비교
    1. 세션에 변동 가능성이 있는 닉네임을 저장하지 않음 (프로필 편집시 변경할 수 있음)
    2. 회원가입시 닉네임 중복 검사와 프로필 편집시 닉네임 중복 검사를 분리하지 않으면 회원 가입시 회원 번호가 세션에 없어서 에러가 발생함
    3. 회원가입시 닉네임 중복 검사와 프로필 편집시 중복 검사를 분리하여 진행
        1.  회원가입 닉네임 중복 검사는 기존과 동일하게 진행
        2.  프로필 편집 닉네임 중복 검사는 새로운 메소드를 만들어 처리

        ```java
        // 회원가입 닉네임 중복체크
        	@PostMapping("/jNickCheck")
        	@ResponseBody
        	public boolean jNickCheck(@ModelAttribute MemberVo memberVo) {
        		System.out.println("닉네임 중복값 체크 : " + memberVo);
        		boolean Nickresult = memberFindService.jNickCheck(memberVo) > 0;
        		System.out.println("닉네임 체크값 반환 : " + Nickresult);
        		return Nickresult;
        	}

        	// 프로필 편집 닉네임 중복체크
        	@PostMapping("/pNickCheck")
        	@ResponseBody
        	public boolean pNickCheck(@ModelAttribute MemberVo memberVo, HttpSession httpSession) {
        		System.out.println("닉네임 중복값 체크 : " + memberVo); // 프론트에서 넘겨준 닉네임 값
        		MemberVo Nickresult = memberFindService.pNickCheck(memberVo); // DB 조회
        		System.out.println("닉네임 체크값 반환 : " + Nickresult); // 닉네임값이 있다면 반환
        		MemberDto memberDto = memberDao.findInfo((int) httpSession.getAttribute("memberNo")); // 로그인이 되어 있다는 가정하에 세션에서 회원번호 값을 가져와 닉네임 값을 조회 
        		boolean result = false;
        		if (ObjectUtils.isEmpty(Nickresult)) // 반환된 닉네임 값이 없다면 {
        			result = false;
        		} else // 반환된 닉네임 값이 있다면 {
        			if (Nickresult.getMemberNick().equals(memberDto.getMemberNick())) {
        				result = false; // 프론트로 false 반환
        			} else {
        				result = true; // 프론트로 true 반환
        			}
        		}
        		System.out.println(result);
        		return result;
        	}
        ```
	
</div>
</details>
	
<details>
<summary>대체 이미지</summary>
<div markdown="1">
	회원가입시 이미지를 선택하지 않고 가입하면 DB에 저장하지 않고 그냥 대체 이미지를 띄움

```html
<label for="memberProfile"> 
<img class='upload_img my-3 user_profile_lg user_profile' src="profileImage?memberId=${memberDto.memberId}"
onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'"> 
<input class="input_img" type="file" accept=".png, .jpg, .gif" id="memberProfile" name="memberProfile" style="display: none" disabled/>
</label>
```
</div>
</details>	
	
  느낀점
  ----------
  >[국비학원 파이널 프로젝트, 그리고 수료](https://bit.ly/2VwlLOs)
