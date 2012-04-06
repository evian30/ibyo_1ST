package com.sg.sgis.util;

import java.io.StringReader;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.JavaTypeMapper;


public class JsonUtil {

    // ----------- Private static members --------

    private static final Log log = LogFactory.getLog(JsonUtil.class);

    private static JsonFactory jf = new JsonFactory();

    // ------------ Public static methods ----------------------


    /**
     * Convert JackSon string to Map<String, String>[].
     *
     * @param str - Jackson string
     * @return Map<String, String>[]
     */
    public static List<Map<String, String>> getListFromJsonArray(String str) {
    	
        try {
            if (StringUtils.isNotEmpty(str)) {
                @SuppressWarnings("unchecked")
				ArrayList<Map<String, String>> arrList = (ArrayList<Map<String, String>>) new JavaTypeMapper()
                        .read(jf.createJsonParser(new StringReader(str)));
                return arrList;
            } else {
                log.warn("JacksonUtil.getListsFromJsonArray error| ErrMsg: input string is null ");
                return null;
            }
        } catch (Exception e) {
            log.error("JacksonUtil.getListsFromJsonArray error| ErrMsg: " + e.getMessage(), e);
            return null;
        }

    }


    /**
     * Convert JackSon string to Map<String, String>
     *
     * @param str - jackson string
     * @return Map<String, String>
     */
    public static Map<String, String> getMapFromJsonString(String str) {
        try {
            if (StringUtils.isNotEmpty(str)) {
                @SuppressWarnings("unchecked")
				Map<String, String> map = (Map<String, String>) new JavaTypeMapper()
                        .read(jf.createJsonParser(new StringReader(str)));
                return map;
            } else {
                log.warn("ErrMsg: input string is null ");
                return null;
            }
        } catch (Exception e) {
            log.error("ErrMsg: " + e.getMessage(), e);
            return null;
        }
    }

    /**
     * Convert Map<String, String>[] to JackSon string
     *
     * @param list Array of Map<String,String>
     * @return jackson string
     */
    @SuppressWarnings("deprecation")
	public static String getJsonStringFromList(List<Map<String, String>> list) {
        try {
            StringWriter sw = new StringWriter();
            JsonGenerator gen = jf.createJsonGenerator(sw);
            new JavaTypeMapper().writeAny(gen, list);
            gen.flush();
            return sw.toString();
        } catch (Exception e) {
            log.error("JacksonUtil.getJsonStringFromMap error| ErrMsg: " + e.getMessage(), e);
            return null;
        }
    }

    /**
     * Convert Map<String, String> to JackSon string
     *
     * @param aMap Map
     * @return Map<String, String>
     */
    @SuppressWarnings("deprecation")
	public static String getJsonStringFromMap(Map<String, String> aMap) {
        try {
            StringWriter sw = new StringWriter();
            JsonGenerator gen = jf.createJsonGenerator(sw);
            new JavaTypeMapper().writeAny(gen, aMap);
            gen.flush();
            return sw.toString();
        } catch (Exception e) {
            log.error("ErrMsg: " + e.getMessage(), e);
            return null;
        }
    }
}
