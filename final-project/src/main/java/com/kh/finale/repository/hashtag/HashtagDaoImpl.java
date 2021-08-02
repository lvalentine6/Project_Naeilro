package com.kh.finale.repository.hashtag;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.hashtag.HashtagDto;
import com.kh.finale.vo.photostory.HashtagVo;

@Repository
public class HashtagDaoImpl implements HashtagDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(HashtagDto hashtagDto) {
		sqlSession.insert("hashtag.insert",hashtagDto);
	}
	
	@Override
	public void delete(int photostoryNo) {
		sqlSession.delete("hashtag.delete",photostoryNo);
	}
	
	@Override
	public List<HashtagVo> searchPreview(String keyword) {
		return sqlSession.selectList("hashtag.searchPreview",keyword);
	}
}
