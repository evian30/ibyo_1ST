<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/web/jsp/sgis-top-inc.jsp" %>
<body>
	<table border="0" width="900" height="200">
		<tr>
			<!----------------- DETAIL START ----------------->
			<td valign="top">
				<div class=" x-panel x-form-label-left" style="width:100%;">
				
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<center><span class="x-panel-header-text">공통코드 상세내용</span></center>
								</div>
							</div>
						</div>
					</div>
					<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									<form name="detailForm" id='detailForm'  method="POST" class="x-panel-body x-form" style="padding: 5px 5px 0pt; width: 480px; height: 370px;">
						 	
					 <table border="0" width="100%" style="font-size: 12px" >
						<tr>
							<td colspan="4" align="right">
								<!-- 신규 버튼 시작 -->
								<div tabindex="-1" class="x-form-item " >
									<table cellspacing="0" class="x-btn  x-btn-noicon" style="width: 75px;">
										<tbody class="x-btn-small x-btn-icon-small-left">
											<tr>
												<td class="x-btn-tl">
													<i>&nbsp;</i>
												</td>
												<td class="x-btn-tc">
												</td>
												<td class="x-btn-tr">
													<i>&nbsp;</i>
												</td>
											</tr>
											<tr>
												<td class="x-btn-ml">
													<i>&nbsp;</i>
												</td>
												<td class="x-btn-mc">
													<em unselectable="on" class="">
														<button type="button" id="detailClearBtn" class=" x-btn-text">신규</button>
													</em>
												</td>
												<td class="x-btn-mr">
													<i>&nbsp;</i>
												</td>
											</tr>
											<tr>
												<td class="x-btn-bl">
													<i>&nbsp;</i>
												</td>
												<td class="x-btn-bc">
												</td>
												<td class="x-btn-br">
													<i>&nbsp;</i>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- 신규 버튼 끝 -->
							</td>
						</tr>
						<tr>
							<td>
<!-- 컬럼 시작 -->
<div class="x-column-inner" style="width: 100%;">

<!-- 첫번째 컬럼 시작 -->
<div class=" x-panel x-column" style="width: 50%;">
	<div class="x-panel-bwrap" >
		<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="group_code" >그룹코드:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="group_code" id="group_code" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="com_code_name" >코드명:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="com_code_name" id="com_code_name" autocomplete="off" size="15" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_01" >참조값1:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_01" id="ref_val_01" autocomplete="off" size="15" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_02" >참조값2:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_02" id="ref_val_02" autocomplete="off" size="15" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_03" >참조값3:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_03" id="ref_val_03" autocomplete="off" size="15" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_04" >참조값4:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_04" id="ref_val_04" autocomplete="off" size="15" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="ref_val_05" >참조값5:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="ref_val_05" id="ref_val_05" autocomplete="off" size="15" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item " >
				<!-- 라디오 버튼 필드 시작 -->
				<div tabindex="-1" class="x-form-item ">
					<label class="x-form-item-label" style="width: 80px;">사용여부:</label>
					<div style="padding-left: 10px;" class="x-form-element">
						<div class=" x-form-radio-group x-column-layout-ct x-form-field" style="width: 70px;">
							<div class="x-column-inner" style="width: 70px;">
								
				<!-- 첫번째 라디오 버튼-->	
								<div class=" x-column" style="width: 70px;">
									<div tabindex="-1" class="x-form-item  x-hide-label" >
											<div class="x-form-check-wrap" style="width: 70px;">
												<input type="radio" name="system_code_yn" id="system_code_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
												<label class="x-form-cb-label" for="use_yn1" >예</label>
											</div>
										<div class="x-form-clear-left">
										</div>
									</div>
								</div>
				<!-- 두번번째 라디오 버튼-->
								<div class=" x-column" style="width: 100px;">
									<div tabindex="-1" class="x-form-item  x-hide-label" >
										
											<div class="x-form-check-wrap" style="width: 100px;">
												<input type="radio" name="system_code_yn" id="system_code_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
												<label class="x-form-cb-label" for="use_yn2" >아니오</label>
											</div>
										
										<div class="x-form-clear-left">
										</div>
									</div>
								</div>
								
								<div class="x-clear" ></div>
							</div>
						</div>
					</div>
					<div class="x-form-clear-left">
					</div>
				</div>
				<!-- 라디오 버튼 필드 끝 -->
			</div>
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="final_mod_id" >최종변경자:</label>
				<div style="padding-left: 80px;;" class="x-form-element">
					<input type="text" name="final_mod_id" id="final_mod_id" autocomplete="off" size="15" class=" x-form-text x-form-field" style="auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 첫번째 컬럼 끝 -->
