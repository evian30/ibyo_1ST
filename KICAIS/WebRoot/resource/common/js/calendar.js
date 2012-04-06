function MakeArray(n) { 
    this.length = n; return this; 
}

function getFirstDay(theYear){
    var firstDate = new Date(theYear,this.offset,1);
    return firstDate.getDay();
}

function aMonth(name,length,offset) {
    this.name = name;
    this.length = length;
    this.offset = offset;
    this.getFirstDay = getFirstDay;
}

function getFebLength(theYear) {
    theYear = (theYear < 1900) ? theYear + 1900: theYear;
    if ((theYear % 4 == 0 && theYear % 100 != 0) || theYear % 400 == 0) {
        return 29;
    }
    return 28;
}

theMonths = new MakeArray(12);
theMonths[1] = new aMonth("January",31,0);
theMonths[2] = new aMonth("February",28,1);
theMonths[3] = new aMonth("March",31,2);
theMonths[4] = new aMonth("April",30,3);
theMonths[5] = new aMonth("May",31,4);
theMonths[6] = new aMonth("June",30,5);
theMonths[7] = new aMonth("July",31,6);
theMonths[8] = new aMonth("August",31,7);
theMonths[9] = new aMonth("September",30,8);
theMonths[10] = new aMonth("October",31,9);
theMonths[11] = new aMonth("November",30,10);
theMonths[12] = new aMonth("December",31,11);

//오늘
var today= new Date();
var toy = today.getYear();
var tom = today.getMonth();
var tod = today.getDate();
var toh = today.getHours();
var ton = today.getMinutes();

var form="";
var name="";
var calendarForm = "calendarForm";

//기본틀 뿌려주기
function writedate(form,name) {
    this.form = form;
    this.name = name;
    var content = "<form name='"+calendarForm+"'>";
        content += "<DIV class='Carlender' id='div1' style='DISPLAY:none;WIDTH:184px;HEIGHT:17px;border:0px' onblur='closeCarlender()'>";
        content += "<CENTER>";
        content += "<TABLE class='H' bgcolor='#d5d5d5' cellpadding=0 cellspacing=0 style='border-style:solid;border-width:1;'>";
        
        content += "<TR>";
        content += "<td COLSPAN=7 align=right bgcolor='#EEE8D2'>";
        content += "<a href='#' onclick='now_set(\""+form+"\",\""+name+"\")'>now</a>&nbsp;&nbsp;";
        content += "<input type=text style='width:34px;' name='"+ name +"Year' readonly>년 ";
        content += "<input type=text style='width:18px;' name='"+ name +"Month' readonly>월 ";
        content += "<input type=button value='◀' style='font-size:10;' onclick='stepmove(\""+form+"\",\""+name+"\",-1)'>";
        content += "<input type=button value='▶' style='font-size:10;' onclick='stepmove(\""+form+"\",\""+name+"\",1)'>";
        content += "<input type=button value='Ⅹ' style='font-size:10;' onclick='closeCarlender()'>";
        content += "</td></TR>";

        content += "<TR bgcolor=#F4EFC6 style='font-family:돋움;font-size:12;'>";
        content += "<td style='color:red'>일</td><td>월</td><td>화</td><td>수</td><td>목</td><td>금</td><td style='color:blue'>토</td></TR>";

    for (i=1,d=1; i<=6; i++) {
        content += "<tr>";
        content += "<td><INPUT class='Carlender' TYPE='text' NAME='"+name+"Day' style='width:17px;border:0;color:red' readonly onclick='clickday(\""+form+"\",\""+name+"\","+d+")' onmouseover='mouseoverit(this)' onmouseout='mouseoutit(this)'></TD>";
        d++;
        for (k=2; k<7; k++,d++) {
            content += "<TD><INPUT class='Carlender' TYPE='text' NAME='"+name+"Day' style='width:17px;border:0;' readonly onclick='clickday(\""+form+"\",\""+name+"\","+d+")' onmouseover='mouseoverit(this)' onmouseout='mouseoutit(this)'></TD>";
        }
        content += "<td><INPUT TYPE='text' class='Carlender' NAME='"+name+"Day' style='width:17px;border:0;color:blue' readonly onclick='clickday(\""+form+"\",\""+name+"\","+d+")' onmouseover='mouseoverit(this)' onmouseout='mouseoutit(this)'></TD>";
        content += "</tr>";
        d++;
    }
    
    content += "<div id='div2' style='DISPLAY:none;HEIGHT:17px;border:0px'>";
    content += "<tr><td colspan='7'>";
    content += " <input type=text style='width:18px;' name='"+name+"Dayno' readonly>일";
    content += " <select name='"+name+"Hour'>";
    for (var i=0;i<24;i++) { content += "<option value="+i+">"+i+"</option>"; }
    content += "</select>시 ";
    
    content += "<select name='"+name+"Minute'>";
    for (var i=0;i<60;i++) { content += "<option value="+i+">"+i+"</option>"; }
    content += "</div>분";
    content += "<INPUT type='button' value='입력' onclick='getdate()'>";

    content += "</td></tr></span>";

    content += "</TABLE></CENTER></DIV></form>";
    
/*
    content += "<div class='Carlender' id='div2' style='DISPLAY:none;WIDTH:240px;HEIGHT:17px;border:0px'><TABLE class='H' border='0'><tr><td>"
    content += " <input type=text style='width:18px;' name='"+name+"Dayno' readonly>일"
    content += " <select name='"+name+"Hour'>"
    for (var i=0;i<24;i++) { content += "<option value="+i+">"+i+"</option>" }
    content += "</select>시 "
    
    content += "<select name='"+name+"Minute'>"
    for (var i=0;i<60;i++) { content += "<option value="+i+">"+i+"</option>" }
    content += "</select>분"
    content += "<INPUT type='button' value='입력' onclick='getdate()'>"

    content += "</td></tr></TABLE></div>"
*/
    document.write(content);

    return;
}

