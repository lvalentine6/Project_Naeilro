package com.kh.finale.repository.photostory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.vo.photostory.PhotostoryVO;

@Repository
public class PhotostoryDaoImpl implements PhotostoryDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 포토스토리 페이지 관련 변수 계산 기능
	@Override
	public PhotostoryVO getPageVariable(PhotostoryVO photostoryVO) {
		// 페이지 번호
		int pageNo;
		try {
			pageNo = photostoryVO.getPageNo();
			if (pageNo < 1) {
				throw new Exception();
			}
		}
		catch(Exception e) {
			pageNo = 1;
		}
		
		// 한 페이지에 보일 글의 개수
		int pageSize;
		try {
			pageSize = photostoryVO.getPageSize();
			if (pageSize < 10) {
				throw new Exception();
			}
		}
		catch (Exception e) {
			pageSize = 10;
		}
		
		// 포토스토리 리스트 범위
		int startRow = pageNo * pageSize - (pageSize - 1);
		int endRow = pageNo * pageSize;
		
		// 페이지네이션 영역 계산
		int photostoryCount = getPhotostoryCount(photostoryVO);
		int lastBlock = (photostoryCount - 1) / pageSize + 1; 
		
		int blockSize = 10;
		int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		if (endBlock > lastBlock) endBlock = lastBlock;
		
		photostoryVO.setPageNo(pageNo);
		photostoryVO.setPageSize(pageSize);
		photostoryVO.setStartRow(startRow);
		photostoryVO.setEndRow(endRow);
		photostoryVO.setStartBlock(startBlock);
		photostoryVO.setEndBlock(endBlock);
		photostoryVO.setLastBlock(lastBlock);
		
		return photostoryVO;
	}
	
	// 총 포토스토리 개수 획득 기능
	@Override
	public int getPhotostoryCount(PhotostoryVO photostoryVO) {
		int photostoryCount = sqlSession.selectOne("photostory.photostoryCount");
		
		return photostoryCount;
	}
	
	// 포토스토리 리스트 기능
	@Override
	public List<PhotostoryDto> list(PhotostoryVO photostoryVO) {
		List<PhotostoryDto> list = sqlSession.selectList("photostory.list", photostoryVO);
		
		return list;
	}

	// 포토스토리 작성 기능
	@Override
	public void write(PhotostoryDto photostoryDto) {
		sqlSession.insert("photostory.write", photostoryDto);
	}

	
}
