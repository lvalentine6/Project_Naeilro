package com.kh.finale.photostory;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.repository.photostory.PhotostoryDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
/**
 * 포토스토리 작성/수정/삭제 테스트
 * @author swjk78
 */
public class WritePhotostoryTest {

	@Autowired
	private PhotostoryDao photostoryDao;
	
	// 포토스토리 작성
//	@Test
//	public void write() {
//		PhotostoryDto photostoryDto = PhotostoryDto.builder()
//				.photostoryNo(1)
//				.plannerNo(1)
//				.memberNo(1)
//				.photostoryContent("16")
//				.build();
//		photostoryDao.writePhotostory(photostoryDto);
//	}

	// 포토스토리 수정
//	@Test
//	public void edit() {
//		PhotostoryDto photostoryDto = PhotostoryDto.builder()
//				.photostoryNo(3)
//				.plannerNo(1)
//				.memberNo(1)
//				.photostoryContent("16")
//				.build();
//		photostoryDao.editPhotostory(photostoryDto);
//	}
	
	// 포토스토리 삭제
	@Test
	public void delete() {
		int photostoryNo = 3;
		photostoryDao.deletePhotostory(photostoryNo);
	}
}
