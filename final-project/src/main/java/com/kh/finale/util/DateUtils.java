package com.kh.finale.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Date 관련 유틸 모음
 * @author swjk78
 */
public class DateUtils {

	// 작성날짜와 현재날짜의 차이를 얻는 메소드
	public static String getDifferenceInDate(Date inputDate) throws ParseException {
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
	
	// 현재 연도월일시분초를 반환하는 메소드
	public static String getDateString() {
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		String yearString = String.valueOf(year);
		
		int month = cal.get(Calendar.MONTH) + 1;
		String monthString = String.valueOf(month);
		if (month / 10 == 0) {
			monthString = "0" + monthString;
		}
		
		int day = cal.get(Calendar.DAY_OF_MONTH);
		String dayString = String.valueOf(day);
		if (day / 10 == 0) {
			dayString = "0" + dayString;
		}
		
		int hour = cal.get(Calendar.HOUR_OF_DAY);
		String hourString = String.valueOf(hour);
		if (hour / 10 == 0) {
			hourString = "0" + hourString;
		}
		
		int min = cal.get(Calendar.MINUTE);
		String minString = String.valueOf(min);
		if (min / 10 == 0) {
			minString = "0" + minString;
		}
		
		int sec = cal.get(Calendar.SECOND);
		String secString = String.valueOf(sec);
		if (sec / 10 == 0) {
			secString = "0" + secString;
		}
		
		return yearString + monthString + dayString + hourString + minString + secString;
	}
	
	// 입력받은 날짜에서 입력받은 일수를 더해서 반환하는 메소드
	public static Date plusDayToDate(Date date, int day) {
		// 입력받은 날짜를 Calendar로 변환
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		// 일수 더하기
		cal.add(Calendar.DAY_OF_MONTH, day);
		
		// Calendar를 Date로 변환
		date = cal.getTime();
		
		return date;
	}
	
	// 입력받은 날짜와 현재 시간을 비교하는 기능
	public static boolean compareWithSysdate(Date inputDate) throws Exception {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				
		String currentTime = simpleDateformat.format(System.currentTimeMillis());
		Date sysdate = simpleDateformat.parse(currentTime);

		// 입력 날짜가 현재 시간을 지났을 경우 true 반환
		return inputDate.before(sysdate);
	}
	
	// java.util.Date에서 java.sql.Date로 변환하는 메소드
	public static java.sql.Date formatToSqlDate(Date date) {
		return new java.sql.Date(date.getTime());
	}
}
