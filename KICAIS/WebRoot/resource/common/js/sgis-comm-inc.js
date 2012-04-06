/***************************************************************************
 * 함수명 : handleFailure(response)
 * 설  명 : Ajax리스트 성공처리
 * 인  자 : response
 * 리  턴 : 
 -------------------------------------------------------------------------
 사용법: fnSearch()에서 조회후 조회결과 실패시 success에서 호출
 사용예:	success: handleFailure
 -------------------------------------------------------------------------
 참  조: 
***************************************************************************/ 
function handleSuccess(response, obj, div) { 
	// 조회된 결과를 Grid에 설정
	var json = Ext.util.JSON.decode(response.responseText);
	obj.store.loadData(json);

	// 메세지
	if(div !== undefined){

		Ext.MessageBox.show({   
			title: "",   
			msg: "처리되었습니다.",   
			buttons: Ext.MessageBox.OK,   
			icon: Ext.MessageBox.INFO   
		}); 
	}
}   

/***************************************************************************
 * 함수명 : handleFailure(response)
 * 설  명 : Ajax리스트 실패처리
 * 인  자 : response
 * 리  턴 : 
 -------------------------------------------------------------------------
 사용법: fnSearch()에서 조회후 조회결과 실패시 failure에서 호출
 사용예:	failure: handleFailure
 -------------------------------------------------------------------------
 참  조: 
***************************************************************************/ 
function handleFailure(response){   
	Ext.MessageBox.show({   
		title	: "에러",   
		msg		: "에러가 발생하였습니다.",   
		buttons	: Ext.MessageBox.OK,   
		icon	: Ext.MessageBox.ERROR   
	});   
}  

/***************************************************************************
 * 함수명 : fnFixNull(value)
 * 설  명 : 컬럼의 값이 null일경우 ""로 변환
 * 인  자 : 
 * 리  턴 : 
 -------------------------------------------------------------------------
 사용법: fnFixNull(value)
 사용예:
 -------------------------------------------------------------------------
 참  조: 
***************************************************************************/ 
function fnFixNull(value){
	var type = typeof(value);
	if(type == "string" || (type =="object" && value instanceof String)){
		value = value.trim();
	}
	return (value == null || value == "null" || value == "undefined")? "" : String(value);
}

/***************************************************************************
 * 함수명 : fnRadioVal(obj)
 * 설  명 : 라디오버튼에 선택된 value값을 반환
 * 인  자 : 
 * 리  턴 : 
 -------------------------------------------------------------------------
 사용법: fnRadioVal(obj)
 사용예:
 -------------------------------------------------------------------------
 참  조: 
***************************************************************************/ 
function fnRadioVal(obj){
	
	var val = '';
	
	for(i=0 ; i < obj.length ; i++){
		if(obj[i].checked == true){
			val = obj[i].value;
		}
	}
	
	return val;
}



