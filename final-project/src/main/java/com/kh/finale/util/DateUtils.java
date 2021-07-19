package com.kh.finale.util;

import java.text.ParseException;
import java.util.Date;

/**
 * Date 자료형을 다루는 클래스
 * @author swjk78
 */
public class DateUtils {

	// 작성날짜와 현재날짜의 차이를 얻는 메소드
	// (주의) sql.Date 타입으로 올 경우 시간/분/초 단위도 제대로 반환되는지 확인 필요
	public String getDifferenceInDate(Date inputDate) throws ParseException {
		long currentTime = System.currentTimeMillis();
		long compareTime = inputDate.getTime();
		long differenceTime = (currentTime - compareTime) / 1000;

		String msg = null;

		if (differenceTime < 60) {
			msg = "방금전";
		} else if ((differenceTime /= 60) < 60) {
			msg = differenceTime + "분전";
		} else if ((differenceTime /= 60) < 24) {
			msg = (differenceTime) + "시간전";
		} else if ((differenceTime /= 24) < 30) {
			msg = (differenceTime) + "일전";
		} else if ((differenceTime /= 30) < 12) {
			msg = (differenceTime) + "달전";
		} else {
			msg = (differenceTime /= 12) + "년전";
		}
		
		return msg;
	}
}
