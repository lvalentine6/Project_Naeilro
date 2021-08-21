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
>Dbms : Oracle (11g)        
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
* __담당한 부분은 굵게 표시__
	
  * __회원 기능__   
    * __회원 가입__ 
    * __아이디 찾기 / 비밀번호 찾기__
    * __마이페이지__ 
		* __비밀번호 변경__
		* __회원탈퇴__
		* __프로필 편집__
		* 플래너 / 포토스토리 연동     
	
	
	
			<details>
			<summary>회원 기능 Flow</summary>
			<div markdown="1">
			<br>

			[![2021-08-03-161927.png](https://i.postimg.cc/43ydhTWT/2021-08-03-161927.png)](https://postimg.cc/sBFytbFn)

			</div>
			</details>
		
		
     
  * __여행 플래너__
    * 플래너 CRUD
    * __플래너 상세보기__
     
  * 포토스토리
    * 포토스토리 CRUD
    * 해시태그
    * 회원간 팔로우
    * 좋아요
    * 댓글 CRUD
    * 게시글, 댓글 신고 기능  
    
  * 관리자 기능
     * 회원 관리 (정지)
     * 포토스토리 신고 처리
     * 댓글 신고 처리
     
 </br>
  
 트러블 슈팅
 -----------
 <details>
<summary>닉네임 중복 검사</summary>
<div markdown="1">
	
### 1. 문제 상황
* 마이페이지 프로필 편집시 현재 사용하고 있는 닉네임을 그대로 사용하려고 하면    
닉네임 중복체크 조건 때문에 반드시 기존 닉네임과는 다르게 변경해야함

### 2. 기존 코드
* 기존 코드는 회원가입시 닉네임 중복 체크와 프로필 편집시 닉네임 처리를 하나의 메소드에서 처리함

```java
memberController
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

```java
<!-- 닉네임 중복 체크 -->
<select id="jNickCheck" parameterType="MemberVo" resultType="int">
select count(*) from member where member_nick = #{memberNick}
</select>
```

### 3. 원하는 조건

* 프로필 편집 시 현재 사용하는 닉네임 값을 그대로 입력해도 변경되도록 수정하고 싶음

* 프론트에서 true나 false값을 반환 시키고 있어 동일한 방식으로 반환하고 싶음

### 4. 해결 방법

#### 4-1. DB에서 검색할 때 if같은 조건을 줘서 결과값이 한번에 true / false 반환되게 하기 (실패)
* 마이바티스 매퍼 파일에서 sql문 작성 시도
* 폼에서 입력한 값과 조회 결과 값이 같은지 비교 하는 sql 구문 작성에서 막힘
	

    ```
    <!-- 닉네임 중복 체크 -->
    <select id="jNickCheck" parameterType="MemberVo" resultType="int">
    		select count(*) from member where member_nick = #{memberNick}
    	if (Vo로 넘어온 memberNick 값의 조회 결과가 null 이거나 
    			memberNick 조회 결과가 폼에서 입력한 값과 일치할 경우 0 반환
    			그게 아니면 1 반환 
    	</select>
    ```

#### 4-2. 매퍼파일을 두번 조회해서 둘의 값을 비교 (성공)
	
* 세션에 변동 가능성이 있는 닉네임을 저장하지 않음 (프로필 편집시 변경할 수 있음)
* 회원가입시 닉네임 중복 검사와 프로필 편집시 닉네임 중복 검사를 분리하지 않으면 회원 가입시   
	회원 번호가 세션에 없어서 에러가 발생함
	
	
* 회원가입시 닉네임 중복 검사와 프로필 편집시 중복 검사를 분리하여 진행
	*  회원가입 닉네임 중복 검사는 기존과 동일하게 진행
	*  프로필 편집 닉네임 중복 검사는 새로운 메소드를 만들어 처리

### 5. 수정 코드
```
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
<summary>마이페이지 프로필 이미지</summary>
<div markdown="1">
 
### 원인

- 프로필 이미지 변경시 memberProfile 테이블에 ProfileSaveName 데이터가 삭제되지 않고 추가 되기 때문에   
기존 사용했던 selectone으로 조회하지 못해 이미지 데이터를 찾아오는데 에러 발생
	

### 해결

- ProfileSaveName 의 마지막 데이터만 불러오게 SQL 구문 수정

#### 기존 코드
```sql
<select id="find" parameterType="String" resultType="MemberProfileDto">
	select * from member_profile where member_id = #{memberId}
</select>
```
	
#### 수정 코드
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
<summary>오토와이어드</summary>
<div markdown="1">

### 원인
* 오토와이어드 하나만 등록하고 두줄 연속으로 사용하여 널포인터 예외 발생

#### 기존 코드    
	
```java
@Autowired
	HttpSession httpSession;
	ResultPlanService resultPlanService;
```
	
#### 수정 코드   
	
```java
	@Autowired
	HttpSession httpSession;
	
	@Autowired
	ResultPlanService resultPlanService;
```	
 </div>
</details>	
	
<details>
<summary>대체 이미지 처리</summary>
<div markdown="1">
<br>	
	
* 회원가입시 이미지를 선택하지 않고 가입하면 이미지를 DB에 저장하지 않고 onerror를 이용해서 대체 이미지를 출력함

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
