package sg.svc.portal.bass.post.domain;

import java.io.Serializable;

import com.signgate.core.lang.object.BaseObject;

/**
 * 
 * 우편번호 빈 클래스
 * 
 * @see 
 * @author javadori
 * @version 1.0 2009. 05. 07
 */
public class Zip extends BaseObject implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4343442285991631076L;
	
	 
	 
	private String zipcode;
	private String addr_gubun1;
	private String addr_gubun2;
	private String addr_gubun3;
	private String addr_gubun4;
	private String addr_gubun5;
	private String bunji;
	private String st_nm;
	private String addr;
	
	
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddr_gubun1() {
		return addr_gubun1;
	}
	public void setAddr_gubun1(String addrGubun1) {
		addr_gubun1 = addrGubun1;
	}
	public String getAddr_gubun2() {
		return addr_gubun2;
	}
	public void setAddr_gubun2(String addrGubun2) {
		addr_gubun2 = addrGubun2;
	}
	public String getAddr_gubun3() {
		return addr_gubun3;
	}
	public void setAddr_gubun3(String addrGubun3) {
		addr_gubun3 = addrGubun3;
	}
	public String getAddr_gubun4() {
		return addr_gubun4;
	}
	public void setAddr_gubun4(String addrGubun4) {
		addr_gubun4 = addrGubun4;
	}
	public String getAddr_gubun5() {
		return addr_gubun5;
	}
	public void setAddr_gubun5(String addrGubun5) {
		addr_gubun5 = addrGubun5;
	}
	public String getBunji() {
		return bunji;
	}
	public void setBunji(String bunji) {
		this.bunji = bunji;
	}
	public String getSt_nm() {
		return st_nm;
	}
	public void setSt_nm(String stNm) {
		st_nm = stNm;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
 
}

