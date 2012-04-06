// When you want to include this popup in a page you MUST:
// 1) create a named div for the popup to attach to in the page.
//    It should look like <div id="mypopup"></div>. Do not put
//    the div anywhere in a table. It should be outside tables.
// 2) create a stylesheet id selector entry for your div. It
//    MUST be position absolute and should look like:
//    #mypopup{ position: absolute;
//              visibility: hidden;
//              background-color: "#99BDDF";
//              layer-background-color: "#99BDDF"; }
// 3) call the popup with code that looks like
//    <a href="#" onClick="calPopup(this,'mypopup',-175,15,'additemform','valiDate');">
//    where -175 and 15 are your desired x and y offsets from the link.
//    The final argument indicates the validation script to run after
//    the popup makes a change to the form. This argument is optional.

var nn4 = (document.layers) ? true : false;
var ie  = (document.all) ? true : false;
var dom = (document.getElementById && !document.all) ? true : false;
var popups = new Array(); // keeps track of popup windows we create
var calHtml = '';

// language and preferences
wDay = new Array('일요일','월요일','화요일','수요일','목요일','금요일','토요일');
wDayAbbrev = new Array('<font color=#CC0000>일</font>','월','화','수','목','금','<font color=#0000CC>토</font>');
wMonth = new Array('1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월');
wOrder = new Array('첫번째','두번째','세번째','네번째','마지막');
wStart = 0;

function calPopup(obj, id, xOffset, yOffset, inputName, validationScript) {
	
   attachListener(id);	 
   registerPopup(id);	 
   calHtml = makeCalHtml(id,null,null,null,inputName,validationScript);	 
   writeLayer(id,calHtml);	 
   setLayerPos(obj,id,xOffset,yOffset);	 
   showLayer(id);	
   return true;
}

function attachListener(id) {
   var layer = new pathToLayer(id);
   if (layer.obj.listening == null) {
      document.oldMouseupEvent = document.onmouseup;
      if (document.oldMouseupEvent != null) {
         document.onmouseup = new Function("document.oldMouseupEvent(); hideLayersNotClicked();");
      } else {
         document.onmouseup = hideLayersNotClicked;
      }
      layer.obj.listening = true;
   }
}

function registerPopup(id) {
   // register this popup window with the popups array
   var layer = new pathToLayer(id);
   if (layer.obj.registered == null) {
      var index = popups.length ? popups.length : 0;
      popups[index] = layer;
      layer.obj.registered = 1;
   }
}

