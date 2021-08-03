package com.kh.finale.service.plan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.PlaceDao;
import com.kh.finale.repository.plan.PlannerDao;
import com.kh.finale.repository.plan.ResultPlanDao;
import com.kh.finale.vo.plan.FindPhotoVO;
import com.kh.finale.vo.plan.PlanInsertServiceSubVO;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PlanServiceImpl implements PlanService {

	@Autowired
	private PlannerDao plannerDao;

	@Autowired
	private DailyDao dailyDao;

	@Autowired
	private PlaceDao placeDao;

	@Autowired
	private DailyplanDao dailyplanDao;

	@Autowired
	private ResultPlanDao resultPlanDao;

	@Override
	@Transactional
	public int planInsertService(PlanInsertServiceVO planInsertServiceVO) {

		// # 순서
		// 1. 통합계획표 등록 -> 2. 공유그룹 등록 -> 3. 하루계획표 등록 -> 4. 장소 등록 -> 5. 장소 계획 등록

		// 번호표
		int plannerNo = plannerDao.getSequnece();

		// 1. 통합계획표 등록 & 2. 공유그룹 등록
		if (planInsertServiceVO.getPlannerName() != null && planInsertServiceVO.getPlannerStartDate() != null
				&& planInsertServiceVO.getPlannerEndDate() != null) {
			// 통합계획표 번호 세팅
			planInsertServiceVO.setPlannerNo(plannerNo);

			// SQL 실행
			plannerDao.plannerInsert(planInsertServiceVO);
		}

		// 3. 하루계획표 등록 & 4. 장소 등록 & 5. 장소계획 등록

		// 하루계획표 번호를 발급받고 하루계획표 등록

		// 발급받은 하루계획표 번호를 장소계획 번호에 등록

		// 장소 등록

		// 장소계획 번호를 하루계획 번호에 등록

		// 장소계획 등록
		for (List<PlanInsertServiceSubVO> planList : planInsertServiceVO.getPlanList()) {
			for (PlanInsertServiceSubVO plan : planList) {
				// 번호 세팅
				int placeNo = placeDao.getSequence();
				int dailyNo = 0;

				if (plan.getDailyStayDate() != 0 || plan.getDailyOrder() != 0) { // 데이터가 0 0 이 같이 들어오고 있음
					dailyNo = dailyDao.getSequence();
					
					planInsertServiceVO.setDailyNo(dailyNo);
					planInsertServiceVO.setPlannerNo(plannerNo);
					planInsertServiceVO.setDailyStayDate(plan.getDailyStayDate());
					planInsertServiceVO.setDailyOrder(plan.getDailyOrder());
					log.debug("등록 dailyNo = {}", dailyNo);
					dailyDao.dailyInsert(planInsertServiceVO);
				}

				// 장소
				planInsertServiceVO.setPlaceNo(placeNo);
				planInsertServiceVO.setPlaceLatitude(plan.getPlaceLatitude());
				planInsertServiceVO.setPlaceLongitude(plan.getPlaceLongitude());
				planInsertServiceVO.setPlaceName(plan.getPlaceName()); // 변경 : 데이터 - 장소 이름
				planInsertServiceVO.setPlaceType(plan.getPlaceType());
				planInsertServiceVO.setPlaceRegion(plan.getPlaceRegion()); // 추가 : 데이터 - 지명

				if (planInsertServiceVO.getPlaceLatitude() != null || planInsertServiceVO.getPlaceLongitude() != null) {
					placeDao.placeInsert(planInsertServiceVO);
				}

				// 장소계획
				// 문제 : 하루계획 번호가 들어가지 않는다는 게 문제
				// 해결 : 하루계획 번호를 검사한 후, 제어하기

				planInsertServiceVO.setDailyplanPlaceOrder(plan.getDailyplanPlaceOrder());
				planInsertServiceVO.setDailyplanTransfer(plan.getDailyplanTransfer());

				// 확인
				log.info("하루계획 번호 : " + planInsertServiceVO.getDailyNo());
				log.info("장소 번호 : " + planInsertServiceVO.getPlaceNo());
				log.info("장소순서 : " + planInsertServiceVO.getDailyplanPlaceOrder());
				log.info("교통수단 : " + planInsertServiceVO.getDailyplanTransfer());
				log.info("문제 데이터 : " + plan.getDailyStayDate()); // 확인 : 2번째 인덱스부터 인식을 못하는 것 같다(..) -> 근데 해결은 됐는데 왜 됐는지
																	// 모르겠다 (...)

				if (planInsertServiceVO.getDailyplanTransfer() != null) {
					dailyplanDao.dailyplanInsert(planInsertServiceVO);
				}

			}
		}
		return plannerNo;
	}

	// 결과페이지 DB 조회
	@Override
	public List<ResultPlanVO> selectPlan(ResultPlanVO resultPlanVO) {
		return resultPlanDao.selectPlan(resultPlanVO);
	}

	// 포토스토리 이미지 조회
	@Override
	public FindPhotoVO selectPhoto(FindPhotoVO findPhotoVO) {
		return resultPlanDao.selectPhoto(findPhotoVO);
	}

	@Override
	public int planUpdateService(PlanInsertServiceVO planInsertServiceVO) { // 등록도 하고 삭제도 하고!
		int plannerNo = planInsertServiceVO.getPlannerNo();
		System.out.println("삭제에 필요한 번호 : " + plannerNo);

		int returnValue = plannerDao.getSequnece();
		System.out.println("컨트롤러로 전달할 번호 : " + returnValue);

		// 1. 통합계획표 등록 & 2. 공유그룹 등록
		if (planInsertServiceVO.getPlannerName() != null && planInsertServiceVO.getPlannerStartDate() != null
				&& planInsertServiceVO.getPlannerEndDate() != null) {
			// 통합계획표 번호 세팅
			planInsertServiceVO.setPlannerNo(returnValue);

			// SQL 실행
			plannerDao.plannerInsert(planInsertServiceVO);
		}

		// 장소계획 등록
		for (List<PlanInsertServiceSubVO> planList : planInsertServiceVO.getPlanList()) {
			for (PlanInsertServiceSubVO plan : planList) {
				// 번호 세팅
				int placeNo = placeDao.getSequence();
				int dailyNo = 0;

				if (plan.getDailyStayDate() != 0 || plan.getDailyOrder() != 0) { // 데이터가 0 0 이 같이 들어오고 있음
					dailyNo = dailyDao.getSequence();
					System.out.println("dailyNo=" + dailyNo);
					
					planInsertServiceVO.setDailyNo(dailyNo);
					planInsertServiceVO.setPlannerNo(returnValue);
					planInsertServiceVO.setDailyStayDate(plan.getDailyStayDate());
					planInsertServiceVO.setDailyOrder(plan.getDailyOrder());
					System.out.println("등록 데이터 확인 (장소) : " + planInsertServiceVO);
					dailyDao.dailyInsert(planInsertServiceVO);
				}

				// 장소
				planInsertServiceVO.setPlaceNo(placeNo);
				planInsertServiceVO.setPlaceLatitude(plan.getPlaceLatitude());
				planInsertServiceVO.setPlaceLongitude(plan.getPlaceLongitude());
				planInsertServiceVO.setPlaceName(plan.getPlaceName()); // 변경 : 데이터 - 장소 이름
				planInsertServiceVO.setPlaceType(plan.getPlaceType());
				planInsertServiceVO.setPlaceRegion(plan.getPlaceRegion()); // 추가 : 데이터 - 지명

				if (planInsertServiceVO.getPlaceLatitude() != null || planInsertServiceVO.getPlaceLongitude() != null) {
					placeDao.placeInsert(planInsertServiceVO);
					System.out.println("장소 등록 완료");
				}

				// 장소계획
				// 문제 : 하루계획 번호가 들어가지 않는다는 게 문제
				// 해결 : 하루계획 번호를 검사한 후, 제어하기

				planInsertServiceVO.setDailyplanPlaceOrder(plan.getDailyplanPlaceOrder());
				planInsertServiceVO.setDailyplanTransfer(plan.getDailyplanTransfer());

				// 확인
				log.info("하루계획 번호 : " + planInsertServiceVO.getDailyNo());
				log.info("장소 번호 : " + planInsertServiceVO.getPlaceNo());
				log.info("장소순서 : " + planInsertServiceVO.getDailyplanPlaceOrder());
				log.info("교통수단 : " + planInsertServiceVO.getDailyplanTransfer());
				log.info("문제 데이터 : " + plan.getDailyStayDate()); // 확인 : 2번째 인덱스부터 인식을 못하는 것 같다(..) -> 근데 해결은 됐는데 왜 됐는지
																	// 모르겠다 (...)

				if (planInsertServiceVO.getDailyplanTransfer() != null) {
					dailyplanDao.dailyplanInsert(planInsertServiceVO);
					System.out.println("등록 완료");
				}
				
			}
		}
		
		// #. 데이터 삭제
		plannerDao.plannerDelete(plannerNo);
		System.out.println("삭제 완료");
		
		return returnValue; // 신규 등록번호
	}

}
