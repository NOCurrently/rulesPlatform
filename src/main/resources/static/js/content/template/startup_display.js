/**
 * Created by Administrator on 2018/7/29.
 */
$(function () {
    // 自定义参数
    $("#insert-param").click(function () {
        $('#param_data').load(path + "/backendContent/paramEdit?paramParam=");
        $('#param_data').modal({});
    });

    // 图片上传
    $("#upload-param").click(function () {
        $('#upload_data').load(path + "/backendContent/uploadEdit?&uploadParam=");
        $('#upload_data').modal({});
    });

    // 时间设置
    $("#date-param").click(function () {
        $('#date_data').load(path + "/backendContent/dateEdit?dateParam=");
        $('#date_data').modal({});
    });

    // 页面上内容初始化
    var path = $("#path").val();

    var targetBannerVersionDefVal = $("#targetBannerVersionDefVal").val();
    dictValueLoadOptionaAll("targetBannerVersion", "target_version","targetBannerVersion" ,path,targetBannerVersionDefVal);

    var targetBannerChannelDefVal = $("#targetBannerChannelDefVal").val();
    dictValueLoadOptionaAll("targetBannerChannel", "target_channel", "targetBannerChannel",path,targetBannerChannelDefVal);

    var jumpTypeDefVal = $("#jumpTypeDefVal").val();
    dictValueLoadSelectSort("startup_jumpType", "jump_type", path,jumpTypeDefVal);

    var displayTypeDefVal = $("#displayTypeDefVal").val();
    dictValueLoadSelectSort("displayType", "displayType", path,displayTypeDefVal);

    var targetCrowdId = $("#targetCrowdHidden").val();
    initTargetCrowd(targetCrowdId, "startup_result");



    //提交数据
    $("#startup_saveBtn").bind("click", function () {


        // 1.校验
        var isValiResult = validateStartup();
        if(!isValiResult)
            return;

        // 提交前跳转地址再次确认
        var jumpUrl = $("#startup_jumpUrl").val();
        var msg = "请确认跳转地址是否正确：\n"+jumpUrl;
        if(!confirm(msg)){
            return;
        }

        // 2.按钮置灰
        var thatButton = $(this);
        thatButton.attr('disabled', 'disabled');

        // 3.表单提交
        var infoId = $("#startup_EditForm").find("input[name=infoId]").val();
        var menuId = $("#startup_EditForm").find("input[name=menuId]").val();
        var title = $("#startup_title").val();
        var subTitle = $("#startup_subTitle").val();
        var targetBannerVersion = getCheckboxValOrAllVal("targetBannerVersion");
        var targetBannerChannel = getCheckboxValOrAllVal("targetBannerChannel");
        var jumpType = $("#startup_jumpType").find('option:selected').val();
        //var jumpUrl = $("#startup_jumpUrl").val();
        var timeOut = $("#timeOut").val();
        var displayType = $("#displayType").find('option:selected').val();
        var displayTimes = $("#displayTimes").val();
        var dateParam = $("#timeParamJson").text();
        var customParam = $("#customParamJson").text();
        var remarks = $("#startup_remarks").val();
        var uploadParam = getImgList();
        var priority = $("#priority").val();
        var targetCrowdId = $("#targetCrowdId").find("option:selected").val();

        var data = {
            "id":infoId,
            "menuId":menuId,
            "title":title,
            "subTitle":subTitle,
            "targetBannerVersion":targetBannerVersion,
            "targetBannerChannel":targetBannerChannel,
            "jumpType": jumpType,
            "jumpUrl":jumpUrl,
            "timeOut": timeOut,
            "displayType": displayType,
            "displayTimes": displayTimes,
            "dateParam":dateParam,
            "customParam": customParam,
            "bannerImgList":uploadParam,
            "remarks":remarks,
            "priority":priority,
            "targetCrowdId":targetCrowdId
        };
        $.ajax({
            url: path+'/backendContent/editContent',
            data: JSON.stringify(data),
            method: 'POST',
            dataType: "json",
            contentType: 'application/json;charset=UTF-8',
            success: function (data) {
                if(200 == data.code){
                    //关闭当前窗口
                    $("#editContentInitDiv").modal('hide');
                    // 需要刷新下页面
                    var curPage = $("#pageInput").val();
                    if (!curPage) {
                        curPage = 1;
                    }
                    //pageSize标签存在于page.js中
                    var pageSize = $("#selectPageForm").val();
                    if (!pageSize) {
                        pageSize = 15;
                    }
                    listPaging = new PageView({
                        pageContainer: $("#listPaging"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'listPaging',
                        url: path + "/backendContent/infoListData",
                        curPageName: 'currentPage',
                        curPage: curPage,
                        pageSize: pageSize,
                        urlRequestData: {
                            "menuId": menuId,
                        }
                    });

                }else{
                    // 允许页面数据重新编辑
                    thatButton.removeAttr('disabled');

                    // 显示之前的错误信息
                    $('#startup_result').html(data.errorMessage);
                    $('#startup_result').show();
                }
            }
        });
    });

    /**
     * 获取img的list
     */
    function getImgList(){
        var imgList = new Array();
        $("#displayUploadImgs").find("img").each(function(index, element){
            var eachImg = $(element);
            var eachComId = eachImg.attr("imgid");
            var eachComImg = eachImg.attr("src");
            var eachComAlt = eachImg.attr("alt");

            if("undefined" == eachComId){
                imgList[index] = {"img":eachComImg, "alt":eachComAlt,"sort":(index+1)};
            }else{
                imgList[index] = {"id":eachComId,"img":eachComImg, "alt":eachComAlt,"sort":(index+1)};
            }

        });
        return imgList;
    }


    /**
     * 校验表单
     */
    function validateStartup() {
        // 1.校验名称和副标题
        var title = $("#startup_title").val();
        if(isEmpty(title)){
            $('#startup_result').html("名称不能为空！");
            $('#startup_result').show();
            return false;
        }
        if(title.length > 100){
            $('#startup_result').html("名称长度不能超过100！").show();
            return false;
        }
        var subTitle = $("#startup_subTitle").val();
        if(subTitle.length > 150){
            $('#startup_result').html("副标题长度不能超过150！").show();
            return false;
        }


        // 2.图片为必传字段
        var imgsLength =$("#displayUploadImgs").find("img").length;
        if(imgsLength <1){
            $('#startup_result').html("图片不能为空！");
            $('#startup_result').show();
            return false;
        }


        // 3.跳转类型
        var jumpType = $("#startup_jumpType").find('option:selected').val();
        if(isEmpty(jumpType)){
            $('#startup_result').html("跳转类型不能为空！");
            $('#startup_result').show();
            return false;
        }
        if(jumpType.length > 50){
            $('#startup_result').html("跳转类型长度不能超过50！").show();
            return false;
        }

        // 5.显示时长
        var timeOut = $("#timeOut").val();
        if(isEmpty(timeOut)){
            $('#startup_result').html("显示时长不能为空！");
            $('#startup_result').show();
            return false;
        }
        if (!(/^\+?[1-9][0-9]*$/).test(timeOut)) {
            $('#startup_result').html("显示时长必须为正整数！");
            $('#startup_result').show();
            return false;
        }
        if(timeOut > 999){
            $('#startup_result').html("显示时长不能大于999！");
            $('#startup_result').show();
            return false;
        }

        // 6.显示频率
        var displayType = $("#displayType").find('option:selected').val();
        if(!isEmpty(displayType)) {
            if (displayType.length > 50) {
                $('#startup_result').html("显示频率长度不能超过50！").show();
                return false;
            }
        }

        // 7.显示次数
        var displayTimes = $("#displayTimes").val();
        if(!isEmpty(displayTimes)) {
            if (!(/^\d+$/).test(displayTimes)) {
                $('#startup_result').html("显示次数必须为非负整数！");
                $('#startup_result').show();
                return false;
            }
        }else{
            $("#displayTimes").val(0);
        }
        if(displayTimes > 999){
            $('#startup_result').html("显示次数不能大于999！");
            $('#startup_result').show();
            return false;
        }

        // 8.时间设置
        var dateParam = $("#dateParam").text();
        if(!isEmpty(dateParam)) {
            var dateParamObj = JSON.parse(dateParam);
            if(isEmpty(dateParamObj.beginTime)) {
                $('#startup_result').html("时间设置开始日期不能为空！");
                $('#startup_result').show();
                return false;
            }
        }

        // 9.校验备注
        var remarks = $("#startup_remarks").val();
        if(remarks.length > 200){
            $('#startup_result').html("备注长度不能超过200！").show();
            return false;
        }

        // 10.排序不为空时必须为正整数
        var priority = $("#priority").val();
        if(!isEmpty(priority)) {
            if (!(/^\+?[1-9][0-9]*$/).test(priority)) {
                $('#startup_result').html("排序必须为正整数！");
                $('#startup_result').show();
                return false;
            }
        }else{
            $("#priority").val(1);
        }

        return true;

    }

    /**
     * 获取checkbox中选中的值或者全部值
     */
    function getCheckboxValOrAllVal(inputName){
        var obj = $("#"+inputName).find("input[type=checkbox][name="+inputName+"]");
        var check_val = [];
        for(var k =0;k < obj.length; k++ ){  // 为空的话,即为选中全部
            if(obj[k].checked)
                check_val.push(obj[k].value);
        }

        // 为空的话,即为选中全部
        if(0 == check_val.length){
            for(var ki =0;ki < obj.length; ki++ ){
                check_val.push(obj[ki].value);
            }
        }
        return check_val;
    }



});

/*
function initTargetCrowd (targetCrowdId) {
    var targetCrowdIds = $("#targetCrowdId option");
    var flag = false;
    for(var i=0; i<targetCrowdIds.length; i++){
        if(targetCrowdIds[i].value == targetCrowdId){
            targetCrowdIds[i].selected = true;
            flag = true;
        }
    }
    if(!flag && (targetCrowdId !=0 || targetCrowdId !="")){
        $('#startup_result').html("请输入正确的目标人群id").show();
        return;
    }else{
        $('#startup_result').html("").hide();
    }
    getCrowdDetail($("#baseUrlId").val(),targetCrowdId);
}

function getCrowdDetail(base,targetCrowdId) {
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
                if(crowId > 0){
                    $("#crowdId").val("id=" + targetCrowdId);
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
                    $("#crowList").html(crowdHTML);
                }else{
                    $("#crowdId").val("");
                    $("#crowList").html(crowdHTML);
                }
            }
        }
    });
}*/
