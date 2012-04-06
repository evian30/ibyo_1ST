<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<%-- Show usage; Used in Header --%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
        <title><tiles:getAsString name="title"/></title>

        <link href="/resource/manage/css/admin_sgf.css" rel="stylesheet" type="text/css">
        <link href="/resource/manage/css/ipin_admin_1.0.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>

        <script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
        <script type="text/javascript" src="/resource/common/js/validator.js" ></script>
</head>

<body>

<table width="100%"  height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td height="10" align="left" valign="top" background="/resource/images/admin/img/top_bg.gif">
            <!--HEADER 시작 -->
            <tiles:insertAttribute name="header"/>  
            <!--HEADER 끝 -->
        </td>
    </tr>
    <tr>
        <td width="100%"  align="left" valign="top" style="padding:20px;">
            <!--바디 부분 테이블 -->
            <tiles:insertAttribute name="body"/>    
            <!--바디 부분 테이블 끝-->
        </td>
    </tr>
    <tr>
        <td height="57" align="left" valign="top" background="/resource/images/admin/img/footer_bg.gif">
            <!--FOOTER 시작-->
            <tiles:insertAttribute name="footer"/>  
            <!--FOOTER 끝-->
        </td>
    </tr>
</table>

</body>
</html>
