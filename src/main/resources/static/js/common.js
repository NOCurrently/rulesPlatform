var dialogReturnValue = "";
var bFocusable = true;
var UNITREE_PAGETYPE_1 = 1;
var UNITREE_PAGETYPE_2 = 2;
var UNITREE_PAGETYPE_3 = 3;
var UNITREE_PAGETYPE_4 = 4;
var UNITREE_PAGETYPE_5 = 5;
var UNITREE_PAGETYPE_6 = 6;
var MSG_PLEASE_WAIT = "\u9518\u80ef\ue1ec\u7ecb\u5d87\u74d1...";
var MSG_LOAD_FAIL = "Load failed...";

var ENTERMENU = false;
var showMenu = true;

function trimallspace(s) {
    return s.replace(/\u0020/g, "");
}

function startendtrimspace(s) {
    try {
        return s.replace(/^\s+|\s+$/g, "");
    }
    catch (e) {
        return s;
    }
}

function isinteger(s) {
    var reg = /^(\+|-)?(0|[1-9]\d*)(\.\d*[1-9])?$/;
    if (reg.test(s)) {
        return true;
    }
    return false;
}


function jtrim(sValue) {
    sValue = sValue + "";
    var cVal = sValue.charCodeAt(sValue.length - 1);
    while ((cVal == 32 || cVal == 9) && sValue.length > 0) {
        sValue = sValue.substring(0, sValue.length - 1);
        cVal = sValue.charCodeAt(sValue.length - 1);
    }
    return sValue;
}

//在指定的frame中执行指定的URL
function showurl(frame_name, addr) {
    var frm = window.parent.frames;
    for (i = 0; i < frm.length; i++) {
        if (frm(i).name == frame_name) {
            frm(i).location.href = addr;
        }
    }
}


/**
 * FRED    2005-9-12 Create
 * 去除数字前多余的零，如：0012，格式成：12。
 */
function zerotrim(sValue) {
    sValue = sValue + "";
    var cVal = sValue.charCodeAt(0);
    while ((cVal == 48) && sValue.length > 0) {
        sValue = sValue.substring(1, sValue.length);
        cVal = sValue.charCodeAt(0);
    }
    return sValue;
}
/*
 FRED 2006-06-13 CREATE
 IN:待清空的对象
 把TEXT对象的值置为空，
 */
function clearText(objectName) {
    document.all(objectName).value = "";
}
/*
 FRED 2006-06-13 CREATE
 IN:待清空的对象
 把LABEL对象的值置为空，
 */
function clearLabel(objectName) {
    document.all(objectName).innerText = "";
}


function setSelectValue(name, value) {
    var nameTemp = document.all[name];
    for (var i = 0; i < nameTemp.length; i++) {
        if (nameTemp.options[i].value == value) {
            nameTemp.options[i].selected = "selected";
            //            nameTemp.selectedIndex=i;
            break;
        }
    }
}

function setNull(arr) {
    for (var i = 0; i < arr.length; i++) {
        document.all(arr[i]).value = "";
    }
}

//-------------------------------------
//  无限扩展的年份select
//-------------------------------------

var Lastyear;
function selYear(obj, Cyear, length) {
    var len = length;
    var selObj = document.getElementById(obj);
    var selIndex = parseInt(len / 2) - 1;
    var newOpt;
    var LY = Cyear - Lastyear;
    for (i = 0; i < len; i++) {
        if (selObj.options.length != len) {
            newOpt = document.createElement("OPTION");
            newOpt.text = Cyear - selIndex + i + "年";
            newOpt.value = Cyear - selIndex + i;
            selObj.options.add(newOpt, i);
            if (selIndex == i) {
                Lastyear = newOpt.value;
            }
        }
        else {
            selObj.options[i].text = parseInt(selObj.options[i].text) + LY + "年";
            selObj.options[i].value = parseInt(selObj.options[i].value) + LY;
            if (selIndex == i) {
                Lastyear = selObj.options[i].value;
            }
        }
    }
    selObj.selectedIndex = selIndex;
}

