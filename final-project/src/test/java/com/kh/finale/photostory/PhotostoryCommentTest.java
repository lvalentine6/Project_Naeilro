package com.kh.finale.photostory;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.photostory.PhotostoryCommentDto;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
/**
 * 포토스토리 댓글 관련 테스트
 * @author swjk78
 */
public class PhotostoryCommentTest {

	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		PhotostoryCommentDto photostoryCommentDto = PhotostoryCommentDto.builder()
				.photostoryCommentNo(2)
//				.photostoryNo(1)
				.memberNo(1)
//				.photostoryCommentContent("test2")
				.build();
//		sqlSession.insert("photostoryComment.insert", photostoryCommentDto);
//		sqlSession.update("photostoryComment.update", photostoryCommentDto);
		sqlSession.delete("photostoryComment.delete", photostoryCommentDto);
	}
}
