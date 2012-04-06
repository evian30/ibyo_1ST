	//파라미터를 input테그형태로 만들어준다.
	function makeParam(param){
		var txt = "";
		var pageSize = "";
		if(document.getElementById("pageSize")) pageSize = document.getElementById("pageSize").value;
		if(param.indexOf("=") != -1){
			var paramAllArray = param.split("&");		
			for(var i=0; i< paramAllArray.length; i++){
				var paramArray = paramAllArray[i].split("=");
				var name = paramArray[0];
				var value = paramArray[1];
				if(name == "pageSize" && pageSize != "") value = pageSize;
				else if(name != "pageNum" && name !="")
				txt += "<input type=hidden name='"+name+"' value='"+value+"' />";
			}//for
		}//if
		return txt;
	}
 
	//네비게이션 클릭시 해당 페이지로 이동
	function goPageByNavigation(fullUrl,pageNum){
		var formHtml = "";
		var url = fullUrl.split("?")[0];
		var param = fullUrl.split("?")[1];
		formHtml += makeParam(param)+ "<input type=hidden name='pageSize' value='"+document.vForm.pageSize.value+"' />" + "<input type=hidden name='pageNum' value='"+pageNum+"' />";
		var f = document.goMenu;
		f.innerHTML = formHtml;
		f.action = url;
		f.target = "";
		f.submit();
		f.target = "";
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
			alert("유효한 날짜가 아닙니다. 날짜를 다시 입력해 주십시요.");
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

		var newYear = parseInt(iDate.substring(0,4))+parseInt(addType.toUpperCase()=='Y' ? addValue : 0);
		var newMonth = parseInt(iDate.substring(4,6))-1+parseInt(addType.toUpperCase()=='M' ? addValue : 0);
		var newDate = parseInt(iDate.substring(6))+parseInt(addType.toUpperCase()=='D' ? addValue : 0);
		var oDate = new Date(newYear, newMonth, newDate);

		var tDate = '';
		var realMonth = parseInt(oDate.getMonth()) + 1;
		tDate+=oDate.getFullYear();
		tDate+=(realMonth<10) ? '0'+realMonth : realMonth;
		tDate+=(oDate.getDate()<10) ? '0'+parseInt(oDate.getDate()) : parseInt(oDate.getDate());

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
     * 기능추가 : 0 허용여부 추가 - 
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

/*
        var fmt3 = /^[-!#$%&\'*+\\./0-9=?A-Z^_a-z{|}~]+@[-!#$%&\'*+\\/0-9=?A-Z^_a-z{|}~]+\.[-!#$%&\'*+\\./0-9=?A-Z^_a-z{|}~]+$/;
        if(!fmt3.test(email)) return false;
        else return true;   
*/
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
      
     /************************************************
     * 함수명 : iframeCheck
     * 기   능 : 아이프레임 크기 자동조절
    *************************************************/
    function iframeCheck(framename) 
	{
		eval("var PF = "+framename+".document.body");
		var CF = document.all[framename];
		CF.style.height = PF.scrollHeight + (PF.offsetHeight - PF.clientHeight);
		CF.style.width = PF.scrollWidth + (PF.offsetWidth - PF.clientWidth);
	}
  
	/**********************************************
	 * 함수명 : alert_overmax
	 * 기 능 : 글자 수 넘으면 경고창 뜨는 함수
	  suerte
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
    	for(var i=0; i<obj.length; i++) {
    		if(!obj[i].disabled) {
    			obj[i].checked = bool;
    		}
    	}
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
	
	/***********************************************************
	 * Function Name : disabledCheckBoxCnt
	 * Details : 액션을 실행할수 없는 체크박스 갯수를  리턴한다.
	 ***********************************************************/
	function disabledCheckBoxCnt(chkname, valname, flag)
	{
		//alert('aaa');
		var cnt = 0;
		var obj = document.getElementsByName(chkname);
		var comp = document.getElementsByName(valname);
		//alert(obj.length);
		for(var i=0;i<obj.length;i++)
		{
			//alert(comp[i].value+"/"+flag);
			if(obj[i].checked==true && comp[i].value == flag) cnt++;
		}
		return cnt;
	}
	
	/***********************************************************
	 * Function Name : disabledCheckbox
	 * Details : 액션을 실행할수 없게 체크박스를 막는다.
	 ***********************************************************/
	function disabledCheckbox(chkname, valname, flag)
	{
		var cnt = 0;
		var obj = document.getElementsByName(chkname);
		var comp = document.getElementsByName(valname);
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].checked==true && comp[i].value == flag) 
			{
				//alert(obj[i]+"/"+obj[i].value)
				obj[i].disabled = true;
			}
		}
	}
	
	/***********************************************************
	 * Function Name : disabledCheckbox
	 * Details : 액션을 실행할수 없게 체크박스를 막는다.
	 ***********************************************************/
	function enabledCheckbox(chkname)
	{
		var cnt = 0;
		var obj = document.getElementsByName(chkname);
		for(var i=0;i<obj.length;i++)
		{
			obj[i].disabled = false;
		}
	}
	
	
	/**********************************************
	 * 함수명 : isValidfileExt
	 * 기   능 : 파일의 확장자를 체크하여 파일 업로드를 막는다.
	  suerte
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
	  suerte
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
	 * 함수명 : addRowFileType
	 * 기   능 : 파일타입의 행을 추가한다..
	  lioneyes
	/***********************************************/
	function addRowFileType(strParam) 
	{ 
	    var oRow = dynamicFile.insertRow(); 
	    oRow.onmouseover=function(){dynamicFile.clickedRowIndex=this.rowIndex}; 
	    var oCell = oRow.insertCell(); 
	    var idxNum = dynamicFile.rows.length;
	    oCell.innerHTML = "<input type='file' name='strFileName"+idxNum+"' style='width:400; height:20' onKeyDown='return false'> &nbsp; <a href='javascript:delRow()'><span class='botton_box_20'>삭제(-)</span></a>"; 
  	} 
  
	
  	/**********************************************
	 * 함수명 : delRow
	 * 기   능 : 동적으로 생성된 행을 삭제한다..
	  lioneyes
	/***********************************************/
	function delRow() 
  	{ 
    	dynamicFile.deleteRow(dynamicFile.clickedRowIndex); 
  	} 



  	/**********************************************
	 * 함수명 : isValidBizNo
	 * 기   능 : 사업자등록번호의 유효성을 체크한다.<br>
	  
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
	  
	/***********************************************/
	function isValidAlphaNumericOnly(ele){
		//var pattern = /[a-zA-Z][a-zA-Z0-9]+$/;
		var pattern = /^[a-zA-Z0-9]+$/;
		return (pattern.test(ele.value)) ? true : false;
	}

  	/**********************************************
	 * 함수명 : isValidAlphaOnly
	 * 기   능 : 영 대소문자만으로 입력되었는지 확인한다.
	  
	/***********************************************/
	function isValidAlphaOnly(ele) {
		var pattern = /^[a-zA-Z]+$/;
		return (pattern.test(ele.value)) ? true : false;
	}

  	/**********************************************
	 * 함수명 : isValidNumericOnly
	 * 기   능 : 숫자만으로 입력 되었는지 확인한다
	  
	/***********************************************/
	function isValidNumericOnly(ele) {
		var pattern = /^[0-9]+$/;
		return (pattern.test(ele.value)) ? true : false;
	}
 
	 
	function ismaxlength(obj){
		var mlength=obj.getAttribute? parseInt(obj.getAttribute("maxlength")) : ""
		if (obj.getAttribute && obj.value.length>mlength)
		alert("최대 입력 범위를 초과 하였습니다.");
		obj.value=obj.value.substring(0,mlength)
	}
	
	/////////////////////////////////////////////////////////////////////////////////////
	// 숫자만 입력 가능하도록
	// 사용방법 : onlyNum();
	// 사용 예 : <input type="text" name="txt_number" onKeyPress="onlyNum();">
	
	function onlyNum() {	
		if(event.keyCode<26||event.keyCode<45||event.keyCode>57) event.returnValue=false;
	}
	/////////////////////////////////////////////////////////////////////////////////////
	
	///////////////////////////////////////////////////////////////////////////////////// 
	// 숫자만 입력 가능하도록(전화번호 '-' 추가)
	// 사용방법 : onlyNumPhone();
	// 사용 예 : <input type="text" name="txt_number" onKeyPress="onlyNumPhone();">
	
	function onlyNumPhone() {	
		if(event.keyCode<26||event.keyCode<45||event.keyCode>57||event.keyCode==109||event.keyCode==189) event.returnValue=false;
	}
	/////////////////////////////////////////////////////////////////////////////////////
 
	/////////////////////////////////////////////////////////////////////////////////////
	// 숫자만 입력 가능하도록 (소수점 (. 와 / )까지 제한)
	// 사용방법 : onlyNumAbs();
	// 사용 예 : <input type="text" name="txt_number" onKeyPress="onlyNumAbs();">
	
	function onlyNumAbs() {	
		if(event.keyCode<26||event.keyCode<48||event.keyCode>57) event.returnValue=false;
	}
	/////////////////////////////////////////////////////////////////////////////////////
	   
	
	/************************************************
	 * 함수명  : _chkKeyPressNum(ele)
	 * 기 능	 : 숫자 이외의 키 입력을 막는다. <br>
	 * @param : ele - 정보 입력 박스
	  
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
	  
	 ************************************************/
	function _chkKeyPressNumOnly(ele) {

		var chr= event.keyCode;
		if(!((chr >= 48 && chr <= 57) || (chr >= 96 && chr <= 105) || chr == 13 || chr == 8 || chr == 9)){
			event.returnValue  = false;
			ele.focus();
			return false;
		}
	}

	/************************************************
	 * 함수명  : _chkKeyPressNumPoint(ele)
	 * 기 능	 : 숫자와 . 이외의 키 입력을 막는다. <br>
	 * @param : ele - 정보 입력 박스
	  
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

	/************************************************
	 * 함수명  : _removeComma
	 * 기 능	 : 콤마 제거 <br>
	 * @param : ele - 정보 입력 박스
	 * @param : value - 값 : 생략가능
	  
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
	 * 기 능	 : 팝업창에서 창을 닫으며 부모창을 reload한다 
	 ************************************************/
	function _closeAndParentReLoad()
	{
		var wndOpener = window.opener;
		if (wndOpener) wndOpener.location.reload();
		self.close();
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
			str = val.substring(0,4)+"."+val.substring(4,6)+"."+val.substring(6,8);
		}
		obj.value=str;
	}
	
	
	/**********************************************
     * 함수명 : convertDecimalFormat
     * 기   능 : 3자리마다 콤마 찍기
    ***********************************************/ 
		function auto_amount(frm,obj) { 
		 
		   
    	 var str = obj.value;
    	 str = str.replace(/,/gi,'');
    	 
    	 if (str.length < 1) {
    		    return "";
    		  } else {
    		  var tm = "";
    		  var ck = ""; 
    		  if (str.substring(0, 1) == "-") { //음수
    		   tm = str.substring(1, str.length);
    		   ck = "Y";
    		  } else {//양수
    		   tm = str;
    		   ck = "N";
    		  }
    		  var st = "";
    		  var cm = ",";

    		  for (var i = tm.length, j = 0; i > 0; i--, j++) {
    		   if ((j % 3) == 2) {
    		    if (tm.length == j + 1) st = tm.substring(i - 1, i) + st;
    		    else{
    		    	st = cm + tm.substring(i - 1, i) + st;
    		    }
    		   } else {
    		    st = tm.substring(i - 1, i) + st;
    		   }
    		  }
    		  if (ck == "Y") st = "-" + st;
    		 }
    	 obj.value = st;
    	 
		} 
      
			
		function str_number(str) { 
			//문자열에서 숫자만 가져가기 
			var val = str; 
			var temp = ""; 
			var num = ""; 
			var i = 0; 
			for (i=0; i<val.length; i++) { 
				temp = ""+val.substr(i,1); 
					if ( (temp >= "0" && temp <= "9") ) { 
						num = num + temp; 
					} 
			} 
			num = ""+parseInt(num,10);//십진수로 변환 
			return num; 
		}
		 
		function num_check() { 
			//숫자만 입력받기. 
			if (navigator.userAgent.indexOf("MSIE") != -1) { 
				var keyCode = event.keyCode; 
				//alert(keyCode);
				if ((keyCode < 48 && keyCode != 45) || keyCode > 57) { 
					event.returnValue=false; 
				}
			} 
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
     * 함수명 : goRefresh
     * 기   능 : 검색조건 초기화
    ***********************************************/
	function goRefresh(){  
		document.getElementsByName("key")[0].value="001";
		document.getElementsByName("keyword")[0].value="";
		document.getElementsByName("pageSize")[0].value="10";
		return true;
	}
	
	
	/**********************************************
     * 함수명 : jk_InuptBoxChk
     * 기   능 : 저장 시 데이터 확인
    ***********************************************/
	function jk_InuptBoxChk(input,title)
	{	
		if(eval(input).value == ""){
			alert(title);
			eval(input).focus();
			return true;
		}

		return false;	
	}
	
	
	/**********************************************
     * 함수명 : jk_ContentsCheck
     * 기   능 : textarea 글자수 확인
    ***********************************************/
	function jk_ContentsCheck(lee,CT_max) {

		 var ls_str     = lee.value;
		 var li_str_len = ls_str.length; // 글자수

		 var li_max      = CT_max;  // 제한할 글자수
		 var i           = 0;   // for문에 사용
		 var li_byte     = 0;   // 한글이면 2 그 외엔 1을 더함
		 var li_len      = 0;   // substring하기 위해서 사용
		 var ls_one_char = "";   // 한글자씩 검사
		 var ls_str2     = "";   // 글자수 초과시 제한수 글자까지만 출력

		 for ( i = 0 ; i < li_str_len ; i ++ ) {
		 ls_one_char = ls_str.charAt(i);  // 한글자추출

		 if ( escape(ls_one_char).length > 4 ) { // 한글이면 2를 더한다.
		  li_byte += 2;
		 } else {    // 그밗의 경우는 1을 더한다.
		  li_byte++;
		 }

		 // 전체 크기가 li_max를 넘지않으면
		 if(li_byte <= li_max){
			  li_len = i + 1;
			  //InnerHtml('txtLen',li_byte);
		 }	 

		}
		  
		if ( li_byte > li_max ) { // 전체길이를 초과하면
		     alert( li_max + " 글자까지만 입력이 가능합니다.");
		     ls_str2 = ls_str.substr(0, li_len);
		     lee.value = ls_str2;
		}

		lee.focus();   

	}
