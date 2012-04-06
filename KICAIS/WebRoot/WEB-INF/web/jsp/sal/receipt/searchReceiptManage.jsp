<%--
  Class Name  : purManager.jsp
  Description : 구매관리관리
  Modification Information
 
      수정일                   수정자                 수정내용
  -------      --------    ---------------------------
  2011. 3. 25   이재철            최초 생성   
  
  author   : 이재철
  since    : 2011. 3. 28.
  version  : 1.0
   
  Copyright (C) 2011 by KICA All right reserved.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/web/jsp/common/inc/commonInc.jsp" %>
<script type="text/javascript" src="/resource/common/js/grid/grid_1st.js"></script>

<link rel="stylesheet" type="text/css" href="/resource/common/css/Receipt.css" />

<script type="text/javascript">
/***************************************************************************
 * 초기값 설정
 ***************************************************************************/
var	gridHeigth_1st	=	"435";
var	gridWidth_1st;
var	gridTitle_1st   =	"세금계산서 발행 정보"; 
var	render_1st		=	"render_1st";
var pageSize_1st	=	15;
var limit_1st		=	pageSize_1st;
var start_1st		=	0;
var proxyUrl_1st	= 	"/sal/receipt/result_1st.sg";

/***************************************************************************
 * Grid의 컬럼 설정 PUR_TYPE_NAME
 ***************************************************************************/
var userColumns_1st =  [
					{header: "프로젝트ID",  				width: 80 ,sortable: true, dataIndex: 'PJT_ID'				}
					,{header: "프로젝트이름",  			width: 80 ,sortable: true, dataIndex: 'PJT_NAME'			}
					,{header: "세금계산서ID",  			width: 80 ,sortable: true, dataIndex: 'TAX_ID'				}
					,{header: "매입매출구분코드", 			width: 80 ,sortable: true, dataIndex: 'PUR_SAL_TYPE_CODE'	, hidden : true}
					,{header: "매(입)출ID",  				width: 80 ,sortable: true, dataIndex: 'PUR_SAL_ID'			, hidden : true}
					,{header: "일련번호", 				width: 80 ,sortable: true, dataIndex: 'TAX_INFO_SEQ'		, hidden : true}
					,{header: "공급자사업자등록번호",  		width: 80 ,sortable: true, dataIndex: 'SUP_BIZ_NUM'			, hidden : true}
					,{header: "공급자상호",  				width: 80 ,sortable: true, dataIndex: 'SUP_BIZ_NAME'		, hidden : true}
					,{header: "공급자대표자명", 			width: 80 ,sortable: true, dataIndex: 'SUP_BIZ_CEO'			, hidden : true}
					,{header: "공급자사업장주소",  		width: 80 ,sortable: true, dataIndex: 'SUP_BIZ_ADDR'		, hidden : true}
					,{header: "공급자업태",  				width: 80 ,sortable: true, dataIndex: 'SUP_BIZ_CONDITION'	, hidden : true}
					,{header: "공급자종목", 				width: 80 ,sortable: true, dataIndex: 'SUP_BIZ_ITEM'		, hidden : true}
					,{header: "거래처코드",  				width: 80 ,sortable: true, dataIndex: 'CUSTOM_CODE'			, hidden : true}
					,{header: "공급받는자상호",  			width: 80 ,sortable: true, dataIndex: 'DEM_BIZ_NAME'		}
					,{header: "공급받는자사업자등록번호",	width: 80 ,sortable: true, dataIndex: 'DEM_BIZ_NUM'			}
					,{header: "공급받는자대표자명",  		width: 80 ,sortable: true, dataIndex: 'DEM_BIZ_CEO'			, hidden : true}
					,{header: "공급받는자사업장주소", 		width: 80 ,sortable: true, dataIndex: 'DEM_BIZ_ADDR'		, hidden : true}
					,{header: "공급받는자업태",  			width: 80 ,sortable: true, dataIndex: 'DEM_BIZ_CONDITION'	, hidden : true}
					,{header: "공급받는자업종",			width: 80 ,sortable: true, dataIndex: 'DEM_BIZ_ITEM'		, hidden : true}
					,{header: "작성일자",  				width: 80 ,sortable: true, dataIndex: 'PREPARE_DATE'		}
					,{header: "공급가액",  				width: 80 ,sortable: true, dataIndex: 'SUP_PRICE'			}
					,{header: "세액", 					width: 80 ,sortable: true, dataIndex: 'TAX_AMT'				}
					,{header: "비고",  					width: 80 ,sortable: true, dataIndex: 'NOTE'				, hidden : true}
					,{header: "영수청구구분코드",			width: 80 ,sortable: true, dataIndex: 'REC_DEM_TYPE_CODE'	, hidden : true}
					,{header: "과세구분코드",  			width: 80 ,sortable: true, dataIndex: 'TAX_TYPE_CODE'		, hidden : true}
					,{header: "전자세금계산서상태코드",  	width: 80 ,sortable: true, dataIndex: 'TAX_STATUS_CODE'		, hidden : true}
					,{header: "보내는 사람 E-Mail", 		width: 80 ,sortable: true, dataIndex: 'SENDER_EMAIL'		, hidden : true}
					,{header: "받는 사람 E-Mail",  		width: 80 ,sortable: true, dataIndex: 'RECIEVER_EMAIL'		, hidden : true}
					,{header: "작성사유구분코드",			width: 80 ,sortable: true, dataIndex: 'PREPARE_RESON_TYPE_CODE'	, hidden : true}
					,{header: "전자세금계산서번호",  		width: 80 ,sortable: true, dataIndex: 'ETAX_NO'				, hidden : true}
					,{header: "수정전전자세금계산서번호",  	width: 80 ,sortable: true, dataIndex: 'BEFORE_ETAX_NO'		, hidden : true}
					,{header: "ERP세금계산서번호",  		width: 80 ,sortable: true, dataIndex: 'ERP_TAX_NO'			}
					,{header: "최종변경자ID", 			width: 80 ,sortable: true, dataIndex: 'FINAL_MOD_ID'		, hidden : true}
					,{header: "최종변경일시",  			width: 80 ,sortable: true, dataIndex: 'FINAL_MOD_DATE'		, hidden : true}
					,{header: "최초등록일",				width: 80 ,sortable: true, dataIndex: 'REG_DATE'			, hidden : true}
					,{header: "최초등록자",				width: 80 ,sortable: true, dataIndex: 'REG_ID'				, hidden : true}
				   ];
		   
