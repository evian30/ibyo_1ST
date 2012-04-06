package sg.svc.portal.bass.product.ifac;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.signgate.core.exception.DaoException;

/**
 * @author simshu
 * @since  2010
 */

public interface IProductDao {

	/** 
		 * Method ID  	:  insertProduct
		 * Method 설명  	:  제품 등록 
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return Object
		 */ 
	public void insertProduct(HashMap map) throws DaoException;

	/** 
		 * Method ID  	:  insertProductSW
		 * Method 설명  	:  제품 소프트웨어 권장 사항 등록
		  @since  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return Object
		 */ 
	public void insertProductSW(HashMap map) throws DaoException;

	/** 
		 * Method ID  	:  insertProductDev
		 * Method 설명  	:  제품 개발 담당자 등록 
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return Object
		 */ 
	public void insertProductDev(HashMap map)   throws DaoException;

	/** 
		 * Method ID  	:  
		 * Method 설명  	:  
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return void
		 */ 
	public void updateProduct(HashMap map) throws DaoException;

	/** 
		 * Method ID  	:  
		 * Method 설명  	:  
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return void
		 */ 
	public void updateProductSW(HashMap map)  throws DaoException;

	
	
	/** 
		 * Method ID  	:  
		 * Method 설명  	:  
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return void
		 */ 
	public void updateProductDev(HashMap map)  throws DaoException;

	/** 
		 * Method ID  	:  
		 * Method 설명  	:  
		 * 최초작성일  	: 2010. 8. 26.  
		 * 작성자 		:  simshu
		 * 특이사항		:
		 * 변경이력 		:  
		 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return ArrayList
		 */ 
	public  ArrayList listProduct(HashMap<String, String> map)  throws DaoException;

	/** 
	 * Method ID  	:  
	 * Method 설명  	:  
	 * 최초작성일  	: 2010. 8. 26.  
	 * 작성자 		:  simshu
	 * 특이사항		:
	 * 변경이력 		:  
	 * 
	 * @param   
	 * @param  
	 * @throws  
	 * @return ArrayList
	 */ 
	public  ArrayList listProductXML(HashMap<String, String> map)  throws DaoException;
	
	/** 
		 * MethodName  :  <br>
		 * Method설명  	:  <br>
		 * 최초작성일  	: 2010. 8. 26.  <br>
		 * 작성자 		:  simshu <br>
		 * 특이사항		:	<br>
		 * 변경이력 		:   <br>
	 	 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return HashMap
		 */ 
	public HashMap getProduct(Map map)  throws DaoException;

	
	
	/** 
		 * <li> MethodName  : deleteProduct <br>
		 * <li> Method설명  	:  <br>
		 * <li> 최초작성일  	: 2010. 8. 26.  <br>
		 * <li> 작성자 		:  simshu <br>
		 * <li> 특이사항		:	<br>
		 * <li> 변경이력 		:   <br>
	 	 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return void
		 */ 
	public void deleteProduct(HashMap map)  throws DaoException;
	
	public void deleteUseProduct(HashMap map)  throws DaoException;

	/** 
		 * <li> MethodName  : deleteProductSW <br>
		 * <li> Method설명  	:  <br>
		 * <li> 최초작성일  	: 2010. 8. 26.  <br>
		 * <li> 작성자 		:  simshu <br>
		 * <li> 특이사항		:	<br>
		 * <li> 변경이력 		:   <br>
	 	 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return void
		 */ 
	public void deleteProductSW(HashMap map)  throws DaoException;

	/** 
		 * <li> MethodName  : deleteProductDev <br>
		 * <li> Method설명  	:  <br>
		 * <li> 최초작성일  	: 2010. 8. 26.  <br>
		 * <li> 작성자 		:  simshu <br>
		 * <li> 특이사항		:	<br>
		 * <li> 변경이력 		:   <br>
	 	 * 
		 * @param   
		 * @param  
		 * @throws  
		 * @return void
		 */ 
	public void deleteProductDev(HashMap map)  throws DaoException;

	/** 
	 * <li> MethodName  : deleteProductOS <br>
	 * <li> Method설명  	:  <br>
	 * <li> 최초작성일  	: 2010. 8. 26.  <br>
	 * <li> 작성자 		:  simshu <br>
	 * <li> 특이사항		:	<br>
	 * <li> 변경이력 		:   <br>
 	 * 
	 * @param   
	 * @param  
	 * @throws  
	 * @return void
	 */ 
	public void deleteProductOS(HashMap map)  throws DaoException;
	
	/** 
	 * <li> MethodName  : getOSList <br>
	 * <li> Method설명  	: OS 종류 조회 쿼리  <br>
	 * <li> 최초작성일  	: 2010. 8. 26.  <br>
	 * <li> 작성자 		:  simshu <br>
	 * <li> 특이사항		:	<br>
	 * <li> 변경이력 		:   <br>
 	 * 
	 * @param   
	 * @param  
	 * @throws  
	 * @return void
	 */ 
	public ArrayList getOSList()throws DaoException;

	/** 
	 * <li> MethodName  : getSWList <br>
	 * <li> Method설명  	:   SW 종류 조회 쿼리 <br>
	 * <li> 최초작성일  	: 2010. 8. 26.  <br>
	 * <li> 작성자 		:  simshu <br>
	 * <li> 특이사항		:	<br>
	 * <li> 변경이력 		:   <br>
 	 * 
	 * @param   
	 * @param  
	 * @throws  
	 * @return void
	 */ 
	public ArrayList getSWList()throws DaoException;

	
	/** 
	 * <li> MethodName  : getSWList <br>
	 * <li> Method설명  	:   SW 분류 조회 쿼리 <br>
	 * <li> 최초작성일  	: 2010. 8. 26.  <br>
	 * <li> 작성자 		:  simshu <br>
	 * <li> 특이사항		:	<br>
	 * <li> 변경이력 		:   <br>
 	 * 
	 * @param   
	 * @param  
	 * @throws  
	 * @return void
	 */ 
	public ArrayList getSWNameList()throws DaoException;
	
	public int countProductSelect(Map map) throws DaoException;
	
	public  void recmdOsIns(Map map)  throws DaoException;
	
	public void recmdOsMod(Map map) throws DaoException;
	
	@SuppressWarnings("unchecked")
	public int prodMaxSeq(Map map) throws DaoException;
	
	public ArrayList prodRecmdSwList(Map map)throws DaoException;
	
	public ArrayList prodRecmdOsList(Map map)throws DaoException;
	
	
	@SuppressWarnings("unchecked")
	public void insSupFile(Map map) throws DaoException;
	
	public ArrayList prodDevChmanList(Map map)throws DaoException;
	
	public void deleteProdDevChman(HashMap map)  throws DaoException;
	
	@SuppressWarnings("unchecked")
	public String productMax(Map map) throws DaoException;
	
}