function makeCalHtml(id, calYear, calMonth, calDay, inputName, validationScript) {

   if(eval(inputName).value==""){
     var today = new Date();
     var arrDate = new Array(today.getFullYear(), today.getMonth()+1, today.getDate());
   }else{
     var arrDate = eval(inputName).value.split("-");
   }
   
   if( calYear == null || calYear == "" ) calYear = arrDate[0];
   if( calMonth == null || calMonth == "" ) calMonth = arrDate[1];
   if( calDay == null || calDay == "" ) calDay = arrDate[2];
   var daysInMonth = new Array(0,31,28,31,30,31,30,31,31,30,31,30,31);
   if ((calYear % 4 == 0 && calYear % 100 != 0) || calYear % 400 == 0) {
      daysInMonth[2] = 29;
   }

   var calDate = new Date(calYear,calMonth-1,calDay);

   //-----------------------------------------
   // check if the currently selected day is
   // more than what our target month has
   //-----------------------------------------
   if (calMonth < calDate.getMonth()+1) {
     calDay = calDay-calDate.getDate();
     calDate = new Date(calYear,calMonth-1,calDay);
   }

   var calNextYear  = calDate.getMonth() == 11 ? calDate.getFullYear()+1 : calDate.getFullYear();
   var calNextMonth = calDate.getMonth() == 11 ? 1 : calDate.getMonth()+2;
   var calLastYear  = calDate.getMonth() == 0 ? calDate.getFullYear()-1 : calDate.getFullYear();
   var calLastMonth = calDate.getMonth() == 0 ? 12 : calDate.getMonth();

   var todayDate = new Date();

   //---------------------------------------------------------
   // this relies on the javascript bug-feature of offsetting
   // values over 31 days properly. Negative day offsets do NOT
   // work with Netscape 4.x, and negative months do not work
   // in Safari. This works everywhere.
   //---------------------------------------------------------
   var calStartOfThisMonthDate = new Date(calYear,calMonth-1,1);
   var calOffsetToFirstDayOfLastMonth = calStartOfThisMonthDate.getDay() >= wStart ? calStartOfThisMonthDate.getDay()-wStart : 7-wStart-calStartOfThisMonthDate.getDay()
   if (calOffsetToFirstDayOfLastMonth > 0) {
      var calStartDate = new Date(calLastYear,calLastMonth-1,1); // we start in last month
   } else {
      var calStartDate = new Date(calYear,calMonth-1,1); // we start in this month
   }
   var calStartYear = calStartDate.getFullYear();
   var calStartMonth = calStartDate.getMonth();
   var calCurrentDay = calOffsetToFirstDayOfLastMonth ? daysInMonth[calStartMonth+1]-(calOffsetToFirstDayOfLastMonth-1) : 1;

   var html = '';
   // writing the <html><head><body> causes some browsers (Konquerer) to fail

html += '<table border=0 cellpadding=0 cellspacing=0 bgcolor="#EEEEFF" align="">\n';
html += '<tr height=9>\n';
html += '<td width=9></td>\n';
html += '<td height=9 wight=9></td>\n';
html += '<td width=9></td>\n';
html += '</tr><tr>\n';
html += '<td height=9 wight=9>&nbsp;</td>\n';
html += '<td>\n';
   // inner
   html += '<table width=100% cellpadding="0" cellspacing="1" border="0" bgcolor="#FFFFFF">\n';
   html += '<tr>\n';
   html += '<td valign="top">\n';
   html += '<table width=100% cellpadding="3" cellspacing="1" border="0">\n';
   html += '<tr>\n';
   html += '<td colspan=2><a class="stylecal" href="#" onClick="updateCal(\''+id+'\','+calLastYear+','+calLastMonth+','+calDay+',\''+inputName+'\',\'\'); return false;">◁</a>';
   html += '<a class="stylecal" href="#" onClick="updateCal(\''+id+'\','+eval(calLastYear-1)+','+calLastMonth+','+calDay+',\''+inputName+'\',\'\'); return false;">◀</a></td>\n';
   html += '<td style="font-size:11px" align="center" colspan="3">'+calDate.getFullYear()+'년 '+wMonth[calDate.getMonth()]+ '</td>\n';
   html += '<td colspan=2 align=right><a class="stylecal" href="#" onClick="updateCal(\''+id+'\','+eval(calNextYear+1)+','+calNextMonth+','+calDay+',\''+inputName+'\',\'\'); return false;">▶</a>';
   html += '<a class="stylecal" href="#" onClick="updateCal(\''+id+'\','+calNextYear+','+calNextMonth+','+calDay+',\''+inputName+'\',\'\'); return false;">▷</a></td>\n';
   html += '</tr>\n';
   for (var row=1; row <= 7; row++) {
      // check if we started a new month at the beginning of this row
      upcomingDate = new Date(calStartYear,calStartMonth,calCurrentDay);
      if (upcomingDate.getDate() <= 8 && row > 5) {
         continue; // skip this row
      }

      html += '<tr>\n';
      for (var col=0; col < 7; col++) {
         //var tdColor = col % 2 ? '"#DAEDFE"' : '"#F8F8F8"';
         var tdColor = '"#F3F3F3"';
         if (row == 1) {
            tdColor = '"#EEEEFF"';
            html += '<td width="16" bgcolor='+tdColor+' align="center" class="stylecal">'+wDayAbbrev[(wStart+col)%7]+'</td>\n';
         } else {
            var hereDate = new Date(calStartYear,calStartMonth,calCurrentDay);
            var hereDay = hereDate.getDate();
            var aClass = '"stylecal"';

            if (hereDate.getFullYear() == todayDate.getFullYear() && hereDate.getMonth() == todayDate.getMonth() && hereDate.getDate() == todayDate.getDate()) {
               tdColor = '"#99AAFF"';
            }
            if (hereDate.getMonth() != calDate.getMonth()) {
               tdColor = '"#CCCCCC"';
               var aClass = '"notmonth"';
            }

            html += '<td width="16" bgcolor='+tdColor+' align="right" onClick="changeFormDate('+hereDate.getFullYear()+','+(hereDate.getMonth()+1)+','+hereDate.getDate()+',\''+inputName+'\',\''+validationScript+'\'); hideLayer(\''+id+'\'); return false;" onMouseOver="this.className=\'row_on_a\'" onMouseOut="this.className=\'row_off\'"><a class='+aClass+' href="#" onClick="changeFormDate('+hereDate.getFullYear()+','+(hereDate.getMonth()+1)+','+hereDate.getDate()+',\''+inputName+'\',\''+validationScript+'\'); hideLayer(\''+id+'\'); return false;">'+hereDay+'</a></td>\n';
            calCurrentDay++;
         }
      }
      html += '</tr>\n';
   }
   html += '<tr>\n';
   html += '<td align="center" bgcolor=#FFFFFF colspan="7" onClick="updateCal(\''+id+'\','+todayDate.getFullYear()+','+(todayDate.getMonth()+1)+','+todayDate.getDate()+',\''+inputName+'\',\''+validationScript+'\'); return false;"><a class="stylecal" href="#" onClick="updateCal(\''+id+'\','+todayDate.getFullYear()+','+(todayDate.getMonth()+1)+','+todayDate.getDate()+',\''+inputName+'\',\''+validationScript+'\'); return false;">오늘로 이동</a></td>\n';
   html += '</tr>\n';
   html += '</table>\n';
   html += '</td></tr>\n';
   html += '</table>\n';
// end of inner
html += '</td>\n';
html += '<td height=9 wight=9>&nbsp;</td>\n';
html += '</tr><tr height=9>\n';
html += '<td width=9></td>\n';
html += '<td height=9 wight=9></td>\n';
html += '<td width=9></td>\n';
html += '</tr>\n';
html += '</table>\n';
   return html;
}