/***************************************************************************
 * 그리드 결과매핑 
 ***************************************************************************/
var mappingColumns_1st = [
					  {name: 'FLAG' 		    	, allowBlank: false}   // 상태 
					 ,{name: 'TAX_ID'				, allowBlank: false}	// 세금계산서ID
					 ,{name: 'PJT_ID'				, allowBlank: false}	// 프로젝트ID
					 ,{name: 'PJT_NAME'				, allowBlank: false}	// 프로젝트이름
					 ,{name: 'PUR_SAL_TYPE_CODE'	, allowBlank: false} 	// 매입매출구분코드  
					 ,{name: 'ERP_TAX_NO'			, allowBlank: false} 	// ERP세금계산서번호  
					 ,{name: 'PUR_SAL_ID'			, allowBlank: false} 	// 매(입)출ID
					 ,{name: 'TAX_INFO_SEQ'			, allowBlank: false} 	// 일련번호
					 ,{name: 'SUP_BIZ_NUM'			, allowBlank: false} 	// 공급자사업자등록번호
					 ,{name: 'SUP_BIZ_NAME'			, allowBlank: false} 	// 공급자상호
					 ,{name: 'SUP_BIZ_CEO'			, allowBlank: false} 	// 공급자대표자명
					 ,{name: 'SUP_BIZ_ADDR'			, allowBlank: false} 	// 공급자사업장주소
					 ,{name: 'SUP_BIZ_CONDITION'	, allowBlank: false} 	// 공급자업태
					 ,{name: 'SUP_BIZ_ITEM'			, allowBlank: false} 	// 공급자종목
					 ,{name: 'CUSTOM_CODE'			, allowBlank: false} 	// 거래처코드
					 ,{name: 'DEM_BIZ_NUM'			, allowBlank: false} 	// 공급받는자사업자등록번호
					 ,{name: 'DEM_BIZ_NAME'			, allowBlank: false} 	// 공급받는자상호
					 ,{name: 'DEM_BIZ_CEO'			, allowBlank: false} 	// 공급받는자대표자명
					 ,{name: 'DEM_BIZ_ADDR'			, allowBlank: false} 	// 공급받는자사업장주소
					 ,{name: 'DEM_BIZ_CONDITION'	, allowBlank: false} 	// 공급받는자업태
					 ,{name: 'DEM_BIZ_ITEM'			, allowBlank: false} 	// 공급받는자업종
					 ,{name: 'PREPARE_DATE'			, allowBlank: false} 	// 작성일자
					 ,{name: 'SUP_PRICE'			, allowBlank: false} 	// 공급가액
					 ,{name: 'TAX_AMT'				, allowBlank: false} 	// 세액
					 ,{name: 'NOTE'					, allowBlank: false} 	// 비고
					 ,{name: 'REC_DEM_TYPE_CODE'	, allowBlank: false} 	// 영수청구구분코드
					 ,{name: 'TAX_TYPE_CODE'		, allowBlank: false} 	// 과세구분코드
					 ,{name: 'TAX_STATUS_CODE'		, allowBlank: false} 	// 전자세금계산서상태코드
					 ,{name: 'SENDER_EMAIL'			, allowBlank: false} 	// 보내는 사람 E-Mail 
					 ,{name: 'RECIEVER_EMAIL'		, allowBlank: false} 	// 받는 사람 E-Mail 
					 ,{name: 'PREPARE_RESON_TYPE_CODE'	, allowBlank: false} 	// 작성사유구분코드
					 ,{name: 'ETAX_NO'				, allowBlank: false} 	// 전자세금계산서번호
					 ,{name: 'BEFORE_ETAX_NO'		, allowBlank: false} 	// 수정전전자세금계산서번호
					 ,{name: 'FINAL_MOD_ID'			, allowBlank: false} 	// 최종변경자ID
					 ,{name: 'FINAL_MOD_DATE'		, allowBlank: false} 	// 최종변경일시
					 ,{name: 'REG_DATE'				, allowBlank: false} 	// 최초등록일
					 ,{name: 'REG_ID' 				, allowBlank: false} 	// 최초등록자   
    				 ];

 /***************************************************************************
 * 그리드 클래스 필수 입력값 정의
 ***************************************************************************/

