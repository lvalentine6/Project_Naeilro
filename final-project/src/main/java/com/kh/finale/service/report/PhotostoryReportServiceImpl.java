package com.kh.finale.service.report;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.report.PhotostoryReportDto;
import com.kh.finale.repository.report.PhotostoryReportDao;

@Service
public class PhotostoryReportServiceImpl implements PhotostoryReportService{

	@Autowired
	PhotostoryReportDao photostoryReportDao;
	
	@Override
	public void pReportInsert(PhotostoryReportDto photostoryReportDto) {
		photostoryReportDao.pReportInsert(photostoryReportDto);
	}

}
