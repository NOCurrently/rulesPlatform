<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">维护数据</h4>
        </div>


        <div id="banner_result" class="alert alert-danger" <#if !msg??>style="display:none"</#if>>
            <#if msg??>
                ${msg!''}
            </#if>
        </div>


        <form id="banner_EditForm" class="form-horizontal" method="post" action="${base}/backendContent/savaBanner">
            <input type="hidden" name="menuId" value="${menuId!}">
            <input type="hidden" name="infoId" <#if info??>value="${info.id!}"</#if> >
            <input type="hidden" id="baseUrlId" value="${base}">
            <div class="modal-body">
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>名称</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="title" id="title" placeholder="名称"  <#if info??>value="${info.title!}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">副标题</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="subTitle" id="subTitle" placeholder="副标题"  <#if info??>value="${info.subTitle!}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="targetBannerUser" class="col-sm-3 control-label">目标用户</label>
                    <div class="col-sm-9">
                        <div id="targetBannerUser">
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <label for="targetBannerVersion" class="col-sm-3 control-label">目标版本</label>
                    <div class="col-sm-9">
                        <div id="targetBannerVersion">
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <label for="targetBannerChannel" class="col-sm-3 control-label">终端设备</label>
                    <div class="col-sm-9">
                        <div id="targetBannerChannel">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="targetBannerChannel" class="col-sm-3 control-label">目标人群</label>
                    <div class="col-sm-9">
                        <div id="targetCrowdId">
                            <input type="hidden" id="targetCrowdHidden" <#if info??>value='${info.targetCrowdId!}'</#if>>
                            <select  style="width: 200px;float: left;" class="search-input am-form-field" id="targetCrowdId" name="targetCrowdId" onchange="getCrowdDetail('${base}',this.value,'banner_result')">
                                <option value="0">请选择</option>
                                <#if crowdList??>
                                    <#list crowdList as item>
                                    <option value="${item.id}">${item.id}:${item.crowdName}</option>
                                    </#list>
                                </#if>
                            </select>
                            <input type="text" style="width: 200px;float: right;" class="form-control" id="inputTargetCrowdId" onblur="initTargetCrowd(this.value, 'banner_result');" placeholder="请输入目标人群id">
                        </div>
                    </div>
                </div>
                <div id="crowList">

                </div>


                <div class="form-group">
                    <label for="priority" class="col-sm-3 control-label">排序</label>
                    <div class="col-sm-9">
                        <input type="number" class="form-control" name="priority" id="priority" placeholder="排序,输入0以上" min="1" maxlength="3" <#if info??>value="${info.priority!}"<#else>value="1"</#if>>
                    </div>
                </div>


                <div class="form-group">
                    <label for="uploadParam" class="col-sm-3 control-label"><strong
                                class="text-danger">*</strong>上传图片</label>
                    <div class="col-sm-9">
                        <div id="displayUploadImgs">
                            <#if info??>
                                <#if info.imgDTOS??>
                                    <#list info.imgDTOS as eachImg>
                                        <img src="${eachImg.img!}" name="displayUploadImg" style="width:40px;height: 40px" alt="${eachImg.alt!}" imgid="${eachImg.id!}"/>
                                    </#list>
                                </#if>
                            </#if>
                        </div>
                        <input type="button"  id="upload-param" value="添加"></input>
                    </div>
                </div>

                <div class="form-group">
                    <label for="typeValue" class="col-sm-3 control-label"><strong class="text-danger">*</strong>背景色</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="backColor" id="backColor" placeholder="背景色(格式：十六进制，6位)"
                               <#if info??><#if info.appExtend??>value='${info.appExtend.backColor!}'</#if></#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="type" class="col-sm-3 control-label"><strong class="text-danger">*</strong>跳转类型</label>
                    <div class="col-sm-9">
                        <select id="jumpType" class="form-control" name="type" id="type">
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="typeValue" class="col-sm-3 control-label"><strong
                                class="text-danger">*</strong>跳转页面(地址)</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="jumpUrl" id="jumpUrl" placeholder="跳转页面(地址)"
                               <#if info??>value='${info.jumpUrl!}'</#if>>
                        <span style="color:red;display:block;">注意:请务必输入准确无误的跳转地址</span>
                    </div>
                </div>


                <!-- 时间版本兼容字段-->
                <div class="form-group">
                    <label for="dateParam" class="col-sm-3 control-label">时间设置</label>
                    <div class="col-sm-9">
                        <input type="button"  id="date-param" value="添加"></input>
                        <div style="display:none" id="timeParamJson"><#if timeParamJson??>${timeParamJson!''}</#if></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="param" class="col-sm-3 control-label">自定义参数</label>
                    <div class="col-sm-9">
                        <input type="button"  id="insert-param" value="添加"></input>
                        <div style="display:none" id="customParamJson"><#if info??>${info.customParam!''}</#if></div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="remarks" class="col-sm-3 control-label">备注说明</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="remarks" id="remarks" placeholder="请输入你的描述"
                               <#if info??>value="${info.remarks!}"</#if>>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </form>


    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {
        // 自定义参数
        $("#insert-param").click(function () {
            $('#param_data').load(path + "/backendContent/paramEdit");
            $('#param_data').modal({});
        });

        // 图片上传
        $("#upload-param").click(function () {
            $('#upload_data').load(path + "/backendContent/uploadEdit");
            $('#upload_data').modal({});
        });

        // 时间设置
        $("#date-param").click(function () {
            $('#date_data').load(path + "/backendContent/dateEdit");
            $('#date_data').modal({});
        });

        // 页面上内容初始化
        var path = $("#path").val();

    var bannerUserDefVal = <#if info??>"${info.targetUser!}"<#else>""</#if>;
        dictValueLoadOptionaAll("targetBannerUser", "target_customer", "targetBannerUser", path, bannerUserDefVal);

    var bannerVersionDefVal = <#if info??>"${versionParamArray!}"<#else>""</#if>;
        dictValueLoadOptionaAll("targetBannerVersion", "target_version", "targetBannerVersion", path, bannerVersionDefVal);

    var bannerChannelDefVal = <#if info??>"${info.channel!}"<#else>""</#if>;
        dictValueLoadOptionaAll("targetBannerChannel", "target_channel", "targetBannerChannel", path, bannerChannelDefVal);

    var bannerJumpTypeDefVal = <#if info??>"${info.jumpType!}"<#else>""</#if>;
        dictValueLoadSelectSort("jumpType", "jump_type", path, bannerJumpTypeDefVal);

        var targetCrowdId = $("#targetCrowdHidden").val();
        initTargetCrowd(targetCrowdId, "banner_result");


        //提交数据
        $("#saveBtn").on("click", function () {



            // 1.校验
            var isValiResult = validateBanner();
            if (!isValiResult) {
                return;
            }

            // 提交前跳转地址再次确认
            var jumpUrl = $("#jumpUrl").val();
            var msg = "请确认跳转地址是否正确：\n" + jumpUrl;
            if (!confirm(msg)) {
                return;
            }

            // 2.提示确认按钮置灰，防止重复提交
            var thatButton = $(this);
            thatButton.attr('disabled', 'disabled');

            // 3.表单提交
            var infoId = $("#banner_EditForm").find("input[name=infoId]").val();
            var menuId = $("#banner_EditForm").find("input[name=menuId]").val();
            var title = $("#title").val();
            var subTitle = $("#subTitle").val();
            var targetBannerUser = getCheckboxValOrAllVal("targetBannerUser");
            var targetBannerVersion = getCheckboxValOrAllVal("targetBannerVersion");
            var targetBannerChannel = getCheckboxValOrAllVal("targetBannerChannel");
            var priority = $("#priority").val();
            var backColor = $("#backColor").val();
            var jumpType = $("#jumpType").find('option:selected').val();
            //var jumpUrl = $("#jumpUrl").val();
            var dateParam = $("#timeParamJson").text();
            var customParam = $("#customParamJson").text();
            var remarks = $("#remarks").val();
            var uploadParam = getImgList();
            var targetCrowdId = $("#targetCrowdId").find("option:selected").val();

            var data = {
                "id": infoId,
                "menuId": menuId,
                "title": title,
                "subTitle": subTitle,
                "targetBannerUser": targetBannerUser,
                "targetBannerVersion": targetBannerVersion,
                "targetBannerChannel": targetBannerChannel,
                "priority": priority,
                "backColor": backColor,
                "jumpType": jumpType,
                "jumpUrl": jumpUrl,
                "dateParam": dateParam,
                "customParam": customParam,
                "bannerImgList": uploadParam,
                "remarks": remarks,
                "targetCrowdId":targetCrowdId
            };
            $.ajax({
                url: path + '/backendContent/editContent',
                data: JSON.stringify(data),
                method: 'POST',
                dataType: "json",
                contentType: 'application/json;charset=UTF-8',
                success: function (data) {
                    if (200 == data.code) {
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

                    } else {
                        // 显示之前的错误信息
                        $('#banner_result').html(data.displayMessage);
                        $('#banner_result').show();
                    }
                    // 允许页面数据重新编辑
                    thatButton.removeAttr('disabled');
                }
            });

        });

        /**
         * 获取img的list
         */
        function getImgList() {
            var imgList = new Array();
            $("#displayUploadImgs").find("img").each(function (index, element) {
                var eachImg = $(element);
                var eachComId = eachImg.attr("imgid");
                var eachComImg = eachImg.attr("src");
                var eachComAlt = eachImg.attr("alt");

                if ("undefined" == eachComId) {
                    imgList[index] = {"img": eachComImg, "alt": eachComAlt, "sort": (index + 1)};
                } else {
                    imgList[index] = {"id": eachComId, "img": eachComImg, "alt": eachComAlt, "sort": (index + 1)};
                }

            });
            return imgList;
        }


        /**
         * 校验表单
         */
        function validateBanner() {
            // 1.校验标题
            var title = $("#title").val();
            if (isEmpty(title)) {
                $('#banner_result').html("名称不能为空！");
                $('#banner_result').show();
                return false;
            }
            if (title.length > 100) {
                $('#banner_result').html("名称长度不能超过100！").show();
                return false;
            }
            var subTitle = $("#subTitle").val();
            if (subTitle.length > 150) {
                $('#banner_result').html("副标题长度不能超过150！").show();
                return false;
            }

            // 2.排序不为空时必须为正整数
            var priority = $("#priority").val();
            if (!isEmpty(priority)) {
                if (!(/^\+?[1-9][0-9]*$/).test(priority)) {
                    $('#banner_result').html("排序必须为正整数！");
                    $('#banner_result').show();
                    return false;
                }
            } else {
                $("#priority").val(1);
            }


            // 3.图片为必传字段
            var imgsLength = $("#displayUploadImgs").find("img").length;
            if (imgsLength < 1) {
                $('#banner_result').html("图片不能为空！");
                $('#banner_result').show();
                return false;
            }

            // 4.背景色
            var msg = checkBackColorss();
            if (!isEmpty(msg)) {
                $('#banner_result').html(msg);
                $('#banner_result').show();
                return false;
            }

            // 5.跳转类型
            var jumpType = $("#jumpType").find('option:selected').val();
            if (isEmpty(jumpType)) {
                $('#banner_result').html("跳转类型不能为空！");
                $('#banner_result').show();
                return false;
            }
            if (jumpType.length > 50) {
                $('#banner_result').html("跳转类型长度不能超过50！").show();
                return false;
            }

            // 7.时间设置
            var dateParam = $("#dateParam").text();
            if (!isEmpty(dateParam)) {
                var dateParamObj = JSON.parse(dateParam);
                if (isEmpty(dateParamObj.beginTime)) {
                    $('#banner_result').html("时间设置开始日期不能为空！");
                    $('#banner_result').show();
                    return false;
                }
            }

            // 8.校验备注
            var remarks = $("#remarks").val();
            if (remarks.length > 200) {
                $('#banner_result').html("备注长度不能超过200！").show();
                return false;
            }

            return true;

        }


        /**
         * 校验背景色
         */
        function checkBackColorss() {
            var reg = /^[0-9a-fA-F]{1,6}$/;
            var backColor = $("#backColor").val();
            var msg = '';
            if (isEmpty(backColor)) {
                msg = "背景色不能为空！";
            } else if (!reg.test(backColor)) {
                msg = "背景色格式不对！";
            }
            return msg;
        }

        /**
         * 获取checkbox中选中的值或者全部值
         */
        function getCheckboxValOrAllVal(inputName) {
            var obj = $("#" + inputName).find("input[type=checkbox][name=" + inputName + "]");
            var check_val = [];
            for (var k = 0; k < obj.length; k++) {  // 为空的话,即为选中全部
                if (obj[k].checked)
                    check_val.push(obj[k].value);
            }

            // 为空的话,即为选中全部
            if (0 == check_val.length) {
                for (var ki = 0; ki < obj.length; ki++) {
                    check_val.push(obj[ki].value);
                }
            }
            return check_val;
        }
    });

/*    function initTargetCrowd (targetCrowdId) {
        var targetCrowdIds = $("#targetCrowdId option");
        var flag = false;
        for(var i=0; i<targetCrowdIds.length; i++){
            if(targetCrowdIds[i].value == targetCrowdId){
                targetCrowdIds[i].selected = true;
                flag = true;
            }
        }
        if(!flag && (targetCrowdId !=0 || targetCrowdId !="")){
            $('#banner_result').html("请输入正确的目标人群id").show();
            return;
        }else{
            $('#banner_result').html("").hide();
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

</script>