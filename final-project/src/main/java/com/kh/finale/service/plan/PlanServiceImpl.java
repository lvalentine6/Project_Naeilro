package com.kh.finale.service.plan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.finale.entity.plan.PlanListDto;
import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.PlaceDao;
import com.kh.finale.repository.plan.PlanListDao;
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
	public int planInsertService(PlanInsertServiceVO planInsertServiceVO) {
		
		// # 순서
		// 1. 통합계획표 등록 -> 2. 공유그룹 등록 -> 3. 하루계획표 등록 -> 4. 장소 등록 -> 5. 장소 계획 등록
		
		// 번호표
		int plannerNo = plannerDao.getSequnece();
		
		
		// 1. 통합계획표 등록 & 2. 공유그룹 등록
		if(planInsertServiceVO.getPlannerName() != null && planInsertServiceVO.getPlannerStartDate() != null && planInsertServiceVO.getPlannerEndDate() != null) {
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
		for(List<PlanInsertServiceSubVO> planList : planInsertServiceVO.getPlanList()) {
			for(PlanInsertServiceSubVO plan : planList) {
				// 번호 세팅
				int placeNo = placeDao.getSequence();
				int dailyNo = 0;
				
				if(plan.getDailyStayDate() != 0 || plan.getDailyOrder() != 0) { // 데이터가 0 0 이 같이 들어오고 있음
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
				planInsertServiceVO.setPlaceName(plan.getPlaceName());
				planInsertServiceVO.setPlaceType(plan.getPlaceType());
				
				if(planInsertServiceVO.getPlaceLatitude() != null || planInsertServiceVO.getPlaceLongitude() != null) {
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
				log.info("문제 데이터 : " + plan.getDailyStayDate()); // 확인 : 2번째 인덱스부터 인식을 못하는 것 같다(..) -> 근데 해결은 됐는데 왜 됐는지 모르겠다 (...)
				
				if(planInsertServiceVO.getDailyplanTransfer() != null) {
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
	
	@Autowired
	private PlanListDao planListDao;
	
	// 계획표 수정
	@Override
	@Transactional
	public void planUpdateService(PlanInsertServiceVO planInsertServiceVO) {
		// 통합 계획표 번호
		int plannerNo = planInsertServiceVO.getPlannerNo();
		
		// 통합 계획표 수정
		plannerDao.plannerUpdate(planInsertServiceVO);

		// 기존 하루 계획표 개수
		int existDailyCount = dailyDao.getDailyCount(planInsertServiceVO.getPlannerNo());
		log.debug("기존 하루 계획표 개수 = {}", existDailyCount);
		
		// 입력된 하루 계획표 개수
		int inputDailyCount = planInsertServiceVO.getPlanList().size();
		log.debug("입력된 하루 계획표 개수 = {}", inputDailyCount);

		// 기존 계획표 정보
		List<PlanListDto> existPlanList = planListDao.getPlanList(plannerNo);
		
		// 장소 번호를 위한 인덱스
		int placeNoIndex = 0;
		
		// 입력된 하루 계획표 개수 <= 기존 하루 계획표 개수
		if (inputDailyCount <= existDailyCount) {
			log.debug("입력된 하루 계획표 개수 <= 기존 하루 계획표 개수");
			// 입력된 하루 계획표 개수만큼 반복
			for (int i = 0; i < inputDailyCount; i++) {
				log.debug("i = {}", i);
				
				// 기존 하루 계획표 수정
				log.debug("기존 하루 계획표 수정");
				int dailyNo = dailyDao.getDailyList(plannerNo).get(i).getDailyNo();
				
				log.debug("dailyNo = {}", dailyNo);
				int dailyStayDate = planInsertServiceVO.getPlanList().get(0).get(0).getDailyStayDate();
				planInsertServiceVO.setDailyNo(dailyNo);
				planInsertServiceVO.setDailyStayDate(dailyStayDate);
				
				dailyDao.dailyUpdate(planInsertServiceVO);
				
				log.debug("{}일차 하루 계획표", i + 1);
				
				// 기존 장소 계획 개수
				int existDailyplanCount = dailyplanDao.getDailyplanCount(dailyNo);
				log.debug("기존 장소 계획 개수 = {}", existDailyplanCount);
				
				// 입력된 장소 계획 개수
				int inputDailyplanCount = planInsertServiceVO.getPlanList().get(i).size();
				log.debug("입력된 장소 계획 개수 = {}", inputDailyplanCount);
				
				// 장소 번호 리스트
				List<Integer> placeNoList = null;

				// 입력된 장소 계획 개수 <= 기존 장소 계획 개수
				if (inputDailyplanCount <= existDailyplanCount) {
					log.debug("입력된 장소 계획 개수 <= 기존 장소 계획 개수");
					
					// 입력된 장소 계획 개수만큼 반복
					log.debug("existPlanList={}", existPlanList);
					for (int j = 0; j < inputDailyplanCount; j++) {
						log.debug("{}일차 {}번째 장소 계획", i + 1, j + 1);
						PlanInsertServiceSubVO planList = planInsertServiceVO.getPlanList().get(i).get(j);
						
						// 기존 장소 수정
						log.debug("기존 장소 수정");
						log.debug("placeNo={}", existPlanList.get(placeNoIndex).getPlaceNo());
						planInsertServiceVO.setPlaceNo(existPlanList.get(placeNoIndex).getPlaceNo());
						planInsertServiceVO.setPlaceLatitude(planList.getPlaceLatitude());
						planInsertServiceVO.setPlaceLongitude(planList.getPlaceLongitude());
						planInsertServiceVO.setPlaceName(planList.getPlaceName());
						planInsertServiceVO.setPlaceType(planList.getPlaceType());
	
						placeDao.placeUpdate(planInsertServiceVO);
						placeNoIndex++;
	
						// 기존 장소 계획 수정
						log.debug("기존 장소 계획 수정");
						planInsertServiceVO.setDailyplanTransfer(planList.getDailyplanTransfer());
						
						dailyplanDao.dailyplanUpdate(planInsertServiceVO);
					}
					
					// 잔여 장소 삭제
					if (inputDailyplanCount < existDailyplanCount) {
						log.debug("잔여 장소 삭제");
						for (int j = inputDailyplanCount; j < existDailyplanCount; j++) {
							placeNoList = planListDao.getPlaceNoList(dailyNo);
							placeDao.placeDelete(placeNoList.get(placeNoList.size() - 1));
							placeNoList.remove(placeNoList.size() - 1);
						}
					}
				}
				// 입력된 장소 계획 개수 > 기존 장소 계획 개수
				else {
					log.debug("입력된 장소 계획 개수 > 기존 장소 계획 개수");
					placeNoIndex = 0;
					
					// 입력된 하루 계획표 개수만큼 반복
					for (int k = 0; k < inputDailyCount; k++) {
						dailyNo = dailyDao.getDailyList(plannerNo).get(k).getDailyNo();
						log.debug("dailyNo = {}", dailyNo);
						
						placeNoList = planListDao.getPlaceNoList(dailyNo);
						inputDailyplanCount = planInsertServiceVO.getPlanList().get(k).size();
						for (int j = 0; j < inputDailyplanCount; j++) {
							log.debug("{}일차 {}번째 장소 계획", k + 1, j + 1);
							
							PlanInsertServiceSubVO planList = planInsertServiceVO.getPlanList().get(k).get(j);
							
							planInsertServiceVO.setPlaceLatitude(planList.getPlaceLatitude());
							planInsertServiceVO.setPlaceLongitude(planList.getPlaceLongitude());
							planInsertServiceVO.setPlaceName(planList.getPlaceName());
							planInsertServiceVO.setPlaceType(planList.getPlaceType());

							if (j < existDailyplanCount) {
								// 기존 장소 수정
								log.debug("기존 장소 수정");
								log.debug("placeNo={}", placeNoList.get(j));
								planInsertServiceVO.setPlaceNo(placeNoList.get(j));

								placeDao.placeUpdate(planInsertServiceVO);
								placeNoIndex++;
								
								// 기존 장소 계획 수정
								log.debug("기존 장소 계획 수정");
								planInsertServiceVO.setDailyplanTransfer(planList.getDailyplanTransfer());
								
								dailyplanDao.dailyplanUpdate(planInsertServiceVO);
							}
							else {
								// 추가 장소 등록
								log.debug("추가 장소 등록");
								int placeNo = placeDao.getSequence();
								planInsertServiceVO.setPlaceNo(placeNo);
								
								placeDao.placeInsert(planInsertServiceVO);
								
								// 추가 장소 계획 등록
								log.debug("추가 장소 계획 등록");
								planInsertServiceVO.setDailyplanPlaceOrder(planList.getDailyplanPlaceOrder());
								planInsertServiceVO.setDailyplanTransfer(planList.getDailyplanTransfer());
								
								dailyplanDao.dailyplanInsert(planInsertServiceVO);
							}
						}
					}
				}
			}
			// 잔여 기존 계획표 삭제
			log.debug("잔여 기존 계획표 삭제");
			if (inputDailyCount < existDailyCount) {
				for (int i = existDailyCount - 1; i >= inputDailyCount; i--) {
					PlanListDto planListDto = existPlanList.get(existPlanList.size() - 1);
					int dailyNo = planListDto.getDailyNo();

					List<Integer> placeNoList = planListDao.getPlaceNoList(dailyNo);
					log.debug("placeNoList={}", placeNoList);
					for (int placeNo : placeNoList) {
						placeDao.placeDelete(placeNo);
					}
					dailyDao.dailyDelete(dailyNo);
					existPlanList.remove(existPlanList.size() - 1);
				}
			}
		}
		// 입력된 하루 계획표 개수 > 기존 하루 계획표 개수
		else {
			log.debug("입력된 하루 계획표 개수 > 기존 하루 계획표 개수");
			// 기존 하루 계획표 개수만큼 반복
			for (int i = 0; i < existDailyCount; i++) {
				log.debug("i = {}", i);
				
				// 기존 하루 계획표 수정
				log.debug("기존 하루 계획표 수정");
				int dailyNo = dailyDao.getDailyList(plannerNo).get(i).getDailyNo();
				log.debug("dailyNo={}", dailyNo);
				int dailyStayDate = planInsertServiceVO.getPlanList().get(0).get(0).getDailyStayDate();
				planInsertServiceVO.setDailyNo(dailyNo);
				planInsertServiceVO.setDailyStayDate(dailyStayDate);
				
				dailyDao.dailyUpdate(planInsertServiceVO);
				
				log.debug("{}일차 하루 계획표", i + 1);
				
				// 기존 장소 계획 개수
				int existDailyplanCount = dailyplanDao.getDailyplanCount(dailyNo);
				log.debug("기존 장소 계획 개수 = {}", existDailyplanCount);
				
				// 입력된 장소 계획 개수
				int inputDailyplanCount = planInsertServiceVO.getPlanList().get(i).size();
				log.debug("입력된 장소 계획 개수 = {}", inputDailyplanCount);
				
				// 장소 번호 리스트
				List<Integer> placeNoList = null;

				// 입력된 장소 계획 개수 <= 기존 장소 계획 개수
				if (inputDailyplanCount <= existDailyplanCount) {
					log.debug("입력된 장소 계획 개수 <= 기존 장소 계획 개수");
					
					// 입력된 장소 계획 개수만큼 반복
					log.debug("existPlanList={}", existPlanList);
					for (int j = 0; j < inputDailyplanCount; j++) {
						log.debug("{}일차 {}번째 장소 계획", i + 1, j + 1);
						PlanInsertServiceSubVO planList = planInsertServiceVO.getPlanList().get(i).get(j);
						
						// 기존 장소 수정
						log.debug("기존 장소 수정");
						log.debug("placeNo={}", existPlanList.get(placeNoIndex).getPlaceNo());
						planInsertServiceVO.setPlaceNo(existPlanList.get(placeNoIndex).getPlaceNo());
						planInsertServiceVO.setPlaceLatitude(planList.getPlaceLatitude());
						planInsertServiceVO.setPlaceLongitude(planList.getPlaceLongitude());
						planInsertServiceVO.setPlaceName(planList.getPlaceName());
						planInsertServiceVO.setPlaceType(planList.getPlaceType());
	
						placeDao.placeUpdate(planInsertServiceVO);
						placeNoIndex++;
	
						// 기존 장소 계획 수정
						log.debug("기존 장소 계획 수정");
						planInsertServiceVO.setDailyplanTransfer(planList.getDailyplanTransfer());
						
						dailyplanDao.dailyplanUpdate(planInsertServiceVO);
					}
					
					// 잔여 장소 삭제
					if (inputDailyplanCount < existDailyplanCount) {
						log.debug("잔여 장소 삭제");
						for (int j = inputDailyplanCount; j < existDailyplanCount; j++) {
							placeNoList = planListDao.getPlaceNoList(dailyNo);
							placeDao.placeDelete(placeNoList.get(placeNoList.size() - 1));
							placeNoList.remove(placeNoList.size() - 1);
						}
					}
				}
				// 입력된 장소 계획 개수 > 기존 장소 계획 개수
				else {
					log.debug("입력된 장소 계획 개수 > 기존 장소 계획 개수");
					placeNoIndex = 0;
					
					// 입력된 장소 계획 개수만큼 반복
					dailyNo = dailyDao.getDailyList(plannerNo).get(i).getDailyNo();
					placeNoList = planListDao.getPlaceNoList(dailyNo);
					inputDailyplanCount = planInsertServiceVO.getPlanList().get(i).size();
					for (int j = 0; j < inputDailyplanCount; j++) {
						log.debug("{}일차 {}번째 장소 계획", i + 1, j + 1);
						log.debug("placeNoList={}", placeNoList);
						log.debug("existDailyplanCount={}", existDailyplanCount);
						
						PlanInsertServiceSubVO planList = planInsertServiceVO.getPlanList().get(i).get(j);
						
						planInsertServiceVO.setPlaceLatitude(planList.getPlaceLatitude());
						planInsertServiceVO.setPlaceLongitude(planList.getPlaceLongitude());
						planInsertServiceVO.setPlaceName(planList.getPlaceName());
						planInsertServiceVO.setPlaceType(planList.getPlaceType());

						if (j < existDailyplanCount) {
							// 기존 장소 수정
							log.debug("기존 장소 수정");
							log.debug("placeNo={}", placeNoList.get(j));
							planInsertServiceVO.setPlaceNo(placeNoList.get(j));

							placeDao.placeUpdate(planInsertServiceVO);
							placeNoIndex++;
							
							// 기존 장소 계획 수정
							log.debug("기존 장소 계획 수정");
							planInsertServiceVO.setDailyplanTransfer(planList.getDailyplanTransfer());
							
							dailyplanDao.dailyplanUpdate(planInsertServiceVO);
						}
						else {
							// 추가 장소 등록
							log.debug("추가 장소 등록");
							int placeNo = placeDao.getSequence();
							planInsertServiceVO.setPlaceNo(placeNo);
							
							placeDao.placeInsert(planInsertServiceVO);
							
							// 추가 장소 계획 등록
							log.debug("추가 장소 계획 등록");
							planInsertServiceVO.setDailyplanPlaceOrder(planList.getDailyplanPlaceOrder());
							planInsertServiceVO.setDailyplanTransfer(planList.getDailyplanTransfer());
							
							dailyplanDao.dailyplanInsert(planInsertServiceVO);
						}
					}	
				}
			}
		}
		
		// 잔여 기존 계획표 삭제
		log.debug("잔여 기존 계획표 삭제");
		if (inputDailyCount < existDailyCount) {
			for (int i = existDailyCount - 1; i >= inputDailyCount; i--) {
				PlanListDto planListDto = existPlanList.get(existPlanList.size() - 1);
				int dailyNo = planListDto.getDailyNo();

				List<Integer> placeNoList = planListDao.getPlaceNoList(dailyNo);
				log.debug("placeNoList={}", placeNoList);
				for (int placeNo : placeNoList) {
					placeDao.placeDelete(placeNo);
				}
				dailyDao.dailyDelete(dailyNo);
				existPlanList.remove(existPlanList.size() - 1);
			}
		}

		// 추가 계획표 등록
		for (int i = existDailyCount; i < inputDailyCount; i++) {
			// 추가 하루 계획표 등록
			log.debug("{}일차 하루 계획표", i + 1);
			
			int dailyNo = dailyDao.getSequence();
			planInsertServiceVO.setDailyNo(dailyNo);
			
			List<PlanInsertServiceVO> dailyList = dailyDao.getDailyList(plannerNo);
			int dailyOrder = dailyList.get(dailyList.size() - 1).getDailyOrder() + 1;
			
			planInsertServiceVO.setDailyOrder(dailyOrder);
			
			dailyDao.dailyInsert(planInsertServiceVO);
			log.debug("추가 하루 계획표 등록");
			
			// 입력된 장소 계획 개수만큼 반복
			for (int k = 0; k < inputDailyCount; k++) {
				// 기존 장소 계획 개수
				int existDailyplanCount = dailyplanDao.getDailyplanCount(dailyNo);
				log.debug("기존 장소 계획 개수 = {}", existDailyplanCount);
				
				List<Integer> placeNoList = planListDao.getPlaceNoList(dailyNo);
				int inputDailyplanCount = planInsertServiceVO.getPlanList().get(i).size();
				for (int j = 0; j < inputDailyplanCount; j++) {
					log.debug("{}일차 {}번째 장소 계획", i + 1, j + 1);
					log.debug("placeNoList={}", placeNoList);
					log.debug("existDailyplanCount={}", existDailyplanCount);
					
					PlanInsertServiceSubVO planList = planInsertServiceVO.getPlanList().get(i).get(j);
					
					planInsertServiceVO.setPlaceLatitude(planList.getPlaceLatitude());
					planInsertServiceVO.setPlaceLongitude(planList.getPlaceLongitude());
					planInsertServiceVO.setPlaceName(planList.getPlaceName());
					planInsertServiceVO.setPlaceType(planList.getPlaceType());

					if (j < existDailyplanCount) {
						// 기존 장소 수정
						log.debug("기존 장소 수정");
						log.debug("placeNo={}", placeNoList.get(j));
						planInsertServiceVO.setPlaceNo(placeNoList.get(j));

						placeDao.placeUpdate(planInsertServiceVO);
						placeNoIndex++;
						
						// 기존 장소 계획 수정
						log.debug("기존 장소 계획 수정");
						planInsertServiceVO.setDailyplanTransfer(planList.getDailyplanTransfer());
						
						dailyplanDao.dailyplanUpdate(planInsertServiceVO);
					}
					else {
						// 추가 장소 등록
						log.debug("추가 장소 등록");
						int placeNo = placeDao.getSequence();
						planInsertServiceVO.setPlaceNo(placeNo);
						
						placeDao.placeInsert(planInsertServiceVO);
						
						// 추가 장소 계획 등록
						log.debug("추가 장소 계획 등록");
						planInsertServiceVO.setDailyplanPlaceOrder(planList.getDailyplanPlaceOrder());
						planInsertServiceVO.setDailyplanTransfer(planList.getDailyplanTransfer());
						
						dailyplanDao.dailyplanInsert(planInsertServiceVO);
					}
				}	
			}
		}
	}
	
	// 포토스토리 이미지 조회
	@Override
	public FindPhotoVO selectPhoto(FindPhotoVO findPhotoVO) {
		return resultPlanDao.selectPhoto(findPhotoVO);
	}
}