function updateCal(id, calYear, calMonth, calDay, inputName, validationScript) {
   
   calHtml = makeCalHtml(id,calYear,calMonth,calDay,inputName,validationScript);
   writeLayer(id,calHtml);
}

function writeLayer(id, html) {
   var layer = new pathToLayer(id);
   if (nn4) {
      layer.obj.document.open();
      layer.obj.document.write(html);
      layer.obj.document.close();
   } else {
      layer.obj.innerHTML = '';
      layer.obj.innerHTML = html;
   }
}

function setLayerPos(obj, id, xOffset, yOffset) {
   var newX = 0;
   var newY = 0;
   if (obj.offsetParent) {
      // if called from href="setLayerPos(this,'example')" then obj will
      // have no offsetParent properties. Use onClick= instead.
      while (obj.offsetParent) {
         newX += obj.offsetLeft;
         newY += obj.offsetTop;
         obj = obj.offsetParent;
      }
   } else if (obj.x) {
      // nn4 - only works with "a" tags
      newX += obj.x;
      newY += obj.y;
   }

   // apply the offsets
   newX += xOffset;
   newY += yOffset;

   // apply the new positions to our layer
//   var layer = new pathToLayer(id);
   var layer = document.getElementById( id );
   if (nn4) {
      layer.style.left = newX;
      layer.style.top  = newY;
   } else {
      // the px avoids errors with doctype strict modes
      layer.style.left = newX + 'px';
      layer.style.top  = newY + 'px';
   }
}

