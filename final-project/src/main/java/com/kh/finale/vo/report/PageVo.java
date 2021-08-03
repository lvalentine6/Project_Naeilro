package com.kh.finale.vo.report;

import lombok.Data;

@Data
public class PageVo {
	private int startRow, endRow, pageNo, pageSize;
	private int startBlock, endBlock, lastBlock;
	
	public PageVo getPageVariable(Integer pageNo1,Integer pageSize2,int count) {
		// 페이지 번호
		int pageNo;
		try {
			pageNo = pageNo1;
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
			pageSize = pageSize2;
			if (pageSize < 3) {
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
		int lastBlock = (count - 1) / pageSize + 1; 
		
		int blockSize = 10;
		int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		if (endBlock > lastBlock) endBlock = lastBlock;
		
		PageVo pageVo = new PageVo();
		
		pageVo.setPageNo(pageNo);
		pageVo.setPageSize(pageSize);
		pageVo.setStartRow(startRow);
		pageVo.setEndRow(endRow);
		pageVo.setStartBlock(startBlock);
		pageVo.setEndBlock(endBlock);
		pageVo.setLastBlock(lastBlock);
		
		return pageVo;
	}
}
