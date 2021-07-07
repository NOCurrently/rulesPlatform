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

    var dataCode = $("#dataCode").val();
    var dataCodeDefVal = $("#dataCodeDefVal").val();
    dictValueLoadSelectSort("menu_dataCoding", dataCode, path,dataCodeDefVal,"请选择");

    var jumpTypeDefVal = $("#jumpTypeDefVal").val();
    dictValueLoadSelectSort("menu_jumpType", "jump_type", path,jumpTypeDefVal);

    var targetCrowdId = $("#targetCrowdHidden").val();
    initTargetCrowd(targetCrowdId, "menu_result");



    //提交数据
    $("#menu_saveBtn").bind("click", function () {


        // 1.校验
        var isValiResult = validateMenu();
        if(!isValiResult)
            return;

        // 提交前跳转地址再次确认
        var jumpUrl = $("#menu_jumpUrl").val();
        var msg = "请确认跳转地址是否正确：\n"+jumpUrl;
        if(!confirm(msg)){
            return;
        }

        // 2.按钮置灰
        var thatButton = $(this);
        thatButton.attr('disabled', 'disabled');

        // 3.表单提交
        var infoId = $("#menu_EditForm").find("input[name=infoId]").val();
        var menuId = $("#menu_EditForm").find("input[name=menuId]").val();
        var title = $("#menu_title").val();
        var subTitle = $("#menu_subTitle").val();
        var targetBannerVersion = getCheckboxValOrAllVal("targetBannerVersion");
        var targetBannerChannel = getCheckboxValOrAllVal("targetBannerChannel");
        var priority = $("#menu_priority").val();
        var code = $("#menu_dataCoding").find('option:selected').val();
        var jumpType = $("#menu_jumpType").find('option:selected').val();
        //var jumpUrl = $("#menu_jumpUrl").val();
        var dateParam = $("#timeParamJson").text();
        var customParam = $("#customParamJson").text();
        var remarks = $("#menu_remarks").val();
        var uploadParam = getImgList();
        var targetCrowdId = $("#targetCrowdId").find("option:selected").val();

        var data = {
            "id":infoId,
            "menuId":menuId,
            "title":title,
            "subTitle":subTitle,
            "targetBannerVersion":targetBannerVersion,
            "targetBannerChannel":targetBannerChannel,
            "priority":priority,
            "code":code,
            "jumpType": jumpType,
            "jumpUrl":jumpUrl,
            "dateParam":dateParam,
            "customParam": customParam,
            "bannerImgList":uploadParam,
            "remarks":remarks,
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
                    $('#menu_result').html(data.errorMessage);
                    $('#menu_result').show();
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
    function validateMenu() {
        // 1.校验名称和副标题
        var title = $("#menu_title").val();
        if(isEmpty(title)){
            $('#menu_result').html("名称不能为空！");
            $('#menu_result').show();
            return false;
        }
        if(title.length > 100){
            $('#menu_result').html("名称长度不能超过100！").show();
            return false;
        }
        var subTitle = $("#menu_subTitle").val();
        if(subTitle.length > 150){
            $('#menu_result').html("副标题长度不能超过150！").show();
            return false;
        }

        // 2.排序不为空时必须为正整数
        var priority = $("#menu_priority").val();
        if(!isEmpty(priority)) {
            if (!(/^\+?[1-9][0-9]*$/).test(priority)) {
                $('#menu_result').html("排序必须为正整数！");
                $('#menu_result').show();
                return false;
            }
        }else{
            $("#menu_priority").val(1);
        }


        // 3.图片为必传字段
        var imgsLength =$("#displayUploadImgs").find("img").length;
        if(imgsLength <1){
            $('#menu_result').html("图片不能为空！");
            $('#menu_result').show();
            return false;
        }

        // 4.数据编码
        var dataCode = $("#menu_dataCoding").find('option:selected').val();
        if(dataCode.length > 50){
            $('#menu_result').html("数据编码长度不能超过50！").show();
            return false;
        }

        // 5.跳转类型
        var jumpType = $("#menu_jumpType").find('option:selected').val();
        if(isEmpty(jumpType)){
            $('#menu_result').html("跳转不能为空！");
            $('#menu_result').show();
            return false;
        }
        if(jumpType.length > 50){
            $('#menu_result').html("跳转类型长度不能超过50！").show();
            return false;
        }

        // 7.时间设置
        var dateParam = $("#dateParam").text();
        if(!isEmpty(dateParam)) {
            var dateParamObj = JSON.parse(dateParam);
            if(isEmpty(dateParamObj.beginTime)) {
                $('#menu_result').html("时间设置开始日期不能为空！");
                $('#menu_result').show();
                return false;
            }
        }

        // 8.校验备注
        var remarks = $("#menu_remarks").val();
        if(remarks.length > 200){
            $('#menu_result').html("备注长度不能超过200！").show();
            return false;
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
        $('#menu_result').html("请输入正确的目标人群id").show();
        return;
    }else{
        $('#menu_result').html("").hide();
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
