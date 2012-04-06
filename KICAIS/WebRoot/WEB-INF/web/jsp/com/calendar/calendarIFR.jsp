<%--
  Class Name  : calendar.jsp
  Description : 일정관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 4. 05   여인범            최초 생성   
  
  author   : 여인범
  since    : 2011. 4. 05.
  version  : 1.0
   
  Copyright (C) 2011 by SG All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<html>
	<head>
	    <title>일정관리</title>
	    <script type="text/javascript" src="/resource/common/js/sgis-comm-inc.js" ></script> 
	    
		<c:choose>
		<c:when test="${getAuthority!='팀원'}">
			<script language='javascript' type='text/javascript'>
			//<![CDATA[
	
			   	Ext.get('src_sup_emp_btn').on('click', function(e){		   		
					fnEmployeePop();
			   	});
			   	
			   	
			   	/***************************************************************************
				 * 설  명 : 담당자검색
				 ***************************************************************************/
				function fnEmployeePop(){
					var dlgWidth  = 420;
					var dlgHeight = 400;
					var winName ="";
				    var sURL ="";  
					sURL = "/com/employee/employeePop.sg?requestFieldName=src_scd_day_reg_emp_name";
					fnOpenPop(sURL, dlgWidth, dlgHeight, winName);
				}
			   	
			   	// 팝업
				function fnOpenPop(sURL, dlgWidth, dlgHeight, winName){
				  var xPos=(window.screen.width) ? (window.screen.width-dlgWidth)/2 : 0;
				  var yPos=(window.screen.height) ? (window.screen.height-dlgHeight)/2 : 0;
				  var sFeatures = "titlebar=no, scrollbars=yes,location=no ,menubar=no, resizable=yes, status=yes, width="+dlgWidth+",height="+dlgHeight+",left="+xPos+", top="+yPos;
				  window.open(sURL,winName, sFeatures);
				}
			
			   	
			   	function fnEmployeePopValue(records,fileName){	
				    var record = records[0].data;
				    Ext.get('src_scd_day_reg_emp_num').set({value:fnFixNull(record.EMP_NUM)} , false);
				    Ext.get('src_scd_day_reg_emp_name').set({value:fnFixNull(record.KOR_NAME)} , false);
				    Ext.get('src_scd_day_reg_dept').set({value:fnFixNull(record.DEPT_CODE)} , false);
				    Ext.get('src_scd_day_reg_dept_name').set({value:fnFixNull(record.DEPT_NAME)} , false);
				    autoSearch();
				}
			   	
			   	
			   	Ext.get('searchBtn').on('click', function(e){ 
			   		autoSearch();
			    });
			   	
			   	
			   	Ext.get('searchClearBtn').on('click', function(e){ 
			   		 autoSearch("myOwn");
			    }); 
			   	
			   	
			   	function autoSearch(obj){
			   		var f = document.searchForm;
			   		
			   		var a = f.src_scd_day_reg_dept.value;
			   		var b = f.src_scd_day_reg_emp_num.value;		   		
			   		var param = "";
			   		
			   		if(obj=="myOwn"){
			   			Ext.get('src_scd_day_reg_emp_num').set({value:""} , false);
					    Ext.get('src_scd_day_reg_emp_name').set({value:""} , false);
					    Ext.get('src_scd_day_reg_dept').set({value:""} , false);
					    Ext.get('src_scd_day_reg_dept_name').set({value:""} , false);
				     	param = "?calMon=<%=request.getParameter("calMon") %>";
			   		}else{
			   			param = "?src_scd_day_reg_dept="+a+"&src_scd_day_reg_emp_num="+b;		
			   		}		   		
			   		
					document.getElementById("ifrSrc").src="/com/calendar/calendar.sg"+param;
			   		
			   	}
			   	 
			   
			   	//]]>
			</script>
		</c:when>
	</c:choose>
	</head>
	
	<body>  
	 <c:choose>
		<c:when test="${getAuthority!='팀원'}">
		
		<form name="searchForm">
								
		<input type="hidden" id="src_scd_day_reg_dept" name="src_scd_day_reg_dept"  />
		<input type="hidden" id="src_scd_day_reg_emp_num" name="src_scd_day_reg_emp_num"  />
					
				<table border="0" width="1000"  height="80"  id="idPrint" >	
					<tr>
						<td>
							<!----------------- SEARCH Hearder Start	 ----------------->
							<div id="ext-comp-1002" class=" x-panel x-form-label-left" style="margin-top: 0.0em;">
								<div class="x-panel-tl">
									<div class="x-panel-tr">
										<div class="x-panel-tc">
											<div id="ext-gen4" class="x-panel-header x-unselectable" style="-moz-user-select: none;">
												<span id="ext-gen8" class="x-panel-header-text">개인별 일정 검색</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!----------------- SEARCH Hearder END	 ----------------->
							<!----------------- SEARCH Field Start	 ----------------->
							<div class="x-panel-bwrap" >
								<div class="x-panel-ml">
									<div class="x-panel-mr">
										<div class="x-panel-mc" >
											<table border="0" width="100%">
												
											<%-- 1 Row Start --%>
									    		<tr> 
													<td width="185px">
														<div tabindex="-1" class="x-form-item " >
															<label class="x-form-item-label" style="width: auto;" for="src_sup_emp_name" >직원검색 :</label>
															<div style="padding-left: 0px;" class="x-form-element">
																<input type="text" readonly="readonly" onclick="fnEmployeePop()" name="src_scd_day_reg_emp_name" id="src_scd_day_reg_emp_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
															</div>
														</div>
													</td>
													<td width="30px"><div tabindex="-1" class="x-form-item " ><div style="padding-left: 0px;" class="x-form-element"><div style="padding-left: 0px;" ><img align="center" id="src_sup_emp_btn" name="src_sup_emp_btn" alt="" src="/resource/images/bass_1st/icon_src1.gif" style="cursor: hand;"></div></div></div></td> 
													<td>
														<div>
															<input type="text" readonly="readonly" onclick="fnEmployeePop()" name="src_scd_day_reg_dept_name" id="src_scd_day_reg_dept_name" autocomplete="off" size="19" class=" x-form-text x-form-field" style="width: auto;">
														</div>
													</td>
													<td align="right">
														<table>
															<tr>
																<td>
																<table border="0" cellspacing="0" class="x-btn  x-btn-noicon" style="width: 50px;">
																	<tbody class="x-btn-small x-btn-icon-small-left">
																		<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
																		<tr><td class="x-btn-ml"><i>&nbsp;</i></td><td class="x-btn-mc"><em unselectable="on" class=""><button type="button" id="searchBtn" class=" x-btn-text">검색하기</button></em></td><td class="x-btn-mr"><i>&nbsp;</i></td></tr>
																		<tr><td class="x-btn-bl"><i>&nbsp;</i></td><td class="x-btn-bc"></td><td class="x-btn-br"><i>&nbsp;</i></td></tr>
																	</tbody>
																</table>
																</td><td width="1"></td><td>
																<table border="0" cellspacing="0" class="x-btn  x-btn-noicon" style="width: width: 50px;;">
																	<tbody class="x-btn-small x-btn-icon-small-left">
																		<tr><td class="x-btn-tl"><i>&nbsp;</i></td><td class="x-btn-tc"></td><td class="x-btn-tr"><i>&nbsp;</i></td></tr>
																		<tr><td class="x-btn-ml"><i>&nbsp;</i></td><td class="x-btn-mc"><em unselectable="on" class=""><button type="button" id="searchClearBtn" class=" x-btn-text">나의일정</button></em></td><td class="x-btn-mr"><i>&nbsp;</i></td></tr>
																		<tr><td class="x-btn-bl"><i>&nbsp;</i></td><td class="x-btn-bc"></td><td class="x-btn-br"><i>&nbsp;</i></td></tr>
																	</tbody>
																</table>
																</td>
															</tr>
														</table>
													</td>
												</tr> 
											</table>
										</div>
									</div>
								</div>
							</div>
							<div id="" class="x-panel-bl x-panel-nofooter"><div class="x-panel-br"><div class="x-panel-bc"></div></div></div>
							<!----------------- SEARCH Field End	 ----------------->	 
						</td>
					</tr>
				</table>
			</form>
			</c:when>
		</c:choose>
		<iframe src="/com/calendar/calendar.sg?calMon=<%=request.getParameter("calMon") %>" style="width:1000;height:650" frameborder="0" scrolling="auto" name="ifrSrc" id="ifrSrc"></iframe>     
	</body>
 
</html>