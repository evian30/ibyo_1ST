<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<%-- Show usage; Used in Header --%>
<tiles:importAttribute name="title" scope="request"/>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
        <title><tiles:getAsString name="title"/></title>

        <link rel="stylesheet" type="text/css" href="/resource/common/css/validator.css" media="screen, projection"/>

        <script type="text/javascript" src="/resource/common/js/ajax.js" ></script>
        <script type="text/javascript" src="/resource/common/js/validator.js" ></script>
    </head>
    <body>
		<table width='100%' border='1'>
		    <tr>
		        <td>
		            <table>
		                <tr><td><tiles:insertAttribute name="header"/></td></tr>
		            </table>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <table width='100%' border='1'>
		               <tr><td><tiles:insertAttribute name="body"/></td></tr>
		            </table>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <table>
		                <tr><td><tiles:insertAttribute name="footer"/></td></tr>
		            </table>
		        </td>
		    </tr>
		</table>
    </body>
</html>