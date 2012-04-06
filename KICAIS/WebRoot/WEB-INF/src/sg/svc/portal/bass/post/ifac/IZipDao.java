package sg.svc.portal.bass.post.ifac;

import java.util.Map;

import com.signgate.core.exception.DaoException;


public interface IZipDao {
	public String selectZipList(Map parameterMap) throws DaoException;
}
