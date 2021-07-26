package com.kh.finale.repository.member;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.vo.member.MemberVo;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	SqlSession sqlSession;
	
	// 회원가입 기능
	@Override
	public void join(MemberDto memberDto) {
		sqlSession.insert("member.join", memberDto);
	}

	@Override
	public MemberDto login(MemberDto memberDto) {
		return sqlSession.selectOne("member.login", memberDto);
	}

	// 회원정보 조회(회원번호로)
	@Override
	public MemberDto findInfo(int memberNo) {
		return sqlSession.selectOne("member.findInfo", memberNo);
	}
	
	@Override
	public MemberDto findId(MemberDto memberDto) {
		return sqlSession.selectOne("member.findId", memberDto);
	}

	@Override
	public MemberVo findPw(MemberVo memberVo) {
		return sqlSession.selectOne("member.findPw", memberVo);
	}
	
	// 회원 정보 조회(닉네임으로)
	@Override
	public MemberDto findWithNick(String memberNick) {
		return sqlSession.selectOne("member.findWithNick", memberNick);
	}

	@Override
	public void authInsert(MemberAuthDto memberAuthDto) {
		sqlSession.insert("member.authInsert", memberAuthDto);
		
	}

	@Override
	public Map<String,Object> resultAuth(MemberAuthDto memberAuthDto) {
		return sqlSession.selectOne("member.resultAuth", memberAuthDto);
	}

	@Override
	public MemberAuthDto checkAuthEmail(MemberAuthDto memberAuthDto) {
		return sqlSession.selectOne("member.checkAuthEmail", memberAuthDto);
	}

	@Override
	public MemberAuthDto selectId(MemberAuthDto memberAuthDto) {
		return sqlSession.selectOne("member.selectId", memberAuthDto);
	}

	@Override
	public void updatePw(MemberDto memberDto) {
		sqlSession.update("member.updatePw", memberDto);
	}

	@Override
	public void editProfile(MemberVo memberVo) {
		sqlSession.update("member.editProfile", memberVo);
	}

	@Override
	public int idCheck(MemberVo memberVo) {
		return sqlSession.selectOne("member.idCheck", memberVo);
	}
	
	// 프로필 편집 닉네임 중복값 검사
	@Override
	public MemberVo pNickCheck(MemberVo memberVo) {
		return sqlSession.selectOne("member.pNickCheck", memberVo);
	}

	@Override
	public void exit(MemberVo memberVo) {
		sqlSession.delete("member.exit", memberVo);
	}
	
	// 회원 가입 닉네임 중복값 검사
	@Override
	public int jNickCheck(MemberVo memberVo) {
		return sqlSession.selectOne("member.jNickCheck", memberVo);
	}

	// 회원 정지
	@Override
	public void block(int memberNo) {
		sqlSession.update("member.block", memberNo);
	}
	
	// 회원 정지 해제
	@Override
	public void unblock(int memberNo) {
		sqlSession.update("member.unblock", memberNo);
	}
}