//그리드_1st 클릭시 Event
function fnGridOnClick_1st(store, rowIndex){
	var tax_id = fnFixNull(store.getAt(rowIndex).data.TAX_ID);
	
	//세금계산서 정보 가져오기
	Ext.Ajax.request({
		url: "/sal/receipt/searchReceiptItemInfo.sg" 
		,success: function(response){
					handleSuccessReceiptItemInfo(response, store, rowIndex);
		          }
		,failure: handleFailure 
		,params : {
				    tax_id			: tax_id
				  }				
	});
	
	
}



function fnPagingValue_1st(){
}

/***************************************************************************
 * 설  명 : 기능 정의 자바스크립트 함수 정의 시작
 **************************************************************************/
//필드 초기화
function fnInitValue(){
}

//검색하기 버튼
function fnSearch(){  	
	Ext.Ajax.request({   
		url: "/sal/receipt/result_1st.sg"
		,method : 'POST'   
		,success: function(response){						// 조회결과 성공시
					handleSuccess(response,GridClass_1st);
				 }   							
		,failure: handleFailure   	   						// 조회결과 실패시  
		,params : {					   						// 조회조건을 DB로 전송하기위해서 조건값 설정
						limit					: limit_1st 
					  , start					: start_1st
				  	  , src_pjt_id				: Ext.get('src_pjt_id').getValue()  
				  	  , src_prepare_date_from	: Ext.get('src_prepare_date_from').getValue() 
				  	  , src_prepare_date_to		: Ext.get('src_prepare_date_to').getValue()
					  , src_customer_code		: Ext.get('src_customer_code').getValue()
				  }				
	});  
	Ext.get("receiptResult").hide();
} 		


//저장버튼 클릭
function fnSave(str){  	
}  

/***************************************************************************
* 설  명 : 화면 초기값 설정
***************************************************************************/
function fnInitValue(){

}
/***************************************************************************
* EXTJS 시작
***************************************************************************/
Ext.onReady(function() {
	//검색 구매일자 FROM
	var startdt = new Ext.form.DateField({
	    applyTo: 'src_prepare_date_from',
		allowBlank: false,
		format:'Y-m-d'
	});
	//검색 구매일자 TO
	var enddt = new Ext.form.DateField({
	    applyTo: 'src_prepare_date_to',
		allowBlank: false,
		format:'Y-m-d'
	});
	Ext.get('searchBtn').on('click', function(e){	
		fnSearch();
		
	});
	
});

