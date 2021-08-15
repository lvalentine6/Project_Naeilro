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
* 팀 프로젝트 (4명)

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
	
	
  느낀점
  ----------
  >[국비학원 파이널 프로젝트, 그리고 수료](https://bit.ly/2VwlLOs)
