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
 * 포토스토리 작성 테스트
 * @author swjk78
 */
public class WritePhotostoryTest {

	@Autowired
	private PhotostoryDao photostoryDao;
	
	@Test
	public void test() {
		PhotostoryDto photostoryDto = PhotostoryDto.builder()
				.photostoryNo(1)
				.plannerNo(1)
				.memberNo(1)
				.photostoryTitle("16")
				.photostoryContent("16")
				.build();
		photostoryDao.write(photostoryDto);
	}
}