//将回车键事件变为Tab事件
//当是IMG时,则触发IMG的CLICK事件.
function change_event() {
    var eventTarget = window.event.srcElement;
    if (event.keyCode == 13) {
        if (eventTarget.tagName == "TEXTAREA") {
            eventTarget.focus();
        } else if (eventTarget.tagName == "IMG" || eventTarget.tagName == "A") {
            eventTarget.click();
        } else {
            event.keyCode = 9;
        }
    }
}

function selectNodeUnitTree(id, name, no) {
    selectUnitTree(id, name, no);
}

function sToFloat(sValue, nSubLen) {
    var slen, i;
    slen = "";
    for (i = 0; i < nSubLen; i++)
        slen += "0";

    if (sValue.indexOf(".") == -1)
        sValue += ".";
    sValue += slen.substring(0, nSubLen - sValue.substring(sValue.indexOf(".") + 1, sValue.length).length);
    return sValue;
}

function toChineseCurrency(money) {
    var RMB = "";
    var currency = money;
    // 金额为0或者无金额时，不显示大写金额
    if (currency == 0) {
        return RMB
    }
    if (jtrim(currency).length > 0) {
        currency = jtrim(currency);
        var intPartLength = 0, floatPartLength = 0;
        // 整数位及小数位长度
        var dotPosition = 0;
        // 小数点位置
        var intPart = "", floatPart = "";
        // 整数部分及小数部分
        var multiZero = 0;
        // 连续的零的情况
        var maxDigitParts = 0;
        // 每四位存储段的数目
        var prefixZero = false;
        // 是否需要前导‘零’
        var suffixZero = false;
        // 是否需要后置‘零’
        var CHNCHAR = "零壹贰叁肆伍陆柒捌玖拾佰仟万亿";
        var UNIT = "元角分整";
        var i, j = 0;
        // 循环计数器
        var tempnum = 0;
        // 临时存放数字
        dotPosition = currency.indexOf(".");
        if (dotPosition >= 0) {//有小数点
            intPart = currency.substring(0, dotPosition);
            floatPart = currency.substring(dotPosition + 1);
        }
        else {
            intPart = currency;
            floatPart = "";
        }
        intPartLength = intPart.length;
        floatPartLength = floatPart.length;

        // 处理整数部分
        if (intPartLength % 4 == 0) {
            maxDigitParts = intPartLength / 4;
        }
        else {
            maxDigitParts = Math.round(intPartLength / 4 + 0.5);
        }

        var digitPart = new Array(maxDigitParts);
        for (i = 0; i < maxDigitParts; i++) {
            digitPart[i] = "";
        }

        for (j = 0, i = intPartLength - 1; i >= 0; i--) {
            digitPart[j] += intPart.charAt(i);
            if ((intPartLength - i) % 4 == 0) {
                j++;
            }
        }

        for (i = 0; i < maxDigitParts; i++) {
            var tempBuf = "";
            for (j = 0; j < digitPart[i].length; j++) {
                tempnum = digitPart[i].charAt(j) - '0';
                if (tempnum != 0) {
                    if (multiZero > 0) {
                        if (multiZero == j) // 后续都是‘零’
                        {
                            if (i > 0) // ‘万’位以上
                            {
                                if (RMB.length > 0 && RMB.charAt(0) != CHNCHAR.charAt(0)) {
                                    //RMB.insert(0,CHNCHAR.charAt(0));
                                    RMB = insert(RMB, 0, CHNCHAR.charAt(0));
                                }
                                suffixZero = false;
                            }
                        }
                        else {
                            //tempBuf.insert(0,CHNCHAR.charAt(0));
                            tempBuf = insert(tempBuf, 0, CHNCHAR.charAt(0));
                        }
                    }
                    multiZero = 0;
                    switch (j) {
                        case 1:
                            //tempBuf.insert(0,CHNCHAR.charAt(10));
                            tempBuf = insert(tempBuf, 0, CHNCHAR.charAt(10));
                            break;
                        case 2:
                            //tempBuf.insert(0,CHNCHAR.charAt(11));
                            tempBuf = insert(tempBuf, 0, CHNCHAR.charAt(11));
                            break;
                        case 3:
                            //tempBuf.insert(0,CHNCHAR.charAt(12));
                            tempBuf = insert(tempBuf, 0, CHNCHAR.charAt(12));
                    }
                    //tempBuf.insert(0,CHNCHAR.charAt(tempnum));
                    tempBuf = insert(tempBuf, 0, CHNCHAR.charAt(tempnum));
                }
                else {
                    multiZero++;
                    if (j == 0 && i > 0) {
                        suffixZero = true;
                    }
                    if (j == 3) {
                        prefixZero = true;
                    }
                }
            }
            if (suffixZero && multiZero != 4) {
                tempBuf += (CHNCHAR.charAt(0))
                suffixZero = false;
            }
            if (prefixZero && multiZero != 4) {
                //tempBuf.insert(0,CHNCHAR.charAt(0)); // 修正前导‘零’
                tempBuf = insert(tempBuf, 0, CHNCHAR.charAt(0));
                prefixZero = false;
            }
            if (multiZero != 4) {
                switch (i) {
                    case 1: // 加‘万’字
                        //RMB.insert(0,CHNCHAR.charAt(13));
                        RMB = insert(RMB, 0, CHNCHAR.charAt(13));
                        break;
                    case 2: // 加‘亿’字
                        //RMB.insert(0,CHNCHAR.charAt(14));
                        RMB = insert(RMB, 0, CHNCHAR.charAt(14));
                        break;
                }
            }
            multiZero = 0;
            prefixZero = false;
            suffixZero = false;
            RMB = insert(RMB, 0, tempBuf);
        }
        if (parseInt(intPart) != 0) {
            RMB += (UNIT.charAt(0));
            // 加‘元’字
        }
        // 处理小数部分
        if (floatPartLength == 0 || "0" == (floatPart) || "00" == (floatPart)) {
            RMB += (UNIT.charAt(3));
        }
        else {
            tempnum = floatPart.charAt(0) - '0';
            if (tempnum != 0 || RMB.length > 0) {
                RMB += (CHNCHAR.charAt(tempnum));
            }
            if (tempnum != 0) {
                RMB += (UNIT.charAt(1));
                // 加‘角’字
            }
            if (floatPartLength == 2) {
                tempnum = floatPart.charAt(1) - '0';
                if (tempnum != 0) {
                    RMB += (CHNCHAR.charAt(tempnum));
                    RMB += (UNIT.charAt(2));
                    // 加‘分’字
                }
            }
        }
    }
    return RMB;
}

