package sg.svc.portal.bass.schedule.domain;

import java.io.Serializable;

import com.signgate.core.lang.object.BaseObject;

@SuppressWarnings("serial")
public class Schedule extends BaseObject implements Serializable{
	private String chman_no; 
	
	private int    sche_no;
	private String tech_sup_app_no;
	
	private String st_date;
	private String end_date;
	
	private String title;
	private String contents;
	private String cr_date;
	private String up_date;
	public String getChman_no() {
		return chman_no;
	}
	public void setChman_no(String chmanNo) {
		chman_no = chmanNo;
	}
	public int getSche_no() {
		return sche_no;
	}
	public void setSche_no(int scheNo) {
		sche_no = scheNo;
	}
	public String getTech_sup_app_no() {
		return tech_sup_app_no;
	}
	public void setTech_sup_app_no(String techSupAppNo) {
		tech_sup_app_no = techSupAppNo;
	}
	public String getSt_date() {
		return st_date;
	}
	public void setSt_date(String stDate) {
		st_date = stDate;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String endDate) {
		end_date = endDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCr_date() {
		return cr_date;
	}
	public void setCr_date(String crDate) {
		cr_date = crDate;
	}
	public String getUp_date() {
		return up_date;
	}
	public void setUp_date(String upDate) {
		up_date = upDate;
	}
	
	
	
 
}
