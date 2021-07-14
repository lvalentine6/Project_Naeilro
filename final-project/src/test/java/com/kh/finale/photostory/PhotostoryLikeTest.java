package com.kh.finale.photostory;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.photostory.PhotostoryLikeDto;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
/**
 * 포토스토리 좋아요 관련 테스트
 * @author swjk78
 */
public class PhotostoryLikeTest {

	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		PhotostoryLikeDto photostoryLikeDto = PhotostoryLikeDto.builder()
				.photostoryNo(1)
				.memberNo(1)
				.build();
//		sqlSession.insert("photostoryLike.insert", photostoryLikeDto);
		
//		sqlSession.delete("photostoryLike.delete", photostoryLikeDto);
		boolean check = sqlSession.selectOne("photostoryLike.check", photostoryLikeDto);
		assertTrue(check);
	}
}