//转换日期为大写（中文），如：一二三四五六七八九日； 
//为方便利用以前的结果，参数date样式约定为2013年11月19日
function toChineseDate(date) {
    var chinese = ['〇', '一', '二', '三', '四', '五', '六', '七', '八', '九'];
    var y = date.substring(0, 4);
    var m = Math.round(date.substring(5, 7)) + "";
    var d = Math.round(date.substring(8, 10)) + "";
    var result = "";
    for (var i = 0; i < y.length; i++) {
        result += chinese[y.charAt(i)];
    }
    result += "年";
    if (m.length == 2) {
        if (m.charAt(0) == "1") {
            result += ("十" + chinese[m.charAt(1)] + "月");
        }
    } else {
        result += (chinese[m.charAt(0)] + "月");
    }
    if (d.length == 2) {
        if (d == '10') {
            result += "十日";
        } else {
            result += (chinese[d.charAt(0)] + "十");
            if (chinese[d.charAt(1)] != '〇') {
                result += chinese[d.charAt(1)];
            }
            result += "日";
        }
    } else {
        result += (chinese[d.charAt(0)] + "日");
    }
    return result;
}


// .00转换成0.00,其它不变化
function addZero(zero) {
    var result = zero + "";
    if (result == '.00') {
        result = '0.00';
    }
    return result;
}

