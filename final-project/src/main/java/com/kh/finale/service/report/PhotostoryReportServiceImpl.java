package com.kh.finale.service.report;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.report.PhotostoryReportDto;
import com.kh.finale.repository.report.PhotostoryReportDao;
import com.kh.finale.vo.report.PageVo;
import com.kh.finale.vo.report.ReportVo;

@Service
public class PhotostoryReportServiceImpl implements PhotostoryReportService{

	@Autowired
	PhotostoryReportDao photostoryReportDao;
	
	@Override
	public void pReportInsert(PhotostoryReportDto photostoryReportDto) {
		photostoryReportDao.pReportInsert(photostoryReportDto);
	}
	
	@Override
	public List<ReportVo> getList(int pageNo){
		PageVo pageVo = new PageVo();
		pageVo=pageVo.getPageVariable(pageNo, 10,photostoryReportDao.getCount());
		return photostoryReportDao.getList(pageVo);
	}
	
	@Override
	public void delete(int reportNo) {
		photostoryReportDao.delete(reportNo);
	}
	
	@Override
	public void confirm(int reportNo) {
		photostoryReportDao.confirm(reportNo);
	}
}
