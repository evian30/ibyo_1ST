package com.sg.sgis.pur.dao;

import java.util.HashMap;
import java.util.List;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

@SuppressWarnings("unchecked")
public class PurchaseDao extends BaseDao implements PurchaseDaoImpl {
	/**
	 * 구매 목록조회
	 * @param  paramMap	( src_pur_date_from		: 구매일자 시작
	 *                  , src_pur_date_to		: 구매일자 끝
	 *                  , src_pur_type_code 	: 구매구분 코드
	 *                  , src_pur_id			: 구매ID
	 *                  , start				  	: 검색(시작페이지)
	 *                  , limit				  	: 검색(종료페이지)
	 * @return list     ( PUR_INFO : 구매목록)
	 * @throws Exception
	 * 2011. 4. 5.
	 */
	public List selectPurchase(HashMap paramMap) throws DaoException {
		return queryForList("Purchase.selectPurchase", paramMap);
	}

	/**
	 * 구매 목록 갯수 조회
	 * @param  paramMap	( )
	 * @return int		( 구매목록 갯수 )
	 * @throws Exception
	 * 2011. 4. 5.
	 */
	public int selectPurchaseCount(HashMap paramMap) throws DaoException{
		return queryForInt("Purchase.selectPurchaseCount",paramMap);
	}

	/**
	 * 구매 정보 입력 (PUR_INFO)
	 * @param  paramMap
	 * 구매ID : PUR_ID
	 *구매일자 : PUR_DATE
	 *구매구분코드 : PUR_TYPE_CODE
	 *업무구분코드 : ROLL_TYPE_CODE
	 *구매명 : PUR_NAME
	 *지출결의번호 : PAY_NO
	 *프로젝트ID : PJT_ID
	 *구매담당자번호 : PUR_EMP_NUM
	 *구매총금액 : PUR_TOTAL_AMT
	 *구매총세액 : PUR_TOTAL_TAX
	 *입고일자 : IN_DATE
	 *구매품의서번호 : PUR_REPORT_NUM
	 *검수필요여부 : INSPECT_YN
	 *검수일자 : INSPECT_DATE
	 *검수당당자사번 : INSPECT_EMP_NUM
	 *검수내용 : INSPECT_DESC
	 *사용일자 : USE_DATE
	 *사용부서 : USE_DEPT
	 *사용자사번 : USE_EMP_NUM
	 *비고 : NOTE
	 *진행상태코드 : PROC_STATUS_CODE
	 * @return int : 성공여부
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	public int insertPurchaseInfo(HashMap paramMap) throws DaoException {
		return update("Purchase.insertPurchaseInfo", paramMap);
	}

	/**
	 * 구매 품목 정보 입력 (PUR_ITEM)
	 * @param  paramMap
	 * @return int : 성공여부
	 * @throws Exception
	 * 2011. 4. 13.
	 */
	public int insertPurItemInfo(HashMap paramMap) throws DaoException {
		return update("Purchase.insertPurchaseItem", paramMap);
	}

	public List selectPurItem(HashMap paramMap) throws DaoException {
		return queryForList("Purchase.selectPurchaseItem", paramMap);
	}

	public int selectPurItemCount(HashMap paramMap) throws DaoException {
		return queryForInt("Purchase.selectPurItemCount", paramMap);
	}

	public List selectPurItemSpec(HashMap paramMap) throws DaoException {
		return queryForList("Purchase.selectPurItemSpec", paramMap);
	}

	public int selectPurItemSpecCount(HashMap paramMap) throws DaoException {
		return queryForInt("Purchase.selectPurItemSpecCount", paramMap);
	}

	public int insertPurItemSpec(HashMap<String, String> map) throws DaoException {
		return update("Purchase.insertPurItemSpec", map);
	}

	public int updatePurchaseInfo(HashMap<String, String> map) throws DaoException {
		return update("Purchase.updatePurchaseInfo", map);
	}

	public int updatePurchaseItem(HashMap paramMap) throws DaoException {
		return update("Purchase.updatePurchaseItem", paramMap);
	}

	public int updatePurchaseSpec(HashMap<String, String> map) throws DaoException {
		return update("Purchase.updatePurItemSpec", map);
	}

	public int updateInspectInfo(HashMap paramMap) throws DaoException {
		return update("Purchase.updateInspectInfo", paramMap);
	}

	public int updatePjtProcCode(HashMap paramMap) throws DaoException{
		return update("Purchase.updatePjtProcCode", paramMap);
	}

	public int insertPjtHistory(HashMap paramMap) throws DaoException{
		return update("Purchase.insertPjtHistory", paramMap);
	}


}