function jtrim(sValue) {
    sValue = sValue + "";
    var cVal = sValue.charCodeAt(sValue.length - 1);
    while ((cVal == 32 || cVal == 9) && sValue.length > 0) {
        sValue = sValue.substring(0, sValue.length - 1);
        cVal = sValue.charCodeAt(sValue.length - 1);
    }
    return sValue;
}

function insert(oriStr, offset, strToIst) {
    var sRet = "";
    sRet = oriStr.substring(0, offset) + strToIst + oriStr.substr(offset)
    return sRet;
}


//时间格式化
Date.prototype.format = function (format) {
    if (!format) {
        format = "yyyy-MM-dd hh:mm:ss";
    }
    var o = {
        "M+": this.getMonth() + 1, // month
        "d+": this.getDate(), // day
        "h+": this.getHours(), // hour
        "m+": this.getMinutes(), // minute
        "s+": this.getSeconds(), // second
        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
        "S": this.getMilliseconds()
        // millisecond
    };
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
};
function formatDateTime(value) {
    if (value == null || value == "" || value == undefined) {
        return "";
    }
    var time = value["time"];
    return new Date(time).format("yyyy-MM-dd hh:mm:ss");
}

function formatDate(value) {
    if (value == null || value == "" || value == undefined) {
        return "";
    }
    var time = value["time"];
    return new Date(time).format("yyyy-MM-dd");
}
function formatDateStr(value) {
    if (value == null || value == "" || value == undefined) {
        return "";
    }
    var time = value["time"];
    return new Date(time).format("yyyyMMdd");
}

function alertShow(message) {
    $.messager.show({
        title: '',
        msg: message,
        timeout: 5000,
        showType: 'slide'
    });
}


//弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
    $.messager.alert(title, msgString, msgType);
}

function alertError(message) {
    $.messager.alert('系统错误提示', message, 'error');
}

function alertWarn(message) {
    $.messager.alert('系统警告提示', message, 'warning');
}

function alertInfo(message) {
    $.messager.alert('系统信息提示', message, 'info');
}

function alertQuest(message) {
    $.messager.alert('系统问题提示', message, 'question');
}

function alertMsg(obj) {
    if (obj.success == true) {
        alertInfo(obj.message);
    } else if (obj.success == false) {
        alertError(obj.message);
    } else {
        alertWarn(obj.message);
    }
}

function trim(str) {
    return str.replace(/(^\s*)|(\s*$)/g, "");
}

function ltrim(str) {
    return str.replace(/(^\s*)/g, "");
}

function rtrim(str) {
    return str.replace(/(\s*$)/g, "");
}


//****************************************************************

//*名称dataLength
//*功能：计算数据的长度
//*入口参数fData：需要计算的数据
//*出口参数：返回fData的长度(Unicode长度为2，非Unicode长度为1) 

//***************************************************************** 

function dataLength(fData) {

    var intLength = 0

    for (var i = 0; i < fData.length; i++) {

        if ((fData.charCodeAt(i) < 0) || (fData.charCodeAt(i) > 255))

            intLength = intLength + 3

        else

            intLength = intLength + 1

    }

    return intLength

}
//*名称checkLength
//*功能：验证是否超过长度
//*入口参数fDate,length
//*出口参数：true 超过长度 false:不超过长度

function checkLength(fDate, length) {
    if (dataLength(fDate) > length) {
        return true;
    } else {
        return false;
    }
}


//****************************************************************
//* 名称：isEmpty 
//*功能：判断是否为空
//*入口参数：fData：要检查的数据 
//*出口参数：True：空                       
//*           False：非空
//***************************************************************** 

