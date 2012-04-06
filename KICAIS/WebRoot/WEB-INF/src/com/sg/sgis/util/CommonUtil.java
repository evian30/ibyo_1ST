package com.sg.sgis.util;

import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;

public class CommonUtil {	 
	
	/**
	 * 페이징시 파라메터값 한글 깨지는거 처리
	 * @param word
	 * @return
	 * 2011. 3. 9.
	 */
	public static String getDecodingUTF(String word){
	    
	    String decodedWord = null;
	    
	    if (word == null)
	        return null;
	    else {
	        byte[] b;
	        try {
	            b = word.getBytes("8859_1");
	            CharsetDecoder decoder = Charset.forName("UTF-8").newDecoder();
	            try {
	                CharBuffer r = decoder.decode(ByteBuffer.wrap(b));
	                decodedWord = r.toString();
	            } catch (CharacterCodingException e) {
	                decodedWord = new String(b, "EUC-KR");
	            }
	        } catch (UnsupportedEncodingException e1) {
	            e1.printStackTrace();
	        }
	    }
	    return decodedWord;
	}
	
	
	
	
	
	
}
	
 
