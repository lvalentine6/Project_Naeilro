package com.kh.finale.photostory;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.photostory.PhotostoryCommentListDto;
import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.repository.photostory.PhotostoryCommentListDao;
import com.kh.finale.repository.photostory.PhotostoryListDao;
import com.kh.finale.vo.photostory.PhotostoryListVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
/**
 * 포토스토리 리스트 테스트
 * @author swjk78
 */
public class PhotostoryListTest {

	@Autowired
	private PhotostoryListDao photostoryListDao;
	
	@Autowired
	private PhotostoryCommentListDao photostoryCommentListDao;
	
	@Test
	public void test() {
		PhotostoryListVO photostoryListVO = PhotostoryListVO.builder()
				.startRow(1)
				.endRow(10)
				.pageNo(1)
				.pageSize(10)
				.searchKeyword(null)
				.startBlock(1)
				.endBlock(1)
				.lastBlock(1)
				.build();
		List<PhotostoryListDto> photostoryList = photostoryListDao.list(photostoryListVO);
//		for (PhotostoryListDto photostoryListDto : photostoryList) {
//			log.debug("photostoryListDto = {}", photostoryListDto);
//		}
		
//		List<List<PhotostoryCommentListDto>> recentCommentList = new ArrayList<>();
//		for (int i = 0; i < photostoryList.size(); i++) {
//			List<PhotostoryCommentListDto> photostoryCommentList = 
//					photostoryCommentListDao.recentList(photostoryList.get(i).getPhotostoryNo());
//			recentCommentList.add(photostoryCommentList);
//		}
	}
}