function isEmpty(fData) {

    return ((fData == null) || (fData.length == 0) || (trim(fData) == '') || fData == undefined)
}

//****************************************************************
//* 名称：checkCh 
//*功能：判断是否含有汉字
//*入口参数：obj：要检查的数据 
//*出口参数：True：不含有汉字                       
//*False：含有汉字
//****************************************************************

//密码中不能含有汉字
function checkCh(obj) {
    var reg = new RegExp("[\\u4E00-\\u9FFF]+", "g");
    if (reg.test(obj)) {
        return false;
    }
    return true;
}


//**************************************************************** 

//*名称：isInteger  

//*功能：判断是否为正整数
//*入口参数：fData：要检查的数据
//*出口参数：True：是整数，或者数据是空的
//*           False：不是整数
//***************************************************************** 

function isInteger(fData) {

    //如果为空，返回true

    if (isEmpty(fData))

        return true

    if ((isNaN(fData)) || (fData.indexOf(".") != -1) || (fData.indexOf("-") != -1))

        return false

    return true
}

//**************************************************************** 

//*名称：forcheck  

//*功能：判断是否为正整数
//*入口参数：fData：要检查的数据
//*出口参数：True：是正整数，或者数据是空的
//* False：不是正整数
//***************************************************************** 
function forcheck(ss) {
    var r = /^0|(^[1-9]+\d*$)/;
    return r.test(ss);
}


//****************************************************************  
//* 名称：checkEmail  

//* 功能：判断是否为正确的Email地址
//*入口参数：fData：要检查的数据
//* 出口参数：True：正确的Email地址，或者空
//* False：错误的Email地址
//*****************************************************************

function checkEmail(str) {
    var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
    if (reg.test(str)) {
        return true;
    } else {
        return false;
    }
}


//****************************************************************

//*名称：isPhone 
//*功能：判断是否为正确的电话号码（可以含"()"、"（）"、"+"、"-"和空格）

//*入口参数：fData：要检查的数据
//* 出口参数：True：正确的电话号码，或者空
//*           False：错误的电话号码
//* 错误信息：


//*****************************************************************

function isPhone(fData) {
    var str;
    var fDatastr = "";
    for (var i = 0; i < fData.length; i++) {
        str = fData.substring(i, i + 1);
        if (str != "(" && str != ")" && str != "（" && str != "）" && str != "+" && str != "-" && str != " ")
            fDatastr = fDatastr + str;
    }
    if (isNaN(fDatastr))
        return false
    return true

}


//**************************************************************** 

//*名称：isPlusNumeric  

//*功能：判断是否为正确的正数（可以含小数部分）
//*入口参数：fData：要检查的数据
//* 出口参数：True：正确的正数，或者空
function isPlusNumeric(fData) {
    if (isEmpty(fData))
        return true
    if ((isNaN(fData)) || (fData.indexOf("-") != -1))
        return false
    return true
}


//**************************************************************** 

//*名称：isNumeric  

//* 功能：判断是否为正确的数字（可以为负数，小数）
//*入口参数：fData：要检查的数据
//*出口参数：True：正确的数字，或者空                            
//*           False：错误的数字
//* 错误信息：
//***************************************************************** 
function isNumeric(fData) {
    if (isEmpty(fData))
        return true
    if (isNaN(fData))
        return false
    return true

}
//**************************************************************** 
//* 名称：IsIntegerInRange  
//*功能：判断一个数字是否在指定的范围内
//*入口参数：fInput：要检查的数据
//*           fLower：检查的范围下限，如果没有下限，请用null 
//*           fHigh：检查的上限，如果没有上限，请用null  
//*出口参数：True：在指定的范围内                              
//*           False：超出指定范围
//***************************************************************** 
function isIntegerInRange(fInput, fLower, fHigh) {
    if (fLower == null)
        return (fInput <= fHigh)
    else if (fHigh == null)
        return (fInput >= fLower)
    else
        return ((fInput >= fLower) && (fInput <= fHigh))
}

