package com.kh.finale.util;

/**
 * 배열 관련 유틸 모음
 * @author swjk78
 */
public class ArrayUtils {
	// 배열에 int값이 포함되어 있는지 확인하는 기능
	public static boolean contains(int[] arr, int num) {
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] == num) return true;
		}
		return false;
	}
}
