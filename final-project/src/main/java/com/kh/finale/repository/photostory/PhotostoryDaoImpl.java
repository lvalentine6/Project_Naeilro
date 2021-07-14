package com.kh.finale.repository.photostory;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.util.ListParameter;

@Repository
public class PhotostoryDaoImpl implements PhotostoryDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 포토스토리 페이지 관련 파라미터 계산 기능
	@Override
	public ListParameter getPageVariable(ListParameter listParameter) {
		// 페이지 번호
		int pageNo;
		try {
			pageNo = listParameter.getPageNo();
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
			pageSize = listParameter.getPageSize();
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
		int photostoryCount = getPhotostoryCount(listParameter);
		int lastBlock = (photostoryCount - 1) / pageSize + 1; 
		
		int blockSize = 10;
		int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		if (endBlock > lastBlock) endBlock = lastBlock;
		
		listParameter.setPageNo(pageNo);
		listParameter.setPageSize(pageSize);
		listParameter.setStartRow(startRow);
		listParameter.setEndRow(endRow);
		listParameter.setStartBlock(startBlock);
		listParameter.setEndBlock(endBlock);
		listParameter.setLastBlock(lastBlock);
		
		return listParameter;
	}
	
	// 총 포토스토리 개수 획득 기능
	@Override
	public int getPhotostoryCount(ListParameter listParameter) {
		return sqlSession.selectOne("photostory.getPhotostoryCount");
	}

	// 포토스토리 작성 기능
	@Override
	public void writePhotostory(PhotostoryDto photostoryDto) {
		sqlSession.insert("photostory.insert", photostoryDto);
	}

	// 포토스토리 좋아요 수 갱신 기능
	@Override
	public void refreshPhotostoryLikeCount(int photostoryNo) {
		sqlSession.update("photostory.refreshPhotostoryLikeCount", photostoryNo);
	}

	// 포토스토리 좋아요 수 조회 기능
	@Override
	public int getPhotostoryLikeCount(int photostoryNo) {
		return sqlSession.selectOne("photostory.getPhotostoryLikeCount", photostoryNo);
	}

	// 포토스토리 댓글 수 갱신 기능
	@Override
	public void refreshPhotostoryCommentCount(int photostoryNo) {
		sqlSession.update("photostory.refreshPhotostoryCommentCount", photostoryNo);
	}

	// 포토스토리 댓글 수 조회 기능
	@Override
	public int getPhotostoryCommentCount(int photostoryNo) {
		return sqlSession.selectOne("photostory.getPhotostoryCommentCount", photostoryNo);
	}
}
