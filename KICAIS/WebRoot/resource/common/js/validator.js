/***************************************************************************************************
 *  폼 검증 툴
 *  !! 주의
 *  - 속성을 추가할 시에는  /resource/css/common/validator.css 에도 항목을 추가해야 한다.(복사 & 붙여넣기)
 *  사용방법 :
 *   HTML -
 *    아래 예와 같이 속성명을 정의하고, Form Elements 에 class 속성으로 사용한다.
 *    <input type="" name="" value="" class="속성1 속성2 속성3" />
 *    예를 들어 반드시 입력해야 하며, 숫자만으로 되어있어야 하며, white space가 없어야 한다면,
 *    아래와 같이 사용한다.
 *    <input type="" name="" value="" class="required validate-digits validate-white-space" />
 *
 *   SCRIPT - 
 *     폼 전체 적용
 *     if(Validator.validate(검증대상Form객체)){
 *          문제가 없다면 수행할 코드....
 *          form.submit();
 *     }
 *     
 *     한 항목씩 사용
 *	   var message = Validator["validate-full-jumin"](str);
 *	   // 오류가 있으면 메시지를 반환																		
 *	   if(message) {
 *	       alert(message);
 *	       return false;
 *	   }
 ***************************************************************************************************/
	var Validator = {

		validate : function(form) {			
    		var elements = form.elements;
    		for(var i = 0; i <elements.length;i++) {				
				var el = elements[i];				
				var classes = el.className.split(" ");
				for(var j = 0; j < classes.length; j++) {
					// 각 클래스 명
					var className = classes[j].replace(" ","");
					var param;

                    /* className에 '_'(언더바)가 포함된경우 토큰으로 잘라서 앞부분을 함수 명으로 
                     * 사용하고  뒷 부분을 인자로 취하도록 한다.
                     * 
					 * 예 : validate-max-length_30 
					 *     : validate-max-length(x, y, 30) 맨뒤의 30이 인자로 취해짐
					 *     
                     * '_'가 여러개 포함 된 경우 이후 값들은 배열로 전달된다.(배열은 길이 제한이 없음)
					 * 예 : validate-limit-length_10_30
					 *     : validate-limit-length(x, y, Array([10,30])) 10과 30이 배열로 넘겨짐
					 */
					if(className.indexOf("_") >= 0) {
						var tmpArray = className.split("_");
						className = tmpArray[0];
						tmpArray.shift();
						
						if(tmpArray == null || tmpArray.length == 0) {
							param = "";
						} else if(tmpArray.length == 1) {
							param = tmpArray[0];
						} else {
							param = tmpArray;
						}
					}

					// 클래스명과 일치하는 메서드가 있으면...								
    				if(Validator[className]) {
						var message = Validator[className](el.value,el,param);
						// 오류가 있으면 메시지를 반환																		
						if(message) {
							Validator._handleError(message, el);
							return false;
						}
					}
				}
    		}
			return true;
		},

		/**
		 * 오류 제어
		 * @param {String} message
		 * @param {HTMLFormElement} el
		 */
		_handleError : function(message, el) {
			var title = Validator._getTitle(el);
			if(title != "")
				alert(title +"(은)는 " + message);
			else 
				alert(message);
			el.style.backgroundColor="#fdfde4";
			el.focus();
			
		}, 

		_getTitle : function (el) {
			if (el.title)
				return el.title;
			else 
				return "";
		},

		// 필수입력
		"required" : function(v) {			
			return !v ? "반드시 입력하셔야 합니다." : false;
		},
		// white space 없이 입력
		"validate-white-space" : function(v) {
			return /\s+/.test(v) ? "공백없이 입력되야 합니다." : false;
		},
		// 숫자만 입력
		"validate-digits" : function(v) {
			return isNaN(v) || /[^\d]/.test(v)? "숫자만 입력하셔야 합니다." : false;			
		},
		// 영문으로 시작 입력
		"validate-alpha" : function(v) {
			return /[^a-zA-Z]+$/.test(v) ? "알파뱃으로 시작되도록 입력하셔야 합니다." : false;
		},
		// 영문, 숫자, _(언더바) 만  입력
		"validate-basic-char" : function(v) {
			return !/[a-zA-Z0-9_]/.test(v) ? "알파뱃, 숫자, _(언더바) 만 입력하셔야 합니다." : false;
		},
		// 영문과 숫자만 입력
		"validate-alpha-num" : function(v) {
			return /\W/.test(v) ? "알파뱃과 숫자만 입력하셔야 합니다." : false;
		},
		// 날자 사용가능한 숫자 입력
		"validate-date" : function(v) {
			var date = new Date(v);
			return isNaN(v) ? "바른 날짜를 입력하셔야 합니다." : false;
		},
		// 유효한 email 입력
		"validate-email" : function(v) {
			return !/\w{1,}[@][\w\-]{1,}([.]([\w\-]{1,})){1,3}$/.test(v) ? "바른 이메일 주소를 입력하셔야 합니다." : false;
		},
		// 유효한 URL 입력
		"validate-url" : function(v) {
			if(v) {
				return !/^(http|https|ftp):\/\/(([A-Z0-9][A-Z0-9_-]*)(\.[A-Z0-9][A-Z0-9_-]*)+)(:(\d+))?\/?/i.test(v) ? "바른 URL을 입력하셔야 합니다." : false;
			}
			return false;
		},
		// 하나라도 선택 입력(radio or checkbox)
		"validate-one-required" : function(v,elm) {			
			var field_obj  = document.getElementsByName(elm.name);
			if (field_obj.length > 1) {
		        for (var idx = 0; idx < field_obj.length; idx++) {
		            if (field_obj[idx].checked) return false;
		        }
		    } else {
		        if (field_obj.checked) return false;
		    }
			return "항목을 선택하셔야 합니다.";
		},
		// 셀렉트 박스 필수 선택
		"validate-required-select" : function(v, elm) {
			var field_obj = document.getElementById(elm.name);

			if(field_obj.options[field_obj.selectedIndex].value != "")
				return false;

			return "항목을 선택하셔야 합니다.";

		},
		// 유효한 주민번호 앞자리 검증
		"validate-front-jumin" : function(v) {

			if (v.length !=6 || isNaN(v)) {
				return "주민등록번호 앞자리는 숫자 6자리여야 합니다.";
			}

			return false ;
		},
		// 유요한 주민번호 뒷자리 검증
		"validate-back-jumin" : function(v) {
			var check_digit2;

			if (v.length!=7 || isNaN(v)) {
				return "주민등록번호 뒷자리는 숫자 7자리여야 합니다.";
			}

			return false;
		},
		// 유효한 전체 주민번호 검증
		"validate-full-jumin" : function(v) {

			val = v.replace(/-/g, "");
			
			pin1 = val.substring(0,6);
			pin2 = val.substring(6,13);

			if (pin1.length!=6 || isNaN(pin1)) {
				return "주민등록번호 앞자리는 6자리 숫자여야 합니다.";
			}
			
			var a1=pin1.substring(0,1)
			var a2=pin1.substring(1,2)
			var a3=pin1.substring(2,3)
			var a4=pin1.substring(3,4)
			var a5=pin1.substring(4,5)
			var a6=pin1.substring(5,6)
			
			check_digit1 = a1*2 + a2*3 + a3*4 + a4*5 + a5*6 + a6*7;
			
			if (pin2.length!=7 || isNaN(pin2)) {
				return "주민등록번호 뒷자리는 7자리 숫자여야 합니다.";
			}

			var b2=pin2.substring(1,2)
			var b3=pin2.substring(2,3)
			var b4=pin2.substring(3,4)
			var b5=pin2.substring(4,5)
			var b6=pin2.substring(5,6)
			var b7=pin2.substring(6,7)
			
			check_digit2 = check_digit1 + b1*8 + b2*9 + b3*2 + b4*3 + b5*4 + b6*5;
			
			check_digit2 = check_digit2 % 11
			check_digit2 = 11 - check_digit2
			check_digit2 = check_digit2 % 10
			
			if (check_digit2 != b7){
				return "유효하지 않는 주민등록번호입니다.";
			}

			return false;
		},
		// BYTE 단위로 최대 글자수를 제한
        "validate-max-length" : function(v, elm, length) {
			var maxSize = parseInt(length, 10);
            var len = 0;
            var str = v.substring(0);
            if(str == null) return "길이를 확인할 값이 없습니다.";
            for(var i=0; i<str.length; i++) {
                var ch = escape(str.charAt(i));
                if(ch.length == 1) len++;
                else if(ch.indexOf("%u") != -1) len += 3;
                else if(ch.indexOf("%") != -1) len += ch.length/3;
            }

            if(maxSize < len) {
                return "최대 "+maxSize+" byte 까지 입력 가능합니다.";
            }
            return false;
        },
		// BYTE 단위로 최소 글자수를 제한
        "validate-min-length" : function(v, elm, length) {
			var minSize = parseInt(length, 10);
            var len = 0;
            var str = v.substring(0);
            if(str == null) return "길이를 확인 할 값이 없습니다.";
            for(var i=0; i<str.length; i++) {
                var ch = escape(str.charAt(i));
                if(ch.length == 1) len++;
                else if(ch.indexOf("%u") != -1) len += 3;
                else if(ch.indexOf("%") != -1) len += ch.length/3;
            }

            if(minSize > len) {
                return "최소 "+minSize+" byte 를 입력 해야 합니다.";
            }
            return false;
        },
        // BYTE 단위로 범위내의 글자수를 체크
        "validate-limit-length" : function(v, elm, param) {
        	if(param.length == 2) {
	        	var minSize = parseInt(param[0], 10);
	        	var maxSize = parseInt(param[1], 10);
	            var len = 0;
	            var str = v.substring(0);
	            if(str == null) return "길이를 확인 할 값이 없습니다.";
	            for(var i=0; i<str.length; i++) {
	                var ch = escape(str.charAt(i));
	                if(ch.length == 1) len++;
	                else if(ch.indexOf("%u") != -1) len += 3;
	                else if(ch.indexOf("%") != -1) len += ch.length/3;
	            }

	            if(minSize > len || maxSize < len) {
	                return "최소 "+minSize+" byte 보다  같거나  크고, "+maxSize+" 보다  같거나  작아야 합니다.";
	            }
        	} else {
                return "최소 값과 최대 값 두개의 배열 인자가 필요합니다.";
        	}
        	
            return false;
        },
        // 전화번호 유효성 체크 02-222-2222 형식 '-' 토큰으로 잘라서 검증함
        "validate-tel-num" : function(v, elm, param) {
        	if(v) {
        		val = v.replace(/-/g, "");
        	
        		if(isNaN(val)) {
        			return "숫자, - 만 입력하셔야 합니다.";
        		}
        		
        		var tmpArray = v.split("-");
        		if(tmpArray.length != 3) {
        			return "-를 포함하여  정확히  입력하셔야 합니다.";
        		}
        		for(i = 0; i < tmpArray.length; i++ ) {
        			if(tmpArray[i] == "") return "정확히  입력하셔야 합니다.";
        		}
        	}
        	
            return false;
        },
        // 웹상에서 사용가능한 이미지 파일 종류인지 확인한다. gif, jpg, png 만 인정함
        "validate-is-image" : function(v) {
        	if(v) {
            	var ext = "";
	        	if(v.indexOf(".") >= 0) {
	        		ext= v.substring(v.lastIndexOf(".")+1);
	        		if(ext.length != 3 || !(ext == "gif" || ext == "jpg" || ext == "png"))
	        			return "파일은 gif, jpg, png 파일만 등록을 하실수 있습니다.";
	        	} else {
	        		return "파일의 확장자가 없습니다.";
	        	}
        	}
            return false;
        }
        
	}