//세금계산서 품목 정보 가져오기
 function fnSearchReceiptItemInfo(tax_id){
	Ext.Ajax.request({
		url: "/sal/receipt/searchReceiptItemInfo.sg" 
		,success: function(response){
					handleSuccessReceiptItemInfo(response);
		          }
		,failure: handleFailure 
		,params : {
				    tax_id			: tax_id
				  }				
	});   
}

//세금계산서 양식에 값을 세팅
function handleSuccessReceiptItemInfo(response, store, rowIndex){
	var json = Ext.util.JSON.decode(response.responseText);

	Ext.get("receiptResult").show();
	//Ext.fly("temp").update("이재철", false);
	//var tax_id = fnFixNull(store.getAt(rowIndex).data.TAX_ID);

	//회사이름(DEM_BIZ_NAME)
	Ext.fly("dem_biz_name").update(fnFixNull(store.getAt(rowIndex).data.DEM_BIZ_NAME), false);
	
	//CEO이름(DEM_BIZ_CEO)
	Ext.fly("dem_biz_ceo").update(fnFixNull(store.getAt(rowIndex).data.DEM_BIZ_CEO), false);
	
	//주소(DEM_BIZ_ADDR)
	Ext.fly("dem_biz_addr").update(fnFixNull(store.getAt(rowIndex).data.DEM_BIZ_ADDR), false);
	
	//업종(DEM_BIZ_CONDITION)
	Ext.fly("dem_biz_condition").update(fnFixNull(store.getAt(rowIndex).data.DEM_BIZ_CONDITION), false);
	
	//업태(DEM_BIZ_ITEM)
	Ext.fly("dem_biz_item").update(fnFixNull(store.getAt(rowIndex).data.DEM_BIZ_ITEM), false);
	
	//발행일 YYYY MM DD (PREPARE_DATE)
	var prepareDate = fnFixNull(store.getAt(rowIndex).data.PREPARE_DATE);
	var year = prepareDate.substring(0,4);
	var month = prepareDate.substring(5,7);
	var day = prepareDate.substring(8,10);
	var validPrepareDate = year + " " + month + " " + day;
	Ext.fly("prepare_date").update(validPrepareDate, false);

	//공백
	var sup_price = fnFixNull(store.getAt(rowIndex).data.SUP_PRICE);
	var sup_price_len = sup_price.length;
	var blank = 11 - sup_price_len;
	Ext.fly("blank").update(blank, false);
	
	//공급가액(SUP_PRICE)
	Ext.fly("sup_price").update(fnFixNull(store.getAt(rowIndex).data.SUP_PRICE), false);
	
	//공급세액(TAX_AMT)
	Ext.fly("tax_amt").update(fnFixNull(store.getAt(rowIndex).data.TAX_AMT), false);
	
	//비고
	Ext.fly("note").update(fnFixNull(store.getAt(rowIndex).data.NOTE), false);
	
	//발행일 MM DD(item_prepare_date)
	Ext.fly("item_prepare_date").update((month+" "+day), false);
	
	//품목(ITEM_NAME)
	Ext.fly("item_name").update(json.data_1st[0].ITEM_NAME, false);
	
	//규격(STANDARD)
	Ext.fly("standard").update(json.data_1st[0].STANDARD, false);
	
	//수량(CNT)
	Ext.fly("cnt").update(json.data_1st[0].CNT, false);
	//단가(UNIT_PRICE)
	Ext.fly("unit_price").update(json.data_1st[0].UNIT_PRICE, false);
	
	//공급가액(AMT)
	Ext.fly("amt").update(json.data_1st[0].AMT, false);
	//세액(TAX)
	Ext.fly("tax").update(json.data_1st[0].TAX, false);
	
	
	
	
}
</script>

