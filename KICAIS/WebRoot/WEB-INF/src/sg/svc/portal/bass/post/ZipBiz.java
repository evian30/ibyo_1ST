package sg.svc.portal.bass.post;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sg.svc.portal.bass.post.ifac.IZipDao;

public class ZipBiz {
	private IZipDao zipDao = null;
	protected final Log logger = LogFactory.getLog(getClass());

	public void setZipDao(IZipDao zipDao) {
		this.zipDao = zipDao;
	}
	
	public String selZip(Map parameterMap) {
		String result = null;

		try {
			result = zipDao.selectZipList(parameterMap);
		} catch (Exception e) {
			logger.error(e,e);
		}

		return result;
	}
}
