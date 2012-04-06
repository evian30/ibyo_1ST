package sg.svc.portal.bass.post.helper;

import com.ibatis.sqlmap.client.event.RowHandler;
import com.signgate.core.util.StringUtil;  

import sg.svc.portal.bass.post.domain.Zip;

public class ZipXmlRowHandler implements RowHandler {
	private StringBuffer xmlDocument = new StringBuffer(); 
	private String returnValue = null; 

	public void handleRow(Object valueObject) { 
		Zip zip = (Zip) valueObject;

		xmlDocument.append("<POST>"); 

		xmlDocument.append("<ADDR_BASIC><![CDATA["); 
		xmlDocument.append(zip.getAddr_gubun1()).append(" ").append(zip.getAddr_gubun2()).append(" ").append(zip.getAddr_gubun3()).append(" ");
		
		if(!StringUtil.isNullOrEmpty(zip.getAddr_gubun4()))
			xmlDocument.append(zip.getAddr_gubun4()).append(" ");
		if(!StringUtil.isNullOrEmpty(zip.getSt_nm()))
			xmlDocument.append(zip.getSt_nm()).append(" ");
		xmlDocument.append("]]></ADDR_BASIC>");
		
		xmlDocument.append("<ADDR><![CDATA["); 
		xmlDocument.append(zip.getAddr_gubun1()).append(" ").append(zip.getAddr_gubun2()).append(" ").append(zip.getAddr_gubun3()).append(" ");
		
		if(!StringUtil.isNullOrEmpty(zip.getAddr_gubun4()))
			xmlDocument.append(zip.getAddr_gubun4()).append(" ");
		if(!StringUtil.isNullOrEmpty(zip.getSt_nm()))
			xmlDocument.append(zip.getSt_nm()).append(" ");
		if(!StringUtil.isNullOrEmpty(zip.getBunji()))
			xmlDocument.append(zip.getBunji());

		xmlDocument.append("]]></ADDR>");

		xmlDocument.append("<ZIPCODE>"); 
		xmlDocument.append(zip.getZipcode());
		xmlDocument.append("</ZIPCODE>");

		xmlDocument.append("</POST>"); 
	}

	public String getZipListXML() { 
		if( null == returnValue) {
			returnValue = xmlDocument.toString(); 
		}

		return returnValue; 
	} 
}