function format00(money) {
    if (money == '.00' || money == '.0') {
        return '0.00'
    }
}

function viewMessage(sid) {
    var title = '查看详细信息';

    $('#viewDetail').dialog({
        title: title,
        width: 1000,
        height: 500,
        closed: false,
        cache: false,
        href: path + 'saleinfo/viewMessage.do?sid=' + sid,
        modal: true
    });
}

function d_close() {
    $('#viewDetail').dialog('close');
}

/**
 * 格式化金额还原
 * @param s
 * 格式化的金额
 * @return 还原以后的金额
 */
function rmoney(s) {
    return parseFloat(s.replace(/[^\d\.-]/g, ""));
}

function formatMoney(s, type) {
    if (/[^0-9\.]/.test(s))
        return "0";
    if (s == null || s == "")
        return "0";
    s = s.toString().replace(/^(\d*)$/, "$1.");
    s = (s + "00").replace(/(\d*\.\d\d)\d*/, "$1");
    s = s.replace(".", ",");
    var re = /(\d)(\d{3},)/;
    while (re.test(s))
        s = s.replace(re, "$1,$2");
    s = s.replace(/,(\d\d)$/, ".$1");
    if (type == 0) {// 不带小数位(默认是有小数位)  
        var a = s.split(".");
        if (a[1] == "00") {
            s = a[0];
        }
    }
    return s;
}

function close_div(div) {
    $('#' + div).dialog('close');
}
/**
 * 字符串转义html特殊字符
 * @param value
 * @return
 */
function checkReplaceSymbol(value) {
    var tt = value;
    if (tt) {
        tt = tt.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&prime;/g, '′').replace(/&frasl;/g, '/').replace(/&yen;/g, '¥').replace(/&reg;/g, '®').replace(/&plusmn;/g, '±').replace(/&lowast;/g, '*').replace(/&copy;/g, '©').replace(/&amp;/g, '&');
    }
    return tt;
}

/**
 * 乘法精确运算  value*100 这样会有问题需调用这个方法
 * @param arg1
 * @param arg2
 * @return
 */
function accMul(arg1, arg2) {
    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
    try {
        m += s1.split(".")[1].length
    } catch (e) {
    }
    try {
        m += s2.split(".")[1].length
    } catch (e) {
    }
    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
}

function resizeLayout(tableId){
	 $(".expandCon").bind("click", function () {
	        $(".searchCon").show();
	        $(".collapseCon").show();
	        $(".expandCon").hide();
	        if(tableId){
	        	$("#"+tableId).datagrid("resize");
	        }
	    });
	    $(".collapseCon").bind("click", function () {
	        $(".searchCon").hide();
	        $(".expandCon").show();
	        $(".collapseCon").hide();
	        if(tableId){
	        	$("#"+tableId).datagrid("resize");
	        }
	    });
	    if ($('.gridcontainer').width()) {
	        var contentwidth = parent.$('.layout-panel-center').width(), // 第一次加载时center面板的宽度
	            width = $('.gridcontainer').width(), //给grid加一个container层，并记录
	            mwidth = contentwidth - width; //确定偏量

	        $(window).resize(function () {
	            //收缩引起window resize,重新计算值，并调用resize方法。
	        	if(tableId){
	        		$("#"+tableId).datagrid('resize', {width: parent.$('.layout-panel-center').width() - mwidth});
	        	}
	        });
	    }
}

