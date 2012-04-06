package test.com.sg.sgis.sample;

import com.sg.sgis.util.GetPKIdUtil;

public class TestGetPKIdUtil {
	public static void main(String [] args){
		
		try {
			System.out.println(GetPKIdUtil.getPkId("PUR", "PUR"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
