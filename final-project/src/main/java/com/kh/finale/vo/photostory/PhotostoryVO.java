package com.kh.finale.vo.photostory;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
/**
 * 포토스토리 리스트 나열을 위한 파라미터 모음
 * @author swjk78
 */
public class PhotostoryVO {
	private int startRow, endRow, pageNo, pageSize;
	private String searchType, searchKeyword;
	private int startBlock, endBlock, lastBlock;
}