function hideLayersNotClicked(e) {
   if (!e) var e = window.event;
   e.cancelBubble = true;
   if (e.stopPropagation) e.stopPropagation();
   if (e.target) {
      var clicked = e.target;
   } else if (e.srcElement) {
      var clicked = e.srcElement;
   }

   // go through each popup window,
   // checking if it has been clicked
   for (var i=0; i < popups.length; i++) {
      if (nn4) {
         if ((popups[i].style.left < e.pageX) &&
             (popups[i].style.left+popups[i].style.clip.width > e.pageX) &&
             (popups[i].style.top < e.pageY) &&
             (popups[i].style.top+popups[i].style.clip.height > e.pageY)) {
            return true;
         } else {
            hideLayer(popups[i].obj.id);
            return true;
         }
      } else if (ie) {
         while (clicked.parentElement != null) {
            if (popups[i].obj.id == clicked.id) {
               return true;
            }
            clicked = clicked.parentElement;
         }
         hideLayer(popups[i].obj.id);
         return true;
      } else if (dom) {
         while (clicked.parentNode != null) {
            if (popups[i].obj.id == clicked.id) {
               return true;
            }
            clicked = clicked.parentNode;
         }
         hideLayer(popups[i].obj.id);
         return true;
      }
      return true;
   }
   return true;
}

function pathToLayer(id) {
   if (nn4) {
      this.obj = document.layers[id];
      this.style = document.layers[id];
   } else if (ie) {
      this.obj = document.all[id];
      this.style = document.all[id].style;
   } else {
      this.obj = document.getElementById(id);
      this.style = document.getElementById(id).style;
   }
}

function showLayer(id) {
   var layer = new pathToLayer(id)
   layer.style.visibility = "visible";
   //hideSelectList(layer);
}

function hideLayer(id) {
   var layer = new pathToLayer(id);
   layer.style.visibility = "hidden";
   showSelectList();
}

function changeFormDate(changeYear,changeMonth,changeDay,inputName,validationScript) {

	if (changeMonth < 10) changeMonth = "0"+changeMonth;
	if (changeDay < 10) changeDay = "0"+changeDay;
	
	//if (!document.all) { changeYear += 1900 ;}
	eval(inputName).value = changeYear + "-" + changeMonth + "-" + changeDay;
}

function hideSelectList(layer_id)
{
    var ly = eval(layer_id);

    // 레이어 좌표
    var ly_left  = ly.offsetLeft;
    var ly_top    = ly.offsetTop;
    var ly_right  = ly.offsetLeft + ly.offsetWidth;
    var ly_bottom = ly.offsetTop + ly.offsetHeight;

    // 셀렉트박스의 좌표
    var el;
    for (i=0; i<document.forms.length; i++) {
        for (k=0; k<document.forms[i].length; k++) {
            el = document.forms[i].elements[k];
            if (el.type == "select-one") {
                var el_left = el_top = 0;
                var obj = el;

                if (obj.offsetParent) {
                    while (obj.offsetParent) {
                        el_left += obj.offsetLeft;
                        el_top  += obj.offsetTop;
                        obj = obj.offsetParent;
                    }
                }
                el_left  += el.clientLeft;
                el_top    += el.clientTop;
                el_right  = el_left + el.clientWidth;
                el_bottom = el_top + el.clientHeight;

                // 좌표를 따져 레이어가 셀렉트 박스를 침범했으면 셀렉트 박스를 hidden 시킴
                if ( (el_left >= ly_left && el_top >= ly_top && el_left <= ly_right && el_top <= ly_bottom) ||
                    (el_right >= ly_left && el_right <= ly_right && el_top >= ly_top && el_top <= ly_bottom) ||
                    (el_left >= ly_left && el_bottom >= ly_top && el_right <= ly_right && el_bottom <= ly_bottom) ||
                    (el_left >= ly_left && el_left <= ly_right && el_bottom >= ly_top && el_bottom <= ly_bottom) )
                    el.style.visibility = 'hidden';
            }
        }
    }
}

// 감추어진 셀렉트 박스를 모두 보이게 함
function showSelectList()
{
    for (i=0; i<document.forms.length; i++) {
        for (k=0; k<document.forms[i].length; k++) {
            el = document.forms[i].elements[k];
            if (el.type == "select-one" && el.style.visibility == 'hidden')
                el.style.visibility = 'visible';
        }
    }
}