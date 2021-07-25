package com.kh.finale.entity.block;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 회원 정지 기능에 필요한 변수를 저장하는 Dto
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MemberBlockDto {
	private int blockNo, memberNo;
	private Date blockStartDate;
	private int blockPeriod;
	private String blockContent, blockReason;
}