<!-- 두번째 컬럼 시작 -->
<div class=" x-panel x-column" style="width: 50%;">
	<div class="x-panel-bwrap" >
		<div class="x-panel-body x-panel-body-noheader" style="width: 100%;">
			<div tabindex="-1" class="x-form-item " >
				<label class="x-form-item-label" style="width: auto;" for="com_code" >코드:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="com_code" id="com_code" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="sort_num" >정렬순서:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="sort_num" id="sort_num" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_01" >참조명1:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_01" id="ref_name_01" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_02" >참조명2:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_02" id="ref_name_02" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_03" >참조명3:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_03" id="ref_name_03" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_04" >참조명4:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_04" id="ref_name_04" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="ref_name_05" >참조명5:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="ref_name_05" id="ref_name_05" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
			<div tabindex="-1" class="x-form-item ">
				<!-- 라디오 버튼 필드 시작 -->
				<div tabindex="-1" class="x-form-item ">
					<label class="x-form-item-label" style="width: 80px;">사용여부:</label>
					<div style="padding-left: 10px;" class="x-form-element">
						<div class=" x-form-radio-group x-column-layout-ct x-form-field" style="width: 70px;">
							<div class="x-column-inner" style="width: 70px;">
								
				<!-- 첫번째 라디오 버튼-->	
								<div class=" x-column" style="width: 70px;">
									<div tabindex="-1" class="x-form-item  x-hide-label" >
											<div class="x-form-check-wrap" style="width: 70px;">
												<input type="radio" name="use_yn" id="use_yn1" autocomplete="off" class=" x-form-radio x-form-field" value="Y">
												<label class="x-form-cb-label" for="use_yn1" >예</label>
											</div>
										<div class="x-form-clear-left">
										</div>
									</div>
								</div>
				<!-- 두번번째 라디오 버튼-->
								<div class=" x-column" style="width: 100px;">
									<div tabindex="-1" class="x-form-item  x-hide-label" >
										
											<div class="x-form-check-wrap" style="width: 100px;">
												<input type="radio" name="use_yn" id="use_yn2" autocomplete="off" class=" x-form-radio x-form-field" value="N">
												<label class="x-form-cb-label" for="use_yn2" >아니오</label>
											</div>
										
										<div class="x-form-clear-left">
										</div>
									</div>
								</div>
								
								<div class="x-clear" ></div>
							</div>
						</div>
					</div>
					<div class="x-form-clear-left">
					</div>
				</div>
				<!-- 라디오 버튼 필드 끝 -->
			</div>
			<div tabindex="-1" class="x-form-item ">
				<label class="x-form-item-label" style="width: auto;" for="final_mod_date" >최종변경일자:</label>
				<div style="padding-left: 80px;" class="x-form-element">
					<input type="text" name="final_mod_date" id="final_mod_date" autocomplete="off" size="15" class=" x-form-text x-form-field" style="width: auto;">
				</div>
				<div class="x-form-clear-left">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 두번째 컬럼 끝 -->
</div>
<!-- 컬럼 끝 -->
</td>
</tr>
					</table>				
				</form>
				</div>
				</div>
				</div>
				</div>
			</td>
			<!----------------- DETAIL END ----------------->
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" id="saveBtn" name="saveBtn" value="등록" />
				<input type="button" id="updateBtn" name="updateBtn" value="수정" />
			</td>
		</tr>
	</table>

<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>