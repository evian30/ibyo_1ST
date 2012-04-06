package sg.svc.portal.bass.post.dao;

import java.util.Map;

import com.signgate.core.dao.BaseDao;
import com.signgate.core.exception.DaoException;
import sg.svc.portal.bass.post.helper.ZipXmlRowHandler;
import sg.svc.portal.bass.post.ifac.IZipDao;

public class ZipDao extends BaseDao implements IZipDao {
	public String selectZipList(Map parameterMap) throws DaoException {
		ZipXmlRowHandler zipxrh = new ZipXmlRowHandler();

		queryWithRowHandler("Zip.selectZipList", parameterMap, zipxrh);

		return zipxrh.getZipListXML();
	}
}