function DictValueLoadOption(id, lable, name, path,selectVl){
    $.ajax({
        type: "get",
        url: path + "/sysDictValue/getDictValueByDictTypeCode?dictTypeCode="+lable,
        dataType: 'json',
        success: function (jsonData) {
            var select = $("#"+id);
            select.empty();
            var html = "";
            var firstChannelValue = '';
           // html = html + "<label><input type='checkbox' value='1' onclick='"+ checkAll +"()' />全选</label>";
            $(jsonData).each(function(i,data){
            	if(i != 0) {
            		html = html + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            	}
            	let checked;
            	if(selectVl && selectVl.indexOf(data.value)!=-1){
                    checked = 'checked';
                }
            	html = html + "<label><input name='" + name +"' type='checkbox' value='"+data.value+"' "+checked+"/>"+data.labelDefault+" </label>";
            });
            select.html(html);
        }
    });

}

function DictValueLoadRadio(id, lable, name, path){
    $.ajax({
        type: "get",
        url: path + "/sysDictValue/getDictValueByDictTypeCode?dictTypeCode="+lable,
        dataType: 'json',
        success: function (jsonData) {
            var select = $("#"+id);
            select.empty();
            var html = "";
            var firstChannelValue = '';
           // html = html + "<label><input type='checkbox' value='1' onclick='"+ checkAll +"()' />全选</label>";
            $(jsonData).each(function(i,data){
            	if(i != 0) {
            		html = html + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            	}
            	if(i == 0) {
            		html = html + "<label><input name='" + name +"' type='radio' checked value='' />全选</label>";
            		html = html + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
            	}
        		html = html + "<label><input name='" + name +"' type='radio' value='"+data.value+"' />"+data.labelDefault+" </label>";
            	
            });
            select.html(html);
        }
    });

}

function DictValueLoadSelect(id, lable, path,selectVl){
    $.ajax({
        type: "get",
        url: path + "//web/dict/findDict?dictType="+lable,
        dataType: 'json',
        success: function (jsonData) {
            var select = $("#"+id);
            select.empty();
            select.append('<option value="">请选择</option>');
            if (jsonData.success) {
            	 $(jsonData.data).each(function(i,data){
                     select.append("<option value='"+data.code+"'>"+data.name+"</option>");
                 });
			}
           
            $("#"+id+" option[value='"+selectVl+"']").prop("selected", true);
        }
    });

}


function dictValueLoadOptionaAll(id, lable, name, path, selectVl) {
    $.ajax({
        type: "get",
        url: path + "/web/dict/getDictValueByDictTypeCode?code=" + lable,
        dataType: 'json',
        success: function (jsonData) {
            var select = $("#" + id);
            select.empty();
            var html = "";
            let checked;
            if (selectVl == 'ALL') {
                checked = 'checked';
            }
            $(jsonData).each(function (i, data) {
                if (i != 0) {
                    html = html + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                }
                if (!checked && selectVl && selectVl.indexOf(data.code) != -1) {
                    checked = 'checked';
                }
                html = html + "<label><input name='" + name + "' type='checkbox' value='" + data.code + "' " + checked + "/>" + data.name + " </label>";
                if (selectVl != 'ALL') {
                    checked = undefined;
                }
            });
            select.html(html);
        }
    });
}

function isAllChecked(checkName) {
    var checkboxes = $("input[name='"+checkName+"']");
    if(checkboxes.filter(':checked').length == checkboxes.length) {
        return checkboxes;
    }
    return null;
}

function fromCodeLoadSelect(id, path,selectVl,isdisabled){
    $.ajax({
        type: "get",
        url: path + "/appCommon/queryFormType",
        dataType: 'json',
        success: function (jsonData) {
            var select = $("#"+id);
            select.empty();
            select.append('<option value="">请选择</option>');
            $(jsonData).each(function(i,data){
                select.append("<option value='"+data.formCode+"'>"+data.title+"</option>");
            });
            $("#"+id+" option[value='"+selectVl+"']").prop("selected", true);
            select.prop("disabled",isdisabled);
        }
    });
}

