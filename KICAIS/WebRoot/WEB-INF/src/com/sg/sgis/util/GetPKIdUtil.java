package com.sg.sgis.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;


public class GetPKIdUtil {


	public static String getPkId (String id, String headName){
		String result = "";
		Connection con;
		Statement stmt;
		ResultSet rs;
		try{ 
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String oracleServerInfo = "@61.72.247.245:1521:SGDEV";
			String oracleId = "sgis";
			String oraclePassword = "sgis";
			String connectionInfo = "jdbc:oracle:thin:" + oracleServerInfo;
			con = DriverManager.getConnection("jdbc:oracle:thin:"+oracleServerInfo,oracleId, oraclePassword);

			Date date = new Date();
			Format formatter = new SimpleDateFormat("yyyyMMdd");
			String nowDate = formatter.format(date);
			stmt = con.createStatement();

			String sql = "SELECT GET_AUTO_NUM('" + id + "', '" + headName + "', '"+ nowDate + "', '4') FROM DUAL";
			rs = stmt.executeQuery(sql);

			while(rs.next()){
				result = rs.getString(1);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return result;
	}

}