var oldColor;
function mouseoverit(obj) {
    oldColor=obj.style.background;
    
    obj.style.background='#dddddd';
    
}

function mouseoutit(obj) {
        obj.style.background=oldColor;
}

function getdate() {

    var tmpYear = eval("document."+calendarForm+"."+name+"Year").value;
    var tmpMonth = eval("document."+calendarForm+"."+name+"Month").value;
    var tmpDay = eval("document."+calendarForm+"."+name+"Dayno").value;
    var tmpHour = eval("document."+calendarForm+"."+name+"Hour").value;
    var tmpMinute = eval("document."+calendarForm+"."+name+"Minute").value;

    var str = tmpYear;
    
    if(tmpMonth < 10)
        str += "0";

    str += tmpMonth;

    if(tmpDay < 10)
        str += "0";

    str += tmpDay;

    if(tmpHour < 10)
        str += "0";

    str += tmpHour;

    if(tmpMinute < 10)
        str += "0";

    str += tmpMinute;
    str += "00";
    
    //alert(str);
    setTxt_Date.value=str;
    
    document.all["div1"].style.display="none";
    document.all["div2"].style.display="none";
}
function closeCarlender() {
    document.all["div1"].style.display="none";
    document.all["div2"].style.display="none";
}
    
var setYear;
var setMonth;
var setDay;
var setTxt_Date;

function ShowCarlenderOnImg(Txt_Date, type) {
    ShowCarlender(Txt_Date, event.clientX, event.clientY, type);
}

function ShowCarlender(Txt_Date,left,top,type) {
    setTxt_Date=Txt_Date;
    
    if(Txt_Date.value=='') {
        now_set(form,name);
    } else {   
        //200307230512
        var str = Txt_Date.value;

        setYear=str.substring(0,4);
        setMonth=parseInt(str.substring(4,6),10);
        setDay=parseInt(str.substring(6,8),10);

        viewdate(form,name,setYear,setMonth-1);

        eval("document."+calendarForm+"."+name+"Dayno").value = setDay;
        if(str.length > 8) {
            var hourTxt = parseInt(str.substring(8,10),10);
            var dayTxt = parseInt(str.substring(10,12),10);

            eval("document."+calendarForm+"."+name+"Hour").options[hourTxt].selected = true;
            eval("document."+calendarForm+"."+name+"Minute").options[dayTxt].selected = true;
        }
    }

    document.all["div2"].style.top=top+152; 
    document.all["div2"].style.left=left;   
    
    
    document.all["div1"].style.top=top; 
    document.all["div1"].style.left=left;   
    
    document.all["div1"].style.display="block"; 
    
    if(type=='ymd') {
        document.all["div2"].style.display="none";
    } else {
        document.all["div2"].style.display="block";
    }
}


