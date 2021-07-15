package com.kh.finale.photostory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.photostory.PhotostoryCommentListDto;
import com.kh.finale.repository.photostory.PhotostoryCommentListDao;

import lombok.extern.slf4j.Slf4j;

/**
 * 포토스토리 댓글 관련 테스트
 * @author swjk78
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class PhotostoryCommentTest {

	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PhotostoryCommentListDao photostoryCommentListDao;
	
	// 댓글 작성 테스트
//	@Test
//	public void write() {
//		PhotostoryCommentDto photostoryCommentDto = PhotostoryCommentDto.builder()
//				.photostoryCommentNo(2)
//				.photostoryNo(1)
//				.memberNo(1)
//				.photostoryCommentContent("test2")
//				.build();
//		sqlSession.insert("photostoryComment.insert", photostoryCommentDto);
//	}

	// 댓글 수정 테스트
//	@Test
//	public void edit() {
//		PhotostoryCommentDto photostoryCommentDto = PhotostoryCommentDto.builder()
//				.photostoryCommentNo(2)
//				.photostoryNo(1)
//				.memberNo(1)
//				.photostoryCommentContent("test2")
//				.build();
//		sqlSession.update("photostoryComment.update", photostoryCommentDto);
//	}

	// 댓글 삭제 테스트
//	@Test
//	public void test() {
//		PhotostoryCommentDto photostoryCommentDto = PhotostoryCommentDto.builder()
//				.photostoryCommentNo(2)
//				.memberNo(1)
//				.build();
//		sqlSession.delete("photostoryComment.delete", photostoryCommentDto);
//	}
	
	// 댓글 리스트 조회 테스트
	@Test
	public void list() {
		int photostoryNo = 22;
		List<PhotostoryCommentListDto> list = photostoryCommentListDao.list(photostoryNo);
		
		for (PhotostoryCommentListDto photostoryCommentListDto : list) {
			log.debug("댓글: ", photostoryCommentListDto.toString());
		}
	}

	// 최신 댓글 리스트 조회 테스트
//	@Test
//	public void recentList() {
//		int photostoryNo = 22;
//		List<PhotostoryCommentListDto> list = photostoryCommentListDao.recentList(photostoryNo);
//		
//		for (PhotostoryCommentListDto photostoryCommentListDto : list) {
//			log.debug("댓글: ", photostoryCommentListDto.getPhotostoryCommentContent());
//		}
//	}
}
