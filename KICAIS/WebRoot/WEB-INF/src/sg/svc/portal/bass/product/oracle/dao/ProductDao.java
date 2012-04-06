package sg.svc.portal.bass.product.oracle.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import sg.svc.portal.bass.product.ifac.IProductDao;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;

public class ProductDao  extends BaseDao implements IProductDao {

	public void insertProduct(HashMap map) throws DaoException {
		Object data =insert("Product.insProductInsert", map);
		if (data instanceof Integer) {
			Integer insCont = (Integer) data;
		  
			if(insCont.intValue()<1)
				throw new DaoException("insertProduct",new Throwable("등록할 제품이 없습니다."));
		}
	}

	public void insertProductDev(HashMap map) throws DaoException {
		Object data =insert("Product.insProductDevInsert", map);
		
			
		if (data instanceof Integer) {
			Integer insCont = (Integer) data;
		  
			if(insCont.intValue()<1)
				throw new DaoException("insertProductDev",new Throwable("제품 담당자가 없습니다."));
	
	       }
	}

	public void insertProductSW(HashMap map) throws DaoException {
		Object data =insert("Product.insProductSWInsert", map);
		if (data instanceof Integer) {
			Integer insCont = (Integer) data;
		  
			if(insCont.intValue()<1)
				throw new DaoException("insertProductSW",new Throwable("소프트웨어 사양 정보가  없습니다."));
	   }
	}

	public void updateProduct(HashMap map) throws DaoException {
		update("Product.updateProduct", map);
	}

	public void deleteProduct(HashMap map) throws DaoException {
		delete("Product.deleteProduct", map);
	}
	
	public void deleteUseProduct(HashMap map) throws DaoException {
		update("Product.deleteUseProduct", map);
	}
	
	

	public void deleteProductDev(HashMap map) throws DaoException {
		delete("Product.deleteProdDevChman", map);
	}

	public void deleteProductSW(HashMap map) throws DaoException {
		delete("Product.deleteProductSW", map);
	}
	
	public HashMap getProduct(Map map) throws DaoException {
		return (HashMap)queryForObject("Product.viewProductSelect",map);
	}

	public ArrayList listProduct(HashMap<String, String> map)throws DaoException {
		return (ArrayList)this.queryForList("Product.listProductSelect",map);
	}
	
	public ArrayList listProductXML(HashMap<String, String> map)throws DaoException {
		return (ArrayList)this.queryForList("Product.listProductSelectXML",map);
	}
	
	
	public int countProductSelect(Map map) throws DaoException{
		return queryForInt("Product.countProductSelect",map);
	}
	
	

	public void updateProductDev(HashMap map) throws DaoException {
		update("Product.updateProductDev", map);
	}

	public void updateProductSW(HashMap map) throws DaoException {
		update("Product.updateProductSW", map);
	}

	public ArrayList getOSList() throws DaoException {
		return (ArrayList)this.queryForList("Product.listOSSelect");
	}

	public ArrayList getSWList() throws DaoException {
		return (ArrayList)this.queryForList("Product.listSWSelect");
	}

	public ArrayList getSWNameList() throws DaoException {
		return (ArrayList)this.queryForList("Product.listSWTypeSelect");
	}
	
	
	@SuppressWarnings("unchecked")
	public void recmdOsIns(Map map) throws DaoException{
		insert("Product.recmdOsIns", map);
	}
	
	@SuppressWarnings("unchecked")
	public void recmdOsMod(Map map) throws DaoException{
		update("Product.recmdOsMod", map);
	}
	
	@SuppressWarnings("unchecked")
	public int prodMaxSeq(Map map) throws DaoException{
		return queryForInt("Product.prodMaxSeq",map);
	}
	
	
	public ArrayList prodRecmdSwList(Map map) throws DaoException {
		return (ArrayList)this.queryForList("Product.prodRecmdSwList", map);
	}
	
	public ArrayList prodRecmdOsList(Map map) throws DaoException {
		return (ArrayList)this.queryForList("Product.prodRecmdOsList", map);
	}
	
	
	@SuppressWarnings("unchecked")
	public void insSupFile(Map map) throws DaoException{
		insert("Techsup.insSupFile", map);
	}

	public ArrayList prodDevChmanList(Map map) throws DaoException {
		return (ArrayList)this.queryForList("Product.prodDevChmanList", map);
	}

	public void deleteProdDevChman(HashMap map) throws DaoException {
		delete("Product.deleteProdDevChman", map);
	}
	
	public void deleteProductOS(HashMap map) throws DaoException {
		delete("Product.deleteProductOS", map);
	}
	
	@SuppressWarnings("unchecked")
	public void insertTechStatus(Map map) throws DaoException{
		insert("Techsup.insertTechStatus", map);
	}
	
	@SuppressWarnings("unchecked")
	public String productMax(Map map) throws DaoException{
		return queryForString("Product.productMax",map);
	}
	
}