</head>
<body>
	<table border="0" width="1000px" height="100%">
		<tr>
			<td colspan="2">
				<!-- 상단 검색 제목 시작 -->
				<div class=" x-panel x-form-label-left" style="width: auto">
					<div class="x-panel-tl">
						<div class="x-panel-tr">
							<div class="x-panel-tc">
								<div class="x-panel-header x-unselectable" style="-moz-user-select: none;">
									<center><span class="x-panel-header-text">세금 계산서 발행 정보 검색</span></center>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- 상단 검색 제목 끝-->
				<!----------------- SEARCH START	 ----------------->
				<div id="calendar"></div>
				<form name="searchForm" id='searchForm' >
					<div class="x-panel-bwrap" >
						<div class="x-panel-ml">
							<div class="x-panel-mr">
								<div class="x-panel-mc" >
									<table border="0" width="100%"  style="font-size: 12px">
										<tr>
											<td width='18%'>
												<div tabindex="-1" class="x-form-item " >
													<div style="padding-left: 10px;" class="x-form-element">
													<label class="x-form-item-label" style="width: auto;" for="src_prepare_date_from">발행일자 :</label>
														<input type="text" name="src_prepare_date_from" id="src_prepare_date_from" size="10" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
												
											</td>
											<td width='18%'>
												<div tabindex="-1" class="x-form-item " >
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_prepare_date_to" id="src_prepare_date_to" autocomplete="off" size="10" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
												
											</td>
											<td>
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_customer_name">거래처 :</label>
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_customer_name" id="src_customer_name" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
														<input type="hidden" name="src_customer_code" id="src_customer_code" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
											</td>
											<td>
												<div tabindex="-1" class="x-form-item " >
													<label class="x-form-item-label" style="width: auto;" for="src_pjt_id">프로젝트ID :</label>
													<div style="padding-left: 10px;" class="x-form-element">
														<input type="text" name="src_pjt_id" id="src_pjt_id" autocomplete="off" size="15" class="x-form-text x-form-field" style="width: auto;">
													</div>
												</div>
											</td>
										</tr>
										
										<tr align="right">
											<td colspan="6">
												<input type="button" id="searchBtn" name="searchBtn" value="검색하기"/>
												<input type="button" id="searchClearBtn" name="searchClearBtn" value="조건해제"/>
											</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</form>
				<!----------------- SEARCH END	 ----------------->
			</td>
		</tr>
		<tr>
			<!----------------- GRID_1st START ----------------->
			<td colspan='2'>
				<div id="render_1st"></div>
			</td>
			<!----------------- GRID_1st END ----------------->
		</tr>
		<tr>
			<td colspan="2" align="center"  height="100%">
				<input type="button" id="saveBtn" name="saveBtn" value="등록" />
				<input type="button" id="updateBtn" name="updateBtn" value="수정" />
			</td>
		</tr>
		<tr id="receiptResult" style="display: none">
			<td colspan='2'>
				<div id="tax_wrap">
				  <h1 class="hide">세금계산서</h1>
				  <h2 class="hide">공급받는자 보관용</h2>
				  <h3 class="hide">공급자</h3>
				  <div id="provider1" class="item">
				    <div class="no">110-81-41568</div>
				    <div class="company">한국정보인증(주)</div>
				    <div class="name">고성학</div>
				    <div class="sign"><img src='http://asp.suninlaw.com/resource/upload/20100908/12839424580060.gif' alt="도장" width="59" /></div>
				    <div class="address">서울시 마포구 상암동 1605번지 누리꿈스퀘어 비즈니스타워 16층</div>
				    <div class="kind1">서비스</div>
				    <div class="kind2">정보처리</div>
				  </div>
				  <h3 class="hide">공급받는자</h3>
				  <div id="receiver1" class="item">
				    <div class="no">--</div>
				    <div class="company" id='dem_biz_name' ></div>
				    <div class="name" id='dem_biz_ceo'></div>
					<div class="sign"></div>
				    <div class="address" id='dem_biz_addr'></div>
					<div class="kind1" id='dem_biz_condition'></div>
				    <div class="kind2" id='dem_biz_item'></div>
				  </div>
				  <!-- -->
				  <div id="tax1" class="detail">
				   <div class="date" id="prepare_date"></div>
				    <div class="blank" id="blank"></div>
				    <div class="money" id="sup_price"></div>
				    <div class="tax" id="tax_amt"></div>
				    <div class="etc" id="note"></div>
				    <table border="0" cellpadding="0" cellspacing="0" class="list">
				      <tr>
				        <th style="width: 35px;">월일</th>
				        <th style="width: 130px;">품목</th>
				        <th style="width: 80px;">규격</th>
				        <th style="width: 40px;">수량</th>
				        <th style="width: 100px;">단가</th>
				        <th style="width: 120px;">공급가액</th>
				        <th style="width: 100px;">세액</th>
				        <th>비고</th>
				      </tr>
				      <tr>
				        <!-- 여기서부터 loop 시작 -->
				        <td id="item_prepare_date"></td>
				        <td id="item_name"></td>
				        <td id="standard"></td>
				        <td class="num" id="cnt"></td>
				        <td class="num" id="unit_price"></td>
				        <td class="num" id="amt"></td>
				        <td class="num" id="tax"></td>
				        <td id="item_note"></td>
				      </tr>
				      <!-- 여기까지 loop 끝 -->
				    </table>
				    <table border="0" cellpadding="0" cellspacing="0" class="info">
				      <tr>
				        <th style="width: 102px;">합계금액</th>
				        <th style="width: 102px;">현금</th>
				        <th style="width: 100px;">수표</th>
				        <th style="width: 100px;">어음</th>
				        <th style="width: 100px;">외상미수금</th>
				      </tr>
				      <tr>
				        <td class="num" ></td>
				        <td class="num"></td>
				        <td class="num"></td>
				        <td class="num"></td>
				        <td class="num"></td>
				      </tr>
				    </table>
				  </div>
				  <!-- 공급받는자 보관용 끝 -->
				  <hr class="hide" />
				  <!-- 공급자 보관용 시작 -->
				  <h2 class="hide">공급자 보관용</h2>
				  <h3 class="hide">공급자</h3>
				  <div id="provider2" class="item">
				    <div class="no">110-81-41568</div>
				    <div class="company">한국정보인증(주)</div>
				    <div class="name">고성학</div>
				    <div class="sign"><img src='http://asp.suninlaw.com/resource/upload/20100908/12839424580060.gif' alt="도장" width="59" /></div>
				    <div class="address">서울시 마포구 상암동 1605번지 누리꿈스퀘어 비즈니스타워 16층</div>
				    <div class="kind1">서비스</div>
				    <div class="kind2">정보처리</div>
				  </div>
				  <h3 class="hide">공급받는자</h3>
				  <div id="receiver2" class="item">
				    <div class="no">--</div>
				    <div class="company" id='dem_biz_name' ></div>
				    <div class="name" id='dem_biz_ceo'></div>
					<div class="sign"></div>
				    <div class="address" id='dem_biz_addr'></div>
					<div class="kind1" id='dem_biz_condition'></div>
				    <div class="kind2" id='dem_biz_item'></div>
				  </div>
				  <div id="tax2" class="detail">
				    <div class="date"></div>
				    <div class="blank"></div>
				    <div class="money"></div>
				    <div class="tax"></div>
				    <div class="etc"></div>
				    <table border="0" cellpadding="0" cellspacing="0" class="list">
				      <tr>
				        <th style="width: 35px;">월일</th>
				        <th style="width: 130px;">품목</th>
				        <th style="width: 80px;">규격</th>
				        <th style="width: 40px;">수량</th>
				        <th style="width: 100px;">단가</th>
				        <th style="width: 120px;">공급가액</th>
				        <th style="width: 100px;">세액</th>
				        <th>비고</th>
				      </tr>
				      <tr>
				        <!-- 여기서부터 loop 시작 -->
				        <td id="prepare_date"></td>
				        <td id="item_name"></td>
				        <td id="standard"></td>
				        <td class="num" id="cnt"></td>
				        <td class="num" id="unit_price"></td>
				        <td class="num" id="amt">0</td>
				        <td class="num" id="tax">0</td>
				        <td id="item_note"></td>
				      </tr>
				      <!-- 여기까지 loop 끝 -->
				    </table>
				    <table border="0" cellpadding="0" cellspacing="0" class="info">
				      <tr>
				        <th style="width: 102px;">합계금액</th>
				        <th style="width: 102px;">현금</th>
				        <th style="width: 100px;">수표</th>
				        <th style="width: 100px;">어음</th>
				        <th style="width: 100px;">외상미수금</th>
				      </tr>
				      <tr>
				        <td class="num">0</td>
				        <td class="num">0</td>
				        <td class="num">0</td>
				        <td class="num">0</td>
				        <td class="num">0</td>
				      </tr>
				    </table> 
				  </div>
			</td>
		</tr>
	</table>
</body>
<%@ include file="/WEB-INF/web/jsp/sgis-bottom-inc.jsp" %>