function dictValueLoadSelectSort(id, lable, path,selectVl,qxz){
    console.log(id+','+lable+','+path+','+selectVl);
    $.ajax({
        type: "get",
        url: path + "/web/dict/getDictValueByDictTypeCode?code="+lable,
        dataType: 'json',
        success: function (jsonData) {
            var select = $("#"+id);
            select.empty();
            if(qxz){
            	select.append("<option value=''>"+qxz+"</option>");
            }
            $(jsonData).each(function(i,data){
                select.append("<option value='"+data.code+"'>"+data.name+"</option>");
            });
            $("#"+id+" option[value='"+selectVl+"']").prop("selected", true);
        }
    });
    

}

/**
 * 合法地址格式校验
 */
function isURL(str) {

    var reg=/\w*\.\w+$/;
    var isurl=reg.test(str);
    return isurl;
}

/**
 * 查询已配置规则的编码值
 */
function ruleValueLoadSelectSort(id, typeCode, path,selectDefaultVal,init){
    console.log(id+','+typeCode+','+path+','+selectDefaultVal);
    $.ajax({
        type: "get",
        url: path + "/contentConfigRule/getRuleValueByTypeCode?typeCode="+typeCode,
        dataType: 'json',
        success: function (jsonData) {
            var select = $("#"+id);
            select.empty();
            if(init){
                select.append("<option value=''>"+init+"</option>");
            }
            $(jsonData).each(function(i,data){
                select.append("<option value='"+data.code+"'>"+data.name+"</option>");
            });
            $("#"+id+" option[value='"+selectDefaultVal+"']").prop("selected", true);
        }
    });
}

/**
 * 根据目标人群id查询
 */
function initTargetCrowd (targetCrowdId, resultMsg) {
    var targetCrowdIds = $("#targetCrowdId option");
    var flag = false;
    for(var i=0; i<targetCrowdIds.length; i++){
        if(targetCrowdIds[i].value == targetCrowdId){
            targetCrowdIds[i].selected = true;
            flag = true;
        }
    }
    if(!flag && (targetCrowdId !=0 || targetCrowdId !="")){
        $('#'+resultMsg).html("该目标人群id不存在！").show();
        return;
    }else{
        $('#'+resultMsg).html("").hide();
    }
    getCrowdDetail($("#baseUrlId").val(),targetCrowdId,resultMsg);
}

/**
 * 获取目标人群详细信息
 */
function getCrowdDetail(base,targetCrowdId,resultMsg) {
    var crowId = targetCrowdId;
    if(crowId == null || crowId == ""){
        return;
    }
    var data = {
        "crowId":crowId
    };
    $.ajax({
        url: base + '/backendContent/getCrowdDetail',
        data: JSON.stringify(data),
        method: 'POST',
        dataType: "json",
        contentType: 'application/json;charset=UTF-8',
        success: function (data) {
            if(200 == data.code){
                $('#'+resultMsg).html("").hide();
                if(crowId > 0){
                    $("#inputTargetCrowdId").val(targetCrowdId);
                    var crowdHTML = "";
                    for (var i=0; i<data.data.ruleList.length; i++){
                        var ruleRelation = data.data.ruleList[i].ruleRelation;
                        var rule = data.data.ruleList[i].rule;
                        var ruleRelationName = "";
                        if(ruleRelation ==1){
                            ruleRelationName = "且";
                        }else if(ruleRelation ==2){
                            ruleRelationName = "或";
                        }
                        crowdHTML = crowdHTML + "<div class=\"form-group\">\n" +
                            "                    <label for=\"member_title\" class=\"col-sm-3 control-label\"><strong class=\"text-danger\"></strong></label>\n" +
                            "                    <div class=\"col-sm-9\">\n" +
                            "                        <input type=\"text\" class=\"form-control\" disabled value=\""+rule+"  "+ruleRelationName+"\"/>\n" +
                            "                    </div>\n" +
                            "                </div>";
                    }
                    $("#crowList").html(crowdHTML).show();
                }else{
                    $("#crowList").hide();
                    $("#inputTargetCrowdId").val("");
                }
            }
        }
    });
}