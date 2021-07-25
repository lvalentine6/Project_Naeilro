package com.kh.finale.repository.block;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.block.MemberBlockDto;

@Repository
public class MemberBlockDaoImpl implements MemberBlockDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 회원 정지 정보 등록 기능
	@Override
	public void insertBlockInfo(MemberBlockDto memberBlockDto) {
		sqlSession.insert("memberBlock.insert", memberBlockDto);
	}

	// 회원 정지 정보 삭제 기능
	@Override
	public void deleteBlockInfo(int memberNo) {
		sqlSession.delete("memberBlock.delete", memberNo);
	}

	// 정지 정보 조회 기능
	@Override
	public MemberBlockDto getBlockInfo(int memberNo) {
		return sqlSession.selectOne("memberBlock.select", memberNo);
	}
}