//맞는 월로 수정하기
function viewdate(form,name,y,m) {

    var tar = "document."+calendarForm+"."+name;

    //월 첫날 기준
    if (y<=0 || m<0) {  
        y=toy;
        m=tom;
    }
    var thisdate = new Date(y,m,1);

    var samemonth = false;
    if (toy==y && tom==m) samemonth = true;

    var dayoffset = thisdate.getDay();
    if (m==1) { theMonths[2].length = getFebLength(y); }

    var howlong =  theMonths[m+1].length;

    eval(tar+"Year").value = y;
    eval(tar+"Month").value = m+1;

    for (var i=0; i<42; i++) {
        eval(tar+"Day["+i+"]").style.background="white";
        if (i<dayoffset || i>=(howlong + dayoffset)) {  eval(tar+"Day["+i+"]").value = ""; }
        else {  eval(tar+"Day["+i+"]").value = i - dayoffset + 1; }
    }
    
    if(eval(tar+"Year").value==setYear && eval(tar+"Month").value==eval(setMonth)) {
        eval(tar+"Day["+eval(dayoffset+eval(setDay)-1)+"]").style.background="#aaffee";
    }
    if (toy==y && tom==m) { eval(tar+"Day["+eval(dayoffset+tod-1)+"]").style.background="yellow"; }
}

function now_set(form,name) {
    
    viewdate(form,name,toy,tom);

    eval("document."+calendarForm+"."+name+"Dayno").value = tod;
    eval("document."+calendarForm+"."+name+"Hour").options[toh].selected = true;
    eval("document."+calendarForm+"."+name+"Minute").options[ton].selected = true;

    return;
}

//
function clickday(form,name,num) {
    
    var tar = "document."+calendarForm+"."+name;
    var y = eval(tar+"Year").value;
    var m = eval(eval(tar+"Month").value) - 1;
    var thisdate = new Date(y,m,1);
    var day = eval(tar+"Day["+eval(num-1)+"]").value;

    if (day.length>0) {
        for (var i=0; i<42; i++) {  eval(tar+"Day["+i+"]").style.background="white"; }
        if (toy==y && tom==m) { eval(tar+"Day["+ eval(num-day+tod-1)+"]").style.background="yellow"; }
        eval(tar+"Day["+eval(num-1)+"]").style.background="#cc99cc";
        eval(tar+"Dayno").value = day;
    }
    oldColor="#cc99cc";
    if(document.all["div2"].style.display=="none") {
        var tmpYear = eval("document."+calendarForm+"."+name+"Year").value;
        var tmpMonth = eval("document."+calendarForm+"."+name+"Month").value;
        var tmpDay = eval("document."+calendarForm+"."+name+"Dayno").value;

        var str = tmpYear;

	    if(parseInt(tmpMonth,10) < 10)
	        str += "0";

	    str += tmpMonth;
	
	    if(parseInt(tmpDay,10) < 10)
	        str += "0";
	
	    str += tmpDay;
    
        setTxt_Date.value=str;
        closeCarlender();
    }
    return;
}

//달 이동 하기
function stepmove(form,name,step) {
    var tar = "document."+calendarForm+"."+name;
    var y = eval(tar+"Year").value;
    var m = eval(eval(tar+"Month").value) + eval(step) - 1;

    if (m>=12) {    y=eval(y)+1;    m=0;    }
    if (m<0) {      y=eval(y)-1;    m=11;   }
    var d;
    viewdate(form,name,y,m,d);
    return;
}