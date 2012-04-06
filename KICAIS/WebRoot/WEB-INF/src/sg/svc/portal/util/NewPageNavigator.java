package sg.svc.portal.util;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.signgate.core.web.util.PageNavigator;

public class NewPageNavigator extends PageNavigator{
	private String pageNavigator;

	private String firstImage = "/resource/images/bass_1st/page_end.gif";
	private String prevImage = "/resource/images/bass_1st/page_next.gif";
	private String nextImage = "/resource/images/bass_1st/page_prev.gif";
	private String lastImage = "/resource/images/bass_1st/page_first.gif";

	@SuppressWarnings("unchecked")
	public void setParameterMap(Map parameterMap) {
 
		requestURI = (String)parameterMap.get("requestURI");
		Set parameterNames = parameterMap.keySet();
		String value;
		Iterator it = parameterNames.iterator();

		while(it.hasNext()) {
			String param = (String)it.next();
			if(param.equals(pageString)) {
				String page = (String)parameterMap.get(param);
				setCurrentPage((page==null || page.equals("")) ? 1 : Integer.parseInt(page));
			} else {
//				try {
					value = (String)parameterMap.get(param);
//					if(!param.equals("pcust_nm"))
//						value = java.net.URLEncoder.encode((value==null || value.equals("")) ? "" : value,"UTF-8");
					value = (value==null || value.equals("")) ? "" : value;
					System.out.println(param +":"+ value);
					if(param.equals("requestURI") || value.equals("")) continue;
					else if(param.indexOf("®") > -1) param = param.replace("®", "reg");
					queryString += "&" + param + "=" + value;
//				} catch (UnsupportedEncodingException e) {
//					e.printStackTrace();
//				}
			}
		}
	}
	
	public String getPageNavigator() {
		
		StringBuffer naviHtml = new StringBuffer();
		idx = getTotalRow() - (PAGE_SIZE * (getCurrentPage()-1)); 
		
		naviHtml.append(" <div class='paging' style='align:center'> \n");
		
		if(this.getTotalPage()==0) naviHtml.append("<div class='paging'>등록된 데이타가 없습니다.</div>");
		
		if(getCurrentPage() > 1){
			naviHtml.append(String.format("&nbsp;<a style='cursor:pointer;' onclick='goPageByNavigation(\"%s\",1)'><img src='%s' alt='처음으로' align='absmiddle' /></a>&nbsp; \n", getSelfURL(), firstImage));
		}else{
			//naviHtml.append(String.format("&nbsp;<img src='%s' alt='처음으로' align='absmiddle' /> \n", firstImage));
		}
		if(getStartPage()-1 > 0){
			naviHtml.append(String.format("&nbsp;<a style='cursor:pointer;' onclick='goPageByNavigation(\"%s\",%s)'><img src='%s' alt='이전' align='absmiddle' /></a>&nbsp; \n", getSelfURL(), currentPage-1, prevImage));
		}
		
		for(int i=getStartPage();i<=getEndPage();i++){
			if(i == currentPage){
				naviHtml.append(String.format(" <strong>%s</strong>&nbsp;&nbsp; \n",i));
			}else if(i == getEndPage()){
				naviHtml.append(String.format(" <a style='cursor:pointer;' onclick='goPageByNavigation(\"%s\",%s)' class='end'>%s</a>&nbsp;&nbsp; \n", getSelfURL(),i,i));
			}else{
				naviHtml.append(String.format(" <a style='cursor:pointer;' onclick='goPageByNavigation(\"%s\",%s)'>%s</a>&nbsp;&nbsp; \n", getSelfURL(),i,i));
			}			
		}
		if(getStartPage()+NAVI_SIZE <= getTotalPage()){
			naviHtml.append(String.format("&nbsp;<a style='cursor:pointer;' onclick='goPageByNavigation(\"%s\",%s)'><img src='%s' alt='다음' align='absmiddle' /></a>&nbsp; \n", getSelfURL(), getStartPage()+NAVI_SIZE,nextImage));
		}
		
		if(getCurrentPage() < getTotalPage()){
			naviHtml.append(String.format("&nbsp;<a style='cursor:pointer;' onclick='goPageByNavigation(\"%s\",%s)'><img src='%s' alt='끝으로' align='absmiddle' /></a>&nbsp; \n", getSelfURL(), getTotalPage(), lastImage));
		}else{
			//naviHtml.append(String.format("&nbsp;<img src='%s' alt='끝으로' align='absmiddle' />&nbsp; \n", lastImage));
		}
		naviHtml.append("</div>");
		
		if(this.getTotalPage()==1) naviHtml.append(" <div class='paging'>&nbsp;</div>&nbsp;");
		

		return naviHtml.toString();
	}
	 

	public int getPageSize(){
		return PAGE_SIZE;
	}

	public String getFirstImage() {
		return firstImage;
	}

	public void setFirstImage(String firstImage) {
		this.firstImage = firstImage;
	}

	public String getPrevImage() {
		return prevImage;
	}

	public void setPrevImage(String prevImage) {
		this.prevImage = prevImage;
	}

	public String getNextImage() {
		return nextImage;
	}

	public void setNextImage(String nextImage) {
		this.nextImage = nextImage;
	}

	public String getLastImage() {
		return lastImage;
	}

	public void setLastImage(String lastImage) {
		this.lastImage = lastImage;
	}
}
