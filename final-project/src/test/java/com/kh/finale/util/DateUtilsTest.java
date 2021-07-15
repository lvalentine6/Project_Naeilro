package com.kh.finale.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;

import lombok.extern.slf4j.Slf4j;

/**
 * 작성 시간과 현재 시간을 비교해 현재 시간으로부터 시간이 얼마나 지났는지 반환하는 테스트 
 * @author swjk78
 */
@Slf4j
public class DateUtilsTest {

	@Test
	public void test() throws ParseException {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		Date inputDate = simpleDateformat.parse("2021-07-13 23:23:30");

		long currentTime = System.currentTimeMillis();
		long compareTime = inputDate.getTime();
		long differenceTime = (currentTime - compareTime) / 1000;

		String msg = null;

		if (differenceTime < 60) {
			// sec
			msg = differenceTime + "초전";
		} else if ((differenceTime /= 60) < 60) {
			// min
			msg = differenceTime + "분전";
		} else if ((differenceTime /= 60) < 24) {
			// hour
			msg = (differenceTime) + "시간전";
		} else if ((differenceTime /= 24) < 30) {
			// day
			msg = (differenceTime) + "일전";
		} else if ((differenceTime /= 30) < 12) {
			// month
			msg = (differenceTime) + "달전";
		} else {
			// year
			msg = (differenceTime /= 12) + "년전";
		}

		log.debug("msg = {}", msg);
	}
}