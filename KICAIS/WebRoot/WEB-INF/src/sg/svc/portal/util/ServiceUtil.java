package sg.svc.portal.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.signgate.core.util.StringUtil;
import com.signgate.core.web.util.WebUtil;
//import com.signgate.sgir.common.domain.Code;
//import com.signgate.sgir.common.ifac.ISgirCommonDao;
import com.sun.org.apache.bcel.internal.classfile.Code;

public class ServiceUtil {	
	
	public static HashMap<String,List<Code>> codeMap = new HashMap<String,List<Code>>();
	public static String tempStr = "";

	public static final String[] AREA_CODE = {"02","031","032","033","041","042","043","051","052","053","054"
		,"055","061","062","063","064","0303","0502","0504","0505","0506","070","080","010","011","016","017","018","019"};
	//헤드폰번호
	public static final String[] HP_CODE = {"010","011","016","017","018","019","0130","0502","0505","0506","1541","1595"};
	
	//메일주소
	public static final String[] MAIL_ADDR = {"nate.com","naver.com","hanmail.net","daum.net","chollian.net","dreamwiz.com"
		,"empal.com","freechal.com","hanafos.com","hotmail.com","kebi.com","korea.com","lycos.co.kr","netian.com","paran.com"
		,"unitel.co.kr","yahoo.co.kr"}; 
	
	
	public static String getHp(String check){
		StringBuilder text = new StringBuilder();
		for(String val : HP_CODE){
			if(val.equals(check))
				text.append("<option value='").append(val).append("' selected>").append(val).append("</option>");
			else
				text.append("<option value='").append(val).append("'>").append(val).append("</option>");
		}
		return text.toString();
	}
	
	public static String getTel(String check){StringBuilder text = new StringBuilder();
	for(String val : AREA_CODE){
		if(val.equals(check))
			text.append("<option value='").append(val).append("' selected>").append(val).append("</option>");
		else
			text.append("<option value='").append(val).append("'>").append(val).append("</option>");
	}
	return text.toString();
	}
	
	public static String getEmail(String check){StringBuilder text = new StringBuilder();
	for(String val : MAIL_ADDR){
		if(val.equals(check))
			text.append("<option value='").append(val).append("' selected>").append(val).append("</option>");
		else
			text.append("<option value='").append(val).append("'>").append(val).append("</option>");
	}
	return text.toString();
	}

	public static String parseXmlMap(HashMap map){
		StringBuffer xmlStr = new StringBuffer();
		if(map != null){
			Iterator dataInter = map.keySet().iterator();
			while(dataInter.hasNext()){
				String key = (String)dataInter.next();
				try{
					xmlStr.append("<"+key+"><![CDATA["+StringUtil.nullToStr((String)map.get(key), "")+"]]></"+key+">");
				}catch(ClassCastException e){
					xmlStr.append("<"+key+">"+(BigDecimal)map.get(key)+"</"+key+">");				
				}
			}
		}
		return xmlStr.toString();
	}
	
	
	public static String parseXmlMap(List list){
		StringBuffer xmlStr = new StringBuffer();
		if(list != null){
			Iterator iterator = list.iterator();
			while(iterator.hasNext()){
				xmlStr.append("<Service>");
				HashMap map = (HashMap)iterator.next();
				xmlStr.append(parseXmlMap(map));
				xmlStr.append("</Service>");
			}
		}
		return xmlStr.toString();
	}
	
	/**
	 * TB_CEDETAIL 테이블에서 gid 값으로 cd_id 가지고온다. NM으로 정렬
	 * @param request
	 * @param cd_gid
	 * @return
	 * @throws Exception
	 */
	public static List<Code> getCdList(HttpServletRequest request,String cd_gid) throws Exception{
		List<Code> list = null;
		try{
			list = (List<Code>)codeMap.get(cd_gid);
			if(list == null){
				//ISgirCommonDao commonDao = (ISgirCommonDao)WebUtil.getBeanByBeanID(request, "sgirCommonDao");
				//list = commonDao.getCode(cd_gid);				
				codeMap.put(cd_gid, list);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * TB_CEDETAIL 테이블에서 gid 값으로 cd_id 가지고온다. ID로 정렬
	 * @param request
	 * @param cd_gid
	 * @return
	 * @throws Exception
	 */
	public static List<Code> getCdListSortId(HttpServletRequest request,String cd_gid) throws Exception{
		List<Code> list = null;
		try{
			list = (List<Code>)codeMap.get(cd_gid);
			if(list == null){
//				ISgirCommonDao commonDao = (ISgirCommonDao)WebUtil.getBeanByBeanID(request, "sgirCommonDao");
//				list = commonDao.getCodeSortId(cd_gid);				
				codeMap.put(cd_gid, list);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return list;
	}
	
	public static Object getClassBeanByBeanID(String beanID, String filePath){
		ApplicationContext ctx = new ClassPathXmlApplicationContext(filePath); 
		return ctx.getBean(beanID);
	}
	
	public static Object getFileBeanByBeanID(String beanID, String filePath){
		String path = new ServiceUtil().getClass().getResource("ServiceUtil.class").getPath();
		
		path = path.substring(0, path.lastIndexOf("/classes"));

		ApplicationContext ctx = new FileSystemXmlApplicationContext("/"+path+"/"+filePath); 
		return ctx.getBean(beanID);
	}
	
	public static String replaceAll(String source, String after, String befor){
		if(source == null){
			return "";
		}
		return source.replaceAll(after, befor);
	}
	
	

	public static Map<String, List<String>> parseRequestArrayMap(Map<String, List<String>> map, String key, String[] value){       
        int i = value.length;
        List<String> arraylist = new ArrayList<String>();
        for(int j = 0; j < i; j++)
            arraylist.add(value[j]);

        map.put(key, arraylist);
            
        
        return map;
    }
	
	public static Map<String, String> parseRequestMap(Map<String, String> map, String key,String value){		
        map.put(key, value);
        return map;
    }
	
	public static HashMap mapNullCheck(HashMap map){
		HashMap resultMap = null;
		//if(map != null){
			resultMap = new HashMap();
			Iterator dataInter = map.keySet().iterator();
			while(dataInter.hasNext()){
				String key = (String)dataInter.next();
				try{
					String temp01 = (map.get(key) == null)?"":(String)map.get(key);
					System.out.println("KEY :" + key +"=="+temp01);
					resultMap.put(key, temp01);
				}catch(ClassCastException e){
					if(map.get(key) != null){
						BigDecimal temp = (BigDecimal)map.get(key);
						resultMap.put(key, temp.toString());
					}else{
						resultMap.put(key, "");
					}
				}
			}
		//}
		return resultMap;
	}
}