/***************************************************************************
 * 함수명 : getPost(response)
 * 설  명 : Ajax리스트 실패처리
 * 인  자 : response
 * 리  턴 : 
 -------------------------------------------------------------------------
 사용법: fnSearch()에서 조회후 조회결과 실패시 failure에서 호출
 사용예:	failure: handleFailure
 -------------------------------------------------------------------------
 참  조: 
***************************************************************************/ 
 function getPost(cont, addr, schTxt){	
	postCont = cont;
	g_addr = addr;
	g_schTxt = schTxt;
	var url = "/sgportal/post/searchZipForm.sg";
	
	window.open(url, "zipcode", "width=620, height=448, left=250, top=100, scrollbars=yes, resizable=no, menubar=no");
}











	//에디트 그리드에서 글자 색 변경과 cursor:hand renderer
 	//사용방법: edit grid의 Header 부분에  'renderer:change' 요거 추가
	function changeBLUE(val){
		if(val==null || val==""){
			val="";
		}
	    return '<span style="color:blue; cursor:hand;cursor:pointer;background-color:">' + val + '</span>';
	    return val;
	}
	
	function korMoneyChangeBLUE(val){
		if(val==null || val==""){
			val="";
		}
		
		val = (Math.round((val-0)*100))/100;
            val = (val == Math.floor(val)) ? val + "" : ((val*10 == Math.floor(val*10)) ? val + "0" : val);
            val = String(val);
            var ps = val.split('.'),
                whole = ps[0],
                sub = ps[1] ? '.'+ ps[1] : '',
                r = /(\d+)(\d{3})/;
            while (r.test(whole)) {
                whole = whole.replace(r, '$1' + ',' + '$2');
            }
            val = whole + sub;
            if (val.charAt(0) == '-') {
                return '-' + val.substr(1);
            }
           // return "" +  val;
        
	    return '<span style="color:blue; cursor:hand;cursor:pointer;background-color:">' + val + '</span>';
	    return val;
	}
	
	function korMoneyChangeRED(val){
		if(val==null || val==""){
			val="";
		}
		
		val = (Math.round((val-0)*100))/100;
            val = (val == Math.floor(val)) ? val + "" : ((val*10 == Math.floor(val*10)) ? val + "0" : val);
            val = String(val);
            var ps = val.split('.'),
                whole = ps[0],
                sub = ps[1] ? '.'+ ps[1] : '',
                r = /(\d+)(\d{3})/;
            while (r.test(whole)) {
                whole = whole.replace(r, '$1' + ',' + '$2');
            }
            val = whole + sub;
            if (val.charAt(0) == '-') {
                return '-' + val.substr(1);
            }
           // return "" +  val;
        
	    return '<span style="color:red; cursor:hand;cursor:pointer;background-color:">' + val + '</span>';
	    return val;
	}
 

 
	//현재시간 가져오는 함수
	function getTimeStamp() {
	  var today = new Date();	
	  var todayYMD =
	    leadingZeros(today.getFullYear(), 4) + '-' + leadingZeros(today.getMonth() + 1, 2) + '-' + leadingZeros(today.getDate(), 2) + ' ' ;
	    /*
	    leadingZeros(today.getHours(), 2) + ':' + leadingZeros(today.getMinutes(), 2) + ':' + leadingZeros(today.getSeconds(), 2);
	    */
	  return todayYMD;
	}
	
	function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();
	
	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
	} 


	// 클래스 > 월의 마지막 일자를 지정한다
	function month_array(m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11)
	{
		this[0] = m0;
		this[1] = m1;
		this[2] = m2;
		this[3] = m3;
		this[4] = m4;
		this[5] = m5;
		this[6] = m6;
		this[7] = m7;
		this[8] = m8;
		this[9] = m9;
		this[10] = m10;
		this[11] = m11;
	}

	// 날짜 형식인가를 본다 isDate에 의해서 사용된다
	function isDD(yyyy, mm, value) 
	{ 
		var result = false; 
		var monthDD = new month_array(31,28,31,30,31,30,31,31,30,31,30,31); 
		var im = eval(mm) - 1; 
		if(value.length != 2)   return false; 
		if(isNaN(parseInt(value, 10)))    return false; 
		if(((yyyy % 4 == 0) && (yyyy % 100 != 0)) || (yyyy % 400 == 0)) 
		{ 
			monthDD[1] = 29; 
		} 
		var dd = eval(value); 
		if((0 < dd) && (dd <= monthDD[im]))     result = true; 
		return result; 
	} 

	// 2자리 월형식인가 본다 isDate에 의해서 사용된다
	function isMM(value) 
	{ 
			return((value.length > 0) && (!isNaN(parseInt(value, 10))) && (0 < eval(value)) && (eval(value) < 13)); 
	} 

	// 4자리 년형식인가 본다
	function isYYYY(value) 
	{ 
		return((value.length == 4) && (!isNaN(parseInt(value, 10))) && (value != "0000")); 
	} 

	// 날짜 형식인가를 묻는다
	// input "YYYYMM"
	function isDate(value) 
	{ 
		value = value.replace("-", "")
		value = value.replace(".", "")
		if (value.length != 8) return false;
			var     year  = value.substring(0,4); 
			var     month = value.substring(4,6); 
			var     day   = value.substring(6,8); 
			return( isYYYY(year) && isMM(month) && isDD(year,month,day) );  
	} 

	/*****************************************************************
     * 함수명 : isValidDate
     * 기   능 : 날짜형식으로 지정되었는지를 검사
    ******************************************************************/
	function isValidDate(obj, iDate)
	{
		//alert(iDate);
		var str = iDate ? iDate : obj.value;
		if(str=='') return;
		var isDateValue = false;

		// 정규식을 이용. 1차적으로 날짜형식 여부를 판단.
		// YYYYMMDD
		var pattern = /^[1|2][0-9]{3}([0][0-9]|[1][0-2])([0-2][0-9]|[3][0-1])/;
		if(pattern.test(str)){
			isDateValue = true;
			str = str.substr(0, 4)+""+str.substr(4,2)+""+str.substr(6,2);
			//alert("YYYYMMDD"+str);
		} else {
			// YYYY.MM.DD
			var pattern = /^[1|2][0-9]{3}[\.]([0][0-9]|[1][0-2])[\.]([0-2][0-9]|[3][0-1])/;
			if(pattern.test(str)){
				isDateValue = true;
				str = str.substr(0, 4)+""+str.substr(5,2)+""+str.substr(8,2)
				//alert("YYYY.MM.DD"+str);
			} else {
				// YYYY-MM-DD
				var pattern = /^[1|2][0-9]{3}[\-]([0][0-9]|[1][0-2])[\-]([0-2][0-9]|[3][0-1])/;
				if(pattern.test(str)){
					isDateValue = true;
					str = str.substr(0, 4)+""+str.substr(5,2)+""+str.substr(8,2)
					//alert("YYYY.MM.DD"+str);
				}
			}
		}

		// 정규식체크 통과시. 2차적으로 정상적인 년/월/일이 입력되었는지 유효성 판단.
		isDateValue = isDateValue ? isDate(str) : false;

		if(!isDateValue)
		{  
			Ext.Msg.alert('확인', '유효한 날짜가 아닙니다.');
			obj.value = '';
			obj.focus();
			return false;
		}
		else
		{
			//alert(str);
			convertDataString(obj, str);
		}
		return true;
	}
	

	/*****************************************************************
     * 함수명 : addDate
     * 기   능 : 파라미터로 받은 날자에 년,월,일을 가감하여 반환한다.
    ******************************************************************/
	function addDate(iDate, addType, addValue)
	{
		if(!addValue||addValue==''||addValue==0) return iDate;

		iDate = iDate.replace(/\./g,"")

		var newYear = parseFloat(iDate.substring(0,4))+parseFloat(addType.toUpperCase()=='Y' ? addValue : 0);
		var newMonth = parseFloat(iDate.substring(4,6))-1+parseFloat(addType.toUpperCase()=='M' ? addValue : 0);
		var newDate = parseFloat(iDate.substring(6))+parseFloat(addType.toUpperCase()=='D' ? addValue : 0);
		var oDate = new Date(newYear, newMonth, newDate);

		var tDate = '';
		var realMonth = parseFloat(oDate.getMonth()) + 1;
		tDate+=oDate.getFullYear();
		tDate+=(realMonth<10) ? '0'+realMonth : realMonth;
		tDate+=(oDate.getDate()<10) ? '0'+parseFloat(oDate.getDate()) : parseFloat(oDate.getDate());

		return tDate;
	}

	/*****************************************************************
     * 함수명 : replaceAll
     * 기   능 : 문자대체  
    ******************************************************************/
    String.prototype.replaceAll = function(targetStr,replaceStr)
    { 
	    thisStr = this.toString(); 
	    var idx = thisStr.indexOf( targetStr ); 
	    while ( idx > -1 ) 
	    { 
	        thisStr = thisStr.replace( targetStr, replaceStr ); 
	        idx = thisStr.indexOf( targetStr ); 
	    } 
	    return thisStr; 
	} 
	
    /**********************************************
     * 함수명 : nextVal
     * 기    능 : 다음 폼으로 자동 이동 
    ***********************************************/
    function nextVal(ths,nxt,flag)
    {
        if(ths.value.length == flag)
        {
            nxt.focus();
            return;
        }
    } 
    
    /**********************************************
     * 함수명 : emptyValueID
     * 기   능 : 사업자 등록번호를 리셋한다.
     **********************************************/
    function emptyValueID()
    {
        var t = document.registForm;
        t.business_number.value = '';
    }
    
    /**********************************************
     * 함수명 : isLength()
     * 기   능 : 문자열의 길이를 체크한다.
    ***********************************************/
    function isLength(f,len,name)
    {
        if(f.value.length>len)
        {
            alert(name+'의 길이는 '+len+'을 넘을수 없습니다.');
            f.value=f.value.substring(0,len);
            f.focus();
            return false;
        }
         return true;
    }

    /**********************************************
     * 함수명 : isNull
     * 기   능 : 널값을 체크
     * 기능추가 : 0 허용여부 추가 - Mong
    ***********************************************/
    //공백 폼 체크
    function isNull(field, name, denialZero) 
    { 
    	if(!denialZero) denialZero = false;

        if (field.value.trim() == '') 
        { 
            alert(name + '란을 입력해 주세요.');
            if(field) field.focus(); 
            return false; 
        }
        if (denialZero && ("0" == field.value.trim() || 0 == field.value.trim())){
            alert(name + '란은 0을 입력 할 수 없습니다.');
            if(field) field.focus(); 
            return false; 
        }
        return true; 
    }
    
    
    /**********************************************
     * 함수명 : isNullFocus
     * 기   능 : 널값을 체크(포커스 제거)
    ***********************************************/
    //공백 폼 체크
    function isNullNotFocus(field, name) 
    { 
        if (field.value.trim() == '') 
        { 
            alert(name + '란을 입력해 주세요.');
            //if(field) field.focus(); 
            return false; 
        } 
        return true; 
    }
    
    /***************************************************
     * 함수명 : isEqualParameter(field1,field2)
     * 기   능 : 두 필드의 값이 동일한지 검사
    ****************************************************/ 
    function isEqualParameter(field1,field2,name)
    {
        if(field1.value != field2.value)
        {
            alert(name+'의 값이 일치하지 않습니다.');
            if(field1) field1.focus();
            return false;
        }
        return true;
    }
    
    /**********************************************
     * 함수명 : justNum
     * 기    능 : 문자열이 숫자로만 구성되었는지 체크
    ***********************************************/
    function justNum(field,name) 
    { 
        var valid = '0123456789';
        var temp; 
    
        for (var i=0; i<field.value.length; i++) 
        { 
            temp = '' + field.value.substring(i, i+1); 
            if (valid.indexOf(temp) == "-1") 
            {
                alert(name + '란은 숫자로만 입력해 주세요.'); 
                field.value=field.value.substring(0,(field.value.length-1));
                //field.value='';
                field.focus();
                return false; 
            }
        } 
        return true; 
    }
    
    /**********************************************
     * 함수명 : justNumComma
     * 기    능 : 문자열이 숫자로만 구성되었는지 체크
    ***********************************************/
    function justNumComma(field,name) 
    { 
        var valid = '0123456789.';
        var temp; 
    
        for (var i=0; i<field.value.length; i++) 
        { 
            temp = '' + field.value.substring(i, i+1); 
            if (valid.indexOf(temp) == "-1") 
            {
                alert(name + '란의 형식은 소숫점을 포함한 숫자입니다.'); 
                field.value=field.value.substring(0,(field.value.length-1));
                //field.value='';
                field.focus();
                return false; 
            }
        } 
        return true; 
    }
    
    /**********************************************
     * 함수명 : isEngNum
     * 기    능 : 문자열이 영문과 숫자로만 구성되었는지 체크
    ***********************************************/
    function isEngNum(field,name) 
    { 
        var valid = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_';
        var temp; 
        //alert('연문자와숫자구분');
    
        for (var i=0; i<field.value.length; i++) 
        { 
            temp = '' + field.value.substring(i, i+1); 
            if (valid.indexOf(temp) == "-1") 
            {
                alert(name + '란은 영문자와 숫자로만 입력해 주세요.'); 
               // field.value=field.value.substring(0,(field.value.length-1));
                field.value=field.value;;
                field.focus();
                return false; 
            }
        } 
        return true; 
    }

     
    /*****************************************************************
     * 함수명 : trim
     * 기   능 : 공백제거  
    ******************************************************************/
    String.prototype.trim = function()
    {
        return this.replace(/(^\s*)|(\s*$)/gi, "");
    }

    /************************************************
     * 함수명 : isSelectBox
     * 기   능 : 셀렉트박스 공백 체크
    *************************************************/
    function isSelectBox(f,n)
    {
        if(f.options[f.selectedIndex].value=='' || f.selectedIndex<0) 
        {
            alert( n + '란을 선택해 주세요.'); 
            f.focus();
            return false;
        }
        else return true;
    }

    /************************************************
     * 함수명 : isChecked
     * 기   능 : 라디오/체크버튼의 선택여부 체크
    *************************************************/
    function isChecked(eleName,n)
    {
    	var ele = document.getElementsByName(eleName);
    	var isChked = false;

		// 대상이 존재하지 않을경우.
    	if(ele.length==0)
		{
			alert("대상이 올바르지 않습니다.");
			return false;
		}

    	for(var i=0;i<ele.length;i++)
    	{
			if(ele[i].checked)
			{
				isChked = true;
				break;
			}
		}
		if(!isChked)
		{
			alert( n + '란을 선택해 주세요.'); 
			ele[0].focus();
			return false;
		}

		return true;
    }

    /*****************************************
     * 함수명 : isValidEmail
     * 기   능 : E-mail검사하는 스크립트
    ******************************************/
    function isValidEmail(f,n, value)
    {
    	var strEmail = (value) ? value : f.value;

        if(isEmail(strEmail)==false) 
        {
            alert( n + '란을 바르게 입력해 주세요.'); 
            //f.value='';
            f.focus();
            return false;
        }
        else return true;

    }


    /*******************************************
     * 함수명 : isEmail
     * 기   능 : 이메일 정규식 검사
    ********************************************/
    function isEmail( email )
    {

		// 메일 포멧이면 true 아니면 false를 반환
		// 풀패턴 검색시 느려질 수 있는 문제의 해결을 위하여 4개의 정규식으로 나누어 비교한다.
		var emailEx1 = /[^@]+@[A-Za-z0-9_\-]+\.[A-Za-z]+/;
		var emailEx2 = /[^@]+@[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z]+/;
		var emailEx3 = /[^@]+@[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z]+/;
		var emailEx4 = /[^@]+@[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+\.[A-Za-z]+/;
		if(!emailEx1.test(email)){
			if(!emailEx2.test(email))
				if(!emailEx3.test(email))
					if(!emailEx4.test(email))
						return false;
		}
		else{
			return true;
		}

    }

    /*****************************************
     * 함수명 : BizCheck
     * 기   능 : 사업자 등록번호 체크
     *****************************************/
    function BizCheck(obj1, obj2, obj3)
    {
        biz_value = new Array(10);
        if (isBizInteger(obj1.value,3) == false)
        {
            obj1.focus();
            obj1.select();
            return false;
        }
        if (isBizInteger(obj2.value,2) == false) 
        {
            obj2.focus();
            obj2.select();
            return false;
        }
        if (isBizInteger(obj3.value,5) == false) 
        {
            obj3.focus();
            obj3.select();
            return false;
        }
        var objstring = obj1.value +"-"+ obj2.value +"-"+ obj3.value;
        var li_temp, li_lastid;
        if ( objstring.length == 12 ) 
        {
            biz_value[0] = ( parseFloat(objstring.substring(0 ,1)) * 1 ) % 10;
            biz_value[1] = ( parseFloat(objstring.substring(1 ,2)) * 3 ) % 10;
            biz_value[2] = ( parseFloat(objstring.substring(2 ,3)) * 7 ) % 10;
            biz_value[3] = ( parseFloat(objstring.substring(4 ,5)) * 1 ) % 10;
            biz_value[4] = ( parseFloat(objstring.substring(5 ,6)) * 3 ) % 10;
            biz_value[5] = ( parseFloat(objstring.substring(7 ,8)) * 7 ) % 10;
            biz_value[6] = ( parseFloat(objstring.substring(8 ,9)) * 1 ) % 10;
            biz_value[7] = ( parseFloat(objstring.substring(9,10)) * 3 ) % 10;
            li_temp = parseFloat(objstring.substring(10,11)) * 5 + "0";
            biz_value[8] = parseFloat(li_temp.substring(0,1)) + parseFloat(li_temp.substring(1,2));
            biz_value[9] = parseFloat(objstring.substring(11,12));
            li_lastid = (10 - ( ( biz_value[0] + biz_value[1] + biz_value[2] + biz_value[3] + biz_value[4] + biz_value[5] + biz_value[6] + biz_value[7] + biz_value[8] ) % 10 ) ) % 10;
            if (biz_value[9] != li_lastid) 
            {
                obj1.focus();
                obj1.select();
                return false;
            }
            else
            {
                return true;
            }
        }
        else 
        {
            obj1.focus();
            obj1.select();
            return false;
        }
    }

    /*********************************************
     * 함수명 : CheckBizNo()
     * 기   능 : 사업자 등록번호 체크
     * 변   수 : flag_01(3자리)
                    flag_02(2자리)
                    flag_03(7자리)
     **********************************************/
    function CheckBizNo(flag_01,flag_02,flag_03)
    { 
        if (BizCheck(flag_01,flag_02,flag_03) == false) 
        {
            alert( "올바른 사업자 등록번호가 아닙니다.\n다시 확인해 주시기 바랍니다." );
            //flag_01.value='';
            //flag_02.value='';
            //flag_03.value='';
            //flag_01.focus();
            return false;
        } else {
            return true;
        }
    }

    /******************************************
     * 함수명 : isBizInteger
     * 기   능 : 사업자 등록번호 구성 체크
     ******************************************/
    function isBizInteger(st,maxLength)
    {
        if (st.length == maxLength) 
        {
              for (j=0; j < maxLength; j++)
              {    
                if (((st.substring(j, j+1) < "0") || (st.substring(j, j+1) > "9")))
                    return false;
              }
        }
        else 
        {
            return false;
        }
        return true;
    }


    /*******************************************************
     * 함수명 : writeTelNo()
     * 기   능 : 지역번호를 세팅
    ********************************************************/
    function writeTelNo(fn)
    {
        var i = 0;
        var j = 0;
        fn.length = 17;
        fn.options[++i].text = '서울';
        fn.options[++j].value ='02';
        fn.options[++i].text = '부산';
        fn.options[++j].value ='051';
        fn.options[++i].text = '대구';
        fn.options[++j].value ='053';
        fn.options[++i].text = '인천';
        fn.options[++j].value ='032';
        fn.options[++i].text = '대전';
        fn.options[++j].value ='042';
        fn.options[++i].text = '광주';
        fn.options[++j].value ='062';
        fn.options[++i].text = '울산';
        fn.options[++j].value ='052';
        fn.options[++i].text = '경기';
        fn.options[++j].value ='031';
        fn.options[++i].text = '강원';
        fn.options[++j].value ='033';
        fn.options[++i].text = '경남';
        fn.options[++j].value ='055';
        fn.options[++i].text = '경북';
        fn.options[++j].value ='054';
        fn.options[++i].text = '전남';
        fn.options[++j].value ='061';
        fn.options[++i].text = '전북';
        fn.options[++j].value ='063';
        fn.options[++i].text = '충남';
        fn.options[++j].value ='041';
        fn.options[++i].text = '충북';
        fn.options[++j].value ='043';
        fn.options[++i].text = '제주';
        fn.options[++j].value ='064';
     }
     
     /****************************************************
      * 함수명 : writeHpNo()
      * 기   능 : 휴대전화 번호를 설정하는 기능
     *****************************************************/
     function writeHpNo()
     {
        var t = document.jointForm;
        var i = 0;
        var j = 0;
        t.hp_no1.length = 7;
        t.hp_no1.options[++i].text = '010';
        t.hp_no1.options[++j].value = '010';
        t.hp_no1.options[++i].text = '011';
        t.hp_no1.options[++j].value = '011';
        t.hp_no1.options[++i].text = '016';
        t.hp_no1.options[++j].value = '016';
        t.hp_no1.options[++i].text = '017';
        t.hp_no1.options[++j].value = '017';
        t.hp_no1.options[++i].text = '018';
        t.hp_no1.options[++j].value = '018';
        t.hp_no1.options[++i].text = '019';
        t.hp_no1.options[++j].value = '019';
     }
     

	/**********************************************
	 * 함수명 : alert_overmax
	 * 기 능 : 글자 수 넘으면 경고창 뜨는 함수
	 * 작 성 자 : suerte
	/***********************************************/
	function alert_overmax(obj,maxlength) 
	{ 
	    var str = obj.value.length; 
	    var con = obj.value; 
	    if (str >= maxlength) 
	    { 
	        alert('최대 '+maxlength+'글자 까지만 보낼 수 있습니다.'); 
	        obj.value=con.substring(0,maxlength); 
	        obj.focus(); 
	    } 
	}
	
	/**********************************************
	 * 함수명 : strCalculateByte
	 * 기 능 : 글자 수 넘으면 경고창 뜨는 함수
	/***********************************************/
	function strCalculateByte(obj, length)
	{
		var str = obj.value; 
        var l = 0; 
        for (var i=0; i<str.length; i++)
        {
			l += (str.charCodeAt(i) > 128) ? 2 : 1; 
        	if(l>length)
        	{
        		alert('최대 '+ length +'Byte까지만 입력이 가능합니다.');
        		obj.value = str.substring(0, i);
        		//obj.focus();
        		return false;
        	}
        }
	}
	
	
	/***********************************************************
	 * Function Name : chkBoxAll
	 * Details : 체크박스 전체선택 선택해제
	 ***********************************************************/
	function chkBoxAll(bool,name) 
	{ 
    	var obj = document.getElementsByName(name); 
    	for(var i=0; i<obj.length; i++) if(!obj[i].disabled) obj[i].checked = bool; 
	} 
    
    
    /***********************************************************
	 * Function Name : checkedCnt
	 * Details : 체크박스에 선택한 갯수를 리턴한다.
	 ***********************************************************/
	function checkedCnt(name)
	{
		var obj = document.getElementsByName(name);
		var cnt = 0;
		for(var i=0;i<obj.length;i++) 
		{
			if(obj[i].disabled == false && obj[i].checked==true) cnt++;
		}
		return cnt;
	}
	
	/***********************************************************
	 * Function Name : checkedArrayValue
	 * Details : 체크박스에 선택한 값들을 리턴한다.
	 ***********************************************************/
	function checkedArrayValue(name)
	{
		var obj = document.getElementsByName(name);
		var val = new Array();
		var j=0;
		for(var i=0;i<obj.length;i++) 
		{
			if(obj[i].disabled == false && obj[i].checked==true) val[j++]=obj[i].value;
		}
		//alert(val);
		return val;
	}
	
	/***********************************************************
	 * Function Name : checkedOnlyValue
	 * Details : 체크박스에 선택한 값들을 리턴한다.
	 ***********************************************************/
	function checkedOnlyValue(name)
	{
		var obj = document.getElementsByName(name);
		var val = new Array();
		var j=0;
		for(var i=0;i<obj.length;i++) 
		{
			if(obj[i].disabled == false && obj[i].checked==true) val[j++]=obj[i].value;
		}
		//alert(val);
		return val;
	}
	
	/**********************************************
	 * 함수명 : isValidfileExt
	 * 기   능 : 파일의 확장자를 체크하여 파일 업로드를 막는다.
	 * 작 성 자 : suerte
	/***********************************************/
	function isValidfileExt(filename)
	{
		var ext = filename.substr(filename.lastIndexOf(".")+1);
		var noValid = ['jsp','php','asp','exe','sh','bat','dll'];
		for(var i=0; i<noValid.length;i++)
		{
			if(ext.toLowerCase()==noValid[i])
			{
				alert('입력하신 파일은 업로드가 불가능 합니다.');
				return false;
			}
		}
		return true;
	}
	
	/**********************************************
	 * 함수명 : isValidfileExtImg
	 * 기   능 : 파일의 확장자를 체크하여 이미지 파일의 업로드만 허용한다.
	 * 작 성 자 : suerte
	/***********************************************/
	function isValidfileExtImg(filename)
	{
		var ext = filename.substr(filename.lastIndexOf(".")+1);
		var noValid = ['jpg','bmp','gif','png'];
		var cnt = 0;
		for(var i=0; i<noValid.length;i++)
		{
			if(ext.toLowerCase()== noValid[i]) cnt++;
		}
		//일치하는 형식이 없으면
		if(cnt<1)
		{
			alert('이미지 파일만 업로드가 가능합니다.');
			return false;
		}
		return true;
	}


  	/**********************************************
	 * 함수명 : isValidBizNo
	 * 기   능 : 사업자등록번호의 유효성을 체크한다.<br>
	 * 작 성 자 : Mong
	/***********************************************/
	function isValidBizNo(ele, value) { 
		
		var chk = false;

		var pattern = /^([0-9]{3})-?([0-9]{2})-?([0-9]{5})$/; 
		var num = value ? value : ele.value;

		var li_temp = null;
		var cKeyNum = null;

		var i = null;

		var cVal = 0; 

		var step1, step2, step3, step4, step5, step6, step7;
		var chkRule = "137137135";

		if (pattern.test(num))
		{
			num = RegExp.$1 + RegExp.$2 + RegExp.$3;

			step1 = 0; // ì´ê¸°í

			for (var i=0; i<7; i++)
			{
				step1 = step1 + (num.substring(i, i+1) *chkRule.substring(i, i+1));
			}

			step2 = step1 % 10;
			step3 = (num.substring(7, 8) * chkRule.substring(7, 8))% 10;
			step4 = num.substring(8, 9) * chkRule.substring(8, 9);
			step5 = Math.round(step4 / 10 - 0.5);
			step6 = step4 - (step5 * 10);
			step7 = (10 - ((step2 + step3 + step5 + step6) % 10)) % 10;

			chk = num.substring(9, 10) == step7; 

		}

		if (!chk)
		{
			alert('사업자등록번호 형식이 올바르지 않습니다.');
			if(ele) ele.focus();
		}

		return chk;
	}





  	/**********************************************
	 * 함수명 : isValidJumin
	 * 기   능 : 주민등록번호의 유효성을 체크한다.<br> 
	 * 작 성 자 : Mong
	/***********************************************/
	function isValidJumin(ele, value) {
		var pattern = /^([0-9]{6})-?([1-4]{1})([0-9]{6})$/;
		var chk = false;
		var num = value ? value : ele.value;
		var sum = 0;
		var last = 0;
		var bases = "234567892345";
		var mod = 0;

		if (pattern.test(num))
		{
			num = RegExp.$1 + RegExp.$2 + RegExp.$3;

			last = num.charCodeAt(12) - 0x30;

			for (var i=0; i<12; i++) {
				sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
			}

			mod = sum % 11;

			chk = ((11 - mod) % 10 == last);
		}

		if (!chk)
		{
			alert('주민등록번호 형식이 올바르지 않습니다.');
			if(ele) ele.focus();
		}

		return chk;
		
	}



  	/**********************************************
	 * 함수명 : isValidForeignNum
	 * 기   능 : 외국인등록번호의 유효성을 체크한다.<br> 
	 * 작 성 자 : Mong
	/***********************************************/
	function isValidForeignNum(ele, value) {
		var pattern = /^([0-9]{6})-?([5-9]{1})([0-9]{6})$/;
		var chk = false;
		var num = value ? value : ele.value;
		var sum = 0;
	    var odd = 0;
		var i = 0;

		if (pattern.test(num))
		{
			num = RegExp.$1 + RegExp.$2 + RegExp.$3;
    
		    buf = new Array(13);
		    for (i = 0; i < 13; i++) buf[i] = parseInt(num.charAt(i));
		
		    odd = buf[7]*10 + buf[8];

			if(odd%2 == 0)
			{
			    multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
			    for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);
	
			    sum=11-(sum%11);
			    
			    if (sum>=10) sum-=10;
			
			    sum += 2;
	
			    if (sum>=10) sum-=10;
			
			    chk = ( sum == buf[12]);

			}

		}

		if (!chk)
		{
			alert('외국인등록번호 형식이 올바르지 않습니다.');
			if(ele) ele.focus();
		}

		return chk;
	}


  	/**********************************************
	 * 함수명 : isValidPhoneBoth
	 * 기   능 : 전화번호/핸드폰 형식인지 확인한다.(일반전화, 핸드폰)
	 * 작 성 자 : Mong
	/***********************************************/
	function isValidPhoneBoth(ele, value) {
		var strPhoneNum = (value) ? value : ele.value;
		var pattern = /^([0]{1}[0-9]{1,3})-?([1-9]{1}[0-9]{2,3})-?([0-9]{4})$/;
		if (pattern.test(strPhoneNum)) 
		{
			return true;
		}
		else{
			alert('전화번호 형식이 올바르지 않습니다.');
			ele.focus();
			return false;
		}
	}

  	/**********************************************
	 * 함수명 : isValidPhone
	 * 기   능 : 전화번호 형식인지 확인한다.(일반전화)
	 * 작 성 자 : Mong
	/***********************************************/
	function isValidPhone(ele, value) {
		var strPhoneNum = (value) ? value : ele.value;
		var pattern = /^((02)|([0]{1}[3-6]{1}[1-5]{1})|([0]{1}[5-8]{1}[0]{1}[5]{0,1}))-?([1-9]{1}[0-9]{2,3})-?([0-9]{4})$/;
		if (pattern.test(strPhoneNum)) 
		{
			return true;
		}
		else{
			alert('전화번호 형식이 올바르지 않습니다.');
			ele.focus();
			return false;
		}
	}

  	/**********************************************
	 * 함수명 : isValidMobile
	 * 기   능 : 핸드폰번호 형식인지 확인한다.(핸드폰)
	 * 작 성 자 : Mong
	/***********************************************/
	function isValidMobile(ele, value) {
		var strMobileNum = (value) ? value : ele.value;
		var pattern = /^(01)(0|1|3|6|7|8|9)-?([1-9]{1}[0-9]{2,3})-?([0-9]{4})$/;
		if (pattern.test(strMobileNum)) 
		{
			return true;
		}
		else{
			alert('핸드폰번호 형식이 올바르지 않습니다.');
			ele.focus();
			return false;
		}
	}

  	/**********************************************
	 * 함수명 : isValidAlphaNumericOnly
	 * 기   능 : 영 대소문자와 숫자만으로 입력되었는지 확인한다.
	 * 작 성 자 : Mong
	/***********************************************/
	function isValidAlphaNumericOnly(ele){
		//var pattern = /[a-zA-Z][a-zA-Z0-9]+$/;
		var pattern = /^[a-zA-Z0-9]+$/;
		return (pattern.test(ele.value)) ? true : false;
	}

  	/**********************************************
	 * 함수명 : isValidAlphaOnly
	 * 기   능 : 영 대소문자만으로 입력되었는지 확인한다.
	 * 작 성 자 : Mong
	/***********************************************/
	function isValidAlphaOnly(ele) {
		var pattern = /^[a-zA-Z]+$/;
		return (pattern.test(ele.value)) ? true : false;
	}

  	/**********************************************
	 * 함수명 : isValidNumericOnly
	 * 기   능 : 숫자만으로 입력 되었는지 확인한다
	 * 작 성 자 : Mong
	/***********************************************/
	function isValidNumericOnly(ele) {
		var pattern = /^[0-9]+$/;
		return (pattern.test(ele.value)) ? true : false;
	}


	/************************************************
	 * 함수명  : _useMail_domain()
	 * @param : ele - 이메일 도메인 선택 SELECT 박스
	 * @param : targetEle - 선택된 도메인을 적용 할 input 박스
	 * 기능	 : 선택된 이메일 도메인을 타겟 ele 에 적용시킴. 선택된 도메인이 있을경우 targetEle 는 readOnly 처리.
	 ************************************************/
	function _useMail_domain(ele, targetEle)
	{
		targetEle.value = ele.value;
		targetEle.setAttribute('readOnly', (ele.value!='')); 
	}

	/************************************************
	 * 함수명  : _useBank_name()
	 * @param : ele - 은행코드 선택 SELECT 박스
	 * @param : targetEle - 선택한 은행코드의 은행명을 적용 할 input 박스
	 * 기능	 : 은행이 선택 되었을 경우 해당하는 은행명을 targetEle 에 적용시킴.
	 ************************************************/
	function _useBank_name(ele, targetEle)
	{
		(ele.getAttribute('value')!='') ? targetEle.setAttribute('value', ele.getAttribute('options')[ele.getAttribute('selectedIndex')].getAttribute('text')): '';
	}

	/************************************************
	 * 함수명  : _chkKeyPressNum(ele)
	 * 기 능	 : 숫자 이외의 키 입력을 막는다. <br>
	 * @param : ele - 정보 입력 박스
	 * 작 성 자 : Mong
	 ************************************************/
	function _chkKeyPressNum(ele) {

		var chr= event.keyCode;
		if(!((chr >= 48 && chr <= 57) || (chr >= 96 && chr <= 105) || chr == 13 || chr == 8 || chr == 9 || chr == 45)){
			event.returnValue  = false;
			ele.focus();
			return false;
		}
	}
	
	
	/************************************************
	 * 함수명  : _chkKeyPressNumOnly(ele)
	 * 기 능	 : 숫자 이외의 키 입력을 막는다. <br>
	 * @param : ele - 정보 입력 박스
	 * 작 성 자 : Mong
	 ************************************************/
	function _chkKeyPressNumOnly(ele) {

		var chr= event.keyCode;
		
		if(!((chr >= 48 && chr <= 57) || chr == 13 || chr == 8 || chr == 9)){
			event.returnValue  = false;
			ele.focus();
			return false;
		}
	}

	/************************************************
	 * 함수명  : _chkKeyPressNumPoint(ele)
	 * 기 능	 : 숫자와 . 이외의 키 입력을 막는다. <br>
	 * @param : ele - 정보 입력 박스
	 * 작 성 자 : Mong
	 ************************************************/
	function _chkKeyPressNumPoint(ele) {

		var chr= event.keyCode;
		if(!((chr >= 48 && chr <= 57) || (chr >= 96 && chr <= 105) || chr == 46 || chr == 13 || chr == 8 || chr == 9)){
			event.returnValue  = false;
			ele.focus();
			return false;
		}
	}

	/************************************************
	 * 함수명  : _chkKeyPressChar(ele)
	 * 기 능	 : 문자 이외의 키 입력을 막는다. <br>
	 * @param : ele - 정보 입력 박스
	 * 작 성 자 : Mong
	 ************************************************/
	function _chkKeyPressChar(ele)   
	{
		var chr= event.keyCode;
		if(!(chr==8 || chr==9 || chr==46 || chr==229 || chr==37 || chr==39 || (chr >= 65 && chr <= 90) || (chr >= 97 && chr <= 122)))
		{
		  event.returnValue  = false;
		  ele.focus();
	   }
	}

	/************************************************
	 * 함수명  : _chkKeyPressCharNum(ele)
	 * 기 능	 : 문자/숫자 이외의 키 입력을 막는다. <br>
	 * @param : ele - 정보 입력 박스
	 * 작 성 자 : Mong
	 ************************************************/
	function _chkKeyPressCharNum(ele)   
	{
		var chr= event.keyCode;
		if(!((chr >= 48 && chr <= 57) || (chr >= 96 && chr <= 105) || chr==8 || chr==9 || chr==46 || chr==229 || chr==37 || chr==39 || (chr >= 65 && chr <= 90) || (chr >= 97 && chr <= 122)))
		{
		  event.returnValue  = false;
		  ele.focus();
	   }
	}

	/************************************************
	 * 함수명  : _numFormat
	 * 기 능	 : 천단위 콤마 넣기 <br>
	 * @param : ele - 정보 입력 박스
	 * @param : value - 값 : 생략가능
	 * 작 성 자 : Mong
	 ************************************************/
	function _numFormat(ele, value){
		var str = ((value > -1 || value) ? value : ele.getAttribute('value'))+'';
		//alert(str)
		if(str == '0') ele.setAttribute('value', 0);
		else
		{
			var Re = /[^0-9]/g;
			var ReN = /(-?[0-9]+)([0-9]{3})/;
			str = str.replace(Re,''); 
			while (ReN.test(str)) { str = str.replace(ReN, "$1,$2"); }
			ele.setAttribute('value', str);
		}
	}
	
	
	function MoneyComma(x) {
		var txtNumber = '' + x;
		
		var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
		var arrNumber = txtNumber.split('.');
		arrNumber[0] += '.';
		do {
			arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
		} while (rxSplit.test(arrNumber[0]));
			if (arrNumber.length > 1) {
				return arrNumber.join('');
			}else {
				return arrNumber[0].split('.')[0];
			}
	}
	
 

	/************************************************
	 * 함수명  : _removeComma
	 * 기 능	 : 콤마 제거 <br>
	 * @param : ele - 정보 입력 박스
	 * @param : value - 값 : 생략가능
	 * 작 성 자 : Mong
	 ************************************************/
	function _removeComma(ele, value){
		var str = ((value) ? value : ele.getAttribute('value'))+'';
		var oldStr = new RegExp(",", "g");
		ele.setAttribute('value', str.replace(oldStr, ""));
	}

	/************************************************
	 * 함수명  : isObjcet(ele)
	 * 기 능	 : 오브젝트인이 여부를 판한 후 boolean 값을 return. <br>
	 * @param : ele - 오브젝트 여부를 확인 할 객체
	 * 작 성 자 : Mong
	 ************************************************/
	function isObject(ele)
	{
		return (typeof ele=='object');
	}

	/************************************************
	 * 함수명  : resetOptions(selEle, startNum)
	 * 기 능	 : 크로스 브라우징을 위해 웹 표준코드를 사용하여 OPTION 객체를 초기화 <br>
	 * @param : ele - 오브젝트 여부를 확인 할 객체
	 * @param : startNum - 남겨야 할 option 항목이 있을경우 해당 갯수를 입력.
	 * 작 성 자 : Mong
	 ************************************************/
	function resetOptions(selEle, startNum)
	{
		var objOpt = selEle.getElementsByTagName('OPTION');
		var optLength = objOpt.length;
		var i = 0;
		i += ((startNum)&&!isNaN(startNum)) ? startNum : i;

		for (var j=i;j<optLength;j++)
		{
			selEle.removeChild(objOpt[i]);
		}
	}


	/************************************************
	 * 함수명  : _closeAndParentReLoad()
	 * 기 능	 : 팝업창에서 창을 닫으며 부모창을 reload한다<br>
	 * 작 성 자 : Mong
	 ************************************************/
	function _closeAndParentReLoad()
	{
		var wndOpener = window.opener;
		if (wndOpener) wndOpener.location.reload();
		self.close();
	}
	

	/************************************************
	 * 함수명  : _openObjPosition()
	 * 기 능	 : 파라미터로 전달받은 Div 오브젝트를 특정 위치에서 보여준다.<br>
	 * @param : eleObj - 위치의 기준이 되는 Odject
	 * @param : eleDiv - 화면에 보여줄 Div
	 * @param : intTop - 기준 Object 에서 조절할 세로위치값
	 * @param : intLeft - 기준 Object 에서 수정되는 가로위치값
	 * @param : isAbsolute - 기준점 없이 절대좌표로 오픈하고 싶을때 사용 (true / false) - 생략가능
	 * 작 성 자 : Mong
	 ************************************************/
	function _openObjPosition(eleObj, eleDiv, intTop, intLeft, isAbsolute)
	{
		// 절대좌표사용여부 파라미터가 true 가 아닐경우 false 로 셋팅
		if(true!=isAbsolute) isAbsolute=false;

		intTop = (intTop) ? intTop : 0;
		intLeft = (intLeft) ? intLeft : 0;
		
		var rect = eleObj.getBoundingClientRect();
		if(isAbsolute)
		{
			eleDiv.style.top = parseInt(intTop);
			eleDiv.style.left = parseInt(intLeft);
		}
		else
		{
			eleDiv.style.top = (document.body.scrollTop + rect.top) + parseInt(intTop);
			eleDiv.style.left = (document.body.scrollLeft + rect.left) + parseInt(intLeft);
		}

		eleDiv.getAttribute('style').display='block';
	}


	/************************************************
	 * 함수명  : _cngLoadingImg()
	 * 기 능	 : 특정 대상을 loading 이미지로 교체, 혹은 원상복귀
	 * @param : ele			- 대상
	 * @param : loadingView	- true : 로딩이미지, false : 원상복귀
	 * 작 성 자 : Mong
	 ************************************************/
	function _cngLoadingImg(ele, loadingView)
	{
		var loadingImgEle = document.getElementById('divLoadingImg');

		var rect = ele.getBoundingClientRect();

		if(loadingView)
		{
			loadingImgEle.getAttribute('style').top = (document.body.scrollTop + rect.top);		
			loadingImgEle.getAttribute('style').left = (document.body.scrollLeft + rect.left);		
		}

		loadingImgEle.getAttribute('style').display = (!loadingView) ? "none" : "block";
		ele.getAttribute('style').display = (loadingView) ? "none" : "block";
	}

	/**********************************************
     * 함 수 명 : _getCode
     * 기     능 : 코드집합 String 에서 특정 코드를 반환한다.
	 * @param : strCodes - 코드집합
	 * @param : eleCode - 반환을 원하는 코드.
	 * Detail : 코드집합 문자열의 형태는 아래와 같다.
	 *			codeName:value|codeName:value|....
    ***********************************************/
	function _getCode(strCodes, eleCode)
	{

		var rtnCode = "";
		var idxPos = strCodes.indexOf(eleCode+':');
		//alert(idxPos);
		if(idxPos>=0)
		{

			strCodes=strCodes.substring(idxPos+eleCode.length, strCodes.length);
			var division = strCodes.indexOf('|');

			rtnCode = (division>=0) ? strCodes.substring(1, division) : strCodes.substring(1, strCodes.length);
		}

		return rtnCode;
	}
	
	
	/**********************************************
     * 함수명 : convertDataString
     * 기   능 : 문자열을 날짜형식으로 변환
    ***********************************************/
	function convertDataString(obj, val)
	{
		var str = "";
		if(val.length == 8)
		{
			str = val.substring(0,4)+"-"+val.substring(4,6)+"-"+val.substring(6,8);
		}
		obj.value=str;
	}
	
	/**********************************************
     * 함수명 : restoreDateString
     * 기   능 : 날짜형식을 문자열로 변환
    ***********************************************/
	function restoreDateString(obj, val)
	{
		//alert(val);
		obj.value = val.replace(/\./g, "")
		obj.focus();
	}
	
	/**********************************************
     * 함수명 : _getParentNodeByTagName
     * 기   능 : 파라미터로 전달받은 element의 parentNode 중 찾고자 하는 태그를 가진 대상을 반환. (재귀호출)
    ***********************************************/
	function _getParentNodeByTagName(ele, targetTagName)
	{
		if(!targetTagName) return null;
		var obj = ele.parentNode;
//		alert(obj.tagName);
		return (obj.tagName.toUpperCase()==targetTagName.toUpperCase()) ? obj : _getParentNodeByTagName(obj, targetTagName);
	}
	
	/**********************************************
     * 함수명 : fnIsNaN
     * 기   능 : 파라미터로 전달받은 필드가 숫자 필드이고 값이 연산후 '0'이 되어야할경우 사용 
    ***********************************************/
	function fnIsNaN(value){
		if(isNaN(value) == true){
			return 0;
		}else{
			return value;
		}
	}
	
	/**********************************************
     * 함수명 : fnCalDate(pStartDate,pEndDate,pType )
     * 기   능 : 두 날짜 차이를 구하는 함수
     * param : pStartDate - 시작일
	 * param : pEndDate - 마지막일
	 * param : pType - 'D':일수, 'M':개월수
    ***********************************************/
	function fnCalDate(pStartDate,pEndDate,pType ){
	
		pStartDate = pStartDate.replaceAll('-','');
		pEndDate = pEndDate.replaceAll('-','');
		
		//param : pStartDate - 시작일
		//param : pEndDate - 마지막일
		//param : pType - 'D':일수, 'M':개월수
		var strSDT = new Date(pStartDate.substring(0,4),pStartDate.substring(4,6)-1,pStartDate.substring(6,8));
		var strEDT = new Date(pEndDate.substring(0,4),pEndDate.substring(4,6)-1,pEndDate.substring(6,8));
		var strGapDT = 0;
		
		if(pType == 'D') { //일수 차이
			strGapDT = (strEDT.getTime()-strSDT.getTime())/(1000*60*60*24);
		} else { //개월수 차이
		 	//년도가 같으면 단순히 월을 마이너스 한다.
		 	// =&gt; 20090301-20090201 의 경우 아래 else의 로직으로는 정상적인 1이 리턴되지 않는다.
		 	if(pEndDate.substring(0,4) == pStartDate.substring(0,4)) {
		 		strGapDT = pEndDate.substring(4,6) * 1 - pStartDate.substring(4,6) * 1;
		 	} else {
		 		strGapDT = Math.floor((strEDT.getTime()-strSDT.getTime())/(1000*60*60*24*365.25/12));
		 	}
		}
	
		return strGapDT;
	
	}
	
	/**********************************************
     * 함 수 명 : getByteLength(data)
     * 기    능 : 필드의 byte수를 return
    ***********************************************/
	function getByteLength(data){
		var len = 0;
		var str = data.substring(0);
		if(str == null)return 0;
		for(var i=0; i< str.length; i++){
			var ch = escape(str.charAt(i));
			if(ch.length == 1)len++;
			else if(ch.indexOf("%u") != -1) len += 2; // 한글바이트
			else if(ch.indexOf("%") != -1) len += ch.length/3;
		}
	
		return len;
	}
	
	/**********************************************
     * 함 수 명 : fnGridDateCheck(val, record)
     * 기    능 : 그리드의 Date형식을 체크
     * 
    ***********************************************/
	function fnGridDateCheck(val){
		
		if(val != undefined){
			// DB로 부터 date를 '2000-01-01'형식으로 값을 조해했을 경우 
			// 조회된 값을 그대로 return
			var str = val.replaceAll('-','');
			
			if(str=='') return;
			var isDateValue = false;
	
			// 정규식을 이용. 1차적으로 날짜형식 여부를 판단.
			// YYYYMMDD
			var pattern = /^[1|2][0-9]{3}([0][0-9]|[1][0-2])([0-2][0-9]|[3][0-1])/;
			if(pattern.test(str)){
				isDateValue = true;
				str = str.substr(0, 4)+""+str.substr(4,2)+""+str.substr(6,2);
				//alert("YYYYMMDD"+str);
			} else {
				// YYYY.MM.DD
				var pattern = /^[1|2][0-9]{3}[\.]([0][0-9]|[1][0-2])[\.]([0-2][0-9]|[3][0-1])/;
				if(pattern.test(str)){
					isDateValue = true;
					str = str.substr(0, 4)+""+str.substr(5,2)+""+str.substr(8,2)
					//alert("YYYY.MM.DD"+str);
				} else {
					// YYYY-MM-DD
					var pattern = /^[1|2][0-9]{3}[\-]([0][0-9]|[1][0-2])[\-]([0-2][0-9]|[3][0-1])/;
					if(pattern.test(str)){
						isDateValue = true;
						str = str.substr(0, 4)+""+str.substr(5,2)+""+str.substr(8,2)
						//alert("YYYY.MM.DD"+str);
					}
				}
			}
	
			// 정규식체크 통과시. 2차적으로 정상적인 년/월/일이 입력되었는지 유효성 판단.
			isDateValue = isDateValue ? isDate(str) : false;
	
			if(!isDateValue)
			{  
				Ext.Msg.alert('확인', '유효한 날짜가 아닙니다.'); 
				val =  '';
			}
			else
			{
				val = str.substring(0,4)+"-"+str.substring(4,6)+"-"+str.substring(6,8);
			}
			return val;
					
		}
	}
	
	/**********************************************
     * 함 수 명 : printArea()
     * 기    능 : 선택 영역 프린트 
     	1.해당 테이블,tr에 id 설정 id="idPrint" 
     	2. iframe 추가 :<iframe name="jobFrame" style="display:none" frameborder=0></iframe>
     * 
    ***********************************************/

	 function printArea() {
	  	var prtHtml = document.getElementById('idPrint').outerHTML
  		var printTmp ="";
		if(idPrint.childNodes[0].nodeName == "TBODY")
		{
		  printTmp = "<html>																					"
				+"<head>                                                                                         "
				+"<link rel='stylesheet' type='text/css' href='/resource/common/js/ext3/resources/css/ext-all.css' />           "
				+"</head>                                                                                        "
				+"<body>                                                                                         "
				+prtHtml+
				"</body>																						"				
				+"</html>  																						";
	  	}else
		{
		printTmp = "<html>																					"
				+"<head>                                                                                         "
				+"<link rel='stylesheet' type='text/css' href='/resource/common/js/ext3/resources/css/ext-all.css' />   "
				+"</head>                                                                                        "
				+"<body>                                                                                         "
				+"<table border='0' width='1000' height='200'>"+prtHtml+"</table>"
				+"</body>																						"				
				+"</html>  																						";
		} 
	 
	 
	 jobFrame.document.open();
	 
	 jobFrame.document.writeln(printTmp); // 본문 출력
	 
	 jobFrame.document.close();
	 jobFrame.document.execCommand('Print');
	} 
		 

	