package com.kh.finale.entity.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class GroupsDto {
	private int groupNo;
	private int memberNo;
	private int plannerNo;
}
