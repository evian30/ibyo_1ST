<%--
  Class Name  : ozReport.jsp
  Description : 
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 4. 01               최초 생성   
  
  author   : 
  since    : 2011. 4. .
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
<script type="text/javascript" src="/resource/common/js/common/common-msg-box.js" ></script> 
<script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
<%
	String param = request.getParameter("param");			// 파라메터
	String odi = request.getParameter("odi");				// odi 파일명
	String ozr = "/"+request.getParameter("ozr")+".ozr";	// ozr 파일명
	String[] paramData = param.split(","); 					// 파라메터
%>
<html>
    <body>
        <object id="ZTransferX" width="0" height="0" CLASSID="CLSID:C7C7225A-9476-47AC-B0B0-FF3B79D55E67" codebase=<c:out value="${oz}" />"/ozviewer/ZTransferX.cab#version=2,2,2,2">
            <param name="download.Server" value=<c:out value="${oz}"/>"/ozviewer">
            <param name="download.Port" value="80">
            <param name="download.Instruction" value="ozrviewer.idf">
            <param name="install.Base" value="<PROGRAMS>/Forcs">
            <param name="install.NameSpace" value="KICAIS"> <!--namespace 수정요망-->
        </object>
        <object id="ozviewer" width="800" height="600" CLASSID="CLSID:0DEF32F8-170F-46f8-B1FF-4BF7443F5F25">
            <param name="connection.servlet" value="http://kicais.signgate.com/oz/server">
            <param name="connection.reportname" value="<%=ozr%>">
            <param name="viewer.configmode" value="html">
            <param name="odi.odinames" value="<%=odi%>">
            <param name="odi.<%=odi%>.pcount" value="<%=paramData.length%>">
            <%for(int i = 0 ; i < paramData.length ; i++){ %>
            <param name="odi.<%=odi%>.args<%=i+1%>" value="<%=paramData[i]%>">
            <%} %>
<%--            <param name="odi.<%=odi%>.args<%=i+2%>" value="<%=paramData[1]%>">--%>
<%--            <param name="odi.<%=odi%>.args<%=i+3%>" value="<%=paramData[2]%>">--%>
            <param name="odi.<%=odi%>.clientdmtype" value="Memory">
            <param name="odi.<%=odi%>.serverdmtype" value="Memory">
            <param name="odi.<%=odi%>.fetchtype" value="Concurrent">

	    <param name="viewer.isframe" value="false">
        </object>
    </body>
</html>