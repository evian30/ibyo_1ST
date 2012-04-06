<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<%
HashMap map = (HashMap)request.getAttribute("loginSession");


out.println(map.get("GROUPS").toString());
%>