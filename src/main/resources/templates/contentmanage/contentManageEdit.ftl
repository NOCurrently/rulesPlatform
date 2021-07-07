<style>
    .content_span {
        overflow: hidden;
        font-size: 15px;
        word-break: break-all;
        word-wrap: break-word;
    }
</style>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">文案管理</h4>
        </div>

        <div id="content_result" class="alert alert-danger" style="display:none"></div>

        <form id="content_EditForm" class="form-horizontal" method="post" action="${base}/backendContent">
            <input type="hidden" name="menuId" value="${menuId!}">
            <input type="hidden" name="contentId" <#if info??>value="${info.id!}"</#if> >
            <input type="hidden" name="uniqueCode" <#if info??>value="${info.uniqueCode!}"</#if> >
            <div class="modal-body">

                <div class="form-group">
                    <label for="content_type" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>类别</label>
                    <div class="col-sm-9">
                        <select id="content_type" class="form-control" name="content_type">
                        </select>
                        <input type="hidden" id="contentTypeDefVal" <#if info??>value='${info.contentType!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="contentLocation" class="col-sm-3 control-label"><strong class="text-danger">*</strong>位置</label>
                    <div class="col-sm-9">
                        <select id="contentLocation" class="form-control" name="contentLocation"
                                onchange="changeLocation(this.value)">
                        </select>
                        <span id="contentSpan" style="color:red;display:block;"></span>
                        <span id="imgSpan" style="color:red;display:block;"></span>
                        <input type="hidden" id="contentLocationDefVal" <#if info??>value='${info.locationCode!}'</#if>>
                        <input type="hidden" id="minContentDefVal">
                        <input type="hidden" id="maxContentDefVal">
                        <input type="hidden" id="minImgDefVal">
                        <input type="hidden" id="maxImgDefVal">
                    </div>
                </div>

                <div class="form-group">
                    <label for="activityStatus" class="col-sm-3 control-label">状态</label>
                    <div class="col-sm-9">
                        <select id="activityStatus" class="form-control" name="activityStatus">
                        </select>
                        <input type="hidden" id="activityStatusDefVal"
                               <#if info??>value='${info.activityStatus!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="staticContent" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>文案</label>
                    <div class="col-sm-9">
                        <div id="displayContent">
                            <span class="content_span">
                                <#if info??>
                                    <#if info.contentList??>
                                        <#list info.contentList as c>
                                                ${c!}</br>
                                        </#list>
                                    </#if>
                                </#if>
                            </span>
                        </div>
                        <input type="button" id="insert-content" value="编辑文案"></input>
                        <span style="color:red">不支持特殊字符，单条文案长度不能超过225个字符</span>
                        <div style="display:none" id="contentString"><#if content??>${content!}</#if></div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="uploadParam" class="col-sm-3 control-label">图片</label>
                    <div class="col-sm-9">
                        <div id="displayUploadImgs">
                            <#if info??>
                                <#if info.imgList??>
                                    <#list info.imgList as eachImg>
                                    <img src="${eachImg.imgUrl!}" name="displayUploadImg"
                                         style="width:40px;height: 40px" alt="${eachImg.alt!}" imgid="${eachImg.id!}"/>
                                    </#list>
                                </#if>
                            </#if>
                        </div>
                        <input type="button" id="upload-param" value="添加图片"></input>
                        <span style="color:red">最大300KB</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="contentJumpType" class="col-sm-3 control-label">跳转类型</label>
                    <div class="col-sm-9">
                        <select id="contentJumpType" class="form-control" name="type">
                        </select>
                        <input type="hidden" id="jumpTypeDefVal" <#if info??>value='${info.jumpType!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="contentUrl" class="col-sm-3 control-label">跳转页面</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="contentUrl" id="contentUrl" placeholder="不支持特殊字符，长度不能超过500个字符"
                               <#if info??>value='${info.jumpUrl!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="contentUrl" class="col-sm-3 control-label">备用跳转页面</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="alternateJumpUrl" id="alternateJumpUrl" placeholder="不支持特殊字符，长度不能超过500个字符"
                               <#if info??>value='${info.alternateJumpUrl!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="versionCodeDefVal" class="col-sm-3 control-label">目标版本</label>
                    <div class="col-sm-9">
                        <div id="versionCode">
                        </div>
                        <input type="hidden" id="versionCodeDefVal" <#if info??>value='${info.versionCode!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="targetContentChannel" class="col-sm-3 control-label">终端</label>
                    <div class="col-sm-9">
                        <div id="targetContentChannel">
                        </div>
                        <input type="hidden" id="targetContentChannelDefVal" <#if info??>value='${info.channel!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="remarks" class="col-sm-3 control-label">备注</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="remarks" id="remarks" placeholder="最多300个字符，不支持特殊字符"
                           <#if info??>value='${info.remarks!}'</#if>>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="content_saveBtn">保存</button>
            </div>
        </form>


    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {
        // 添加文案
        $("#insert-content").click(function () {
            $('#param_data').load(path + "/contentManage/staticContentEdit");
            $('#param_data').modal({});
        });

        // 图片上传
        $("#upload-param").click(function () {
            // 标记，与其它页面共用上传图片方法，用以指示内容管理图片可删除到0
            var tag = "content"
            $('#upload_data').load(path + "/backendContent/uploadEdit?tag=" + tag);
            $('#upload_data').modal({});
        });

        // 页面上内容初始化
        var path = $("#path").val();

        // 类别
        var contentTypeDefVal = $("#contentTypeDefVal").val();
        dictValueLoadSelectSort("content_type", "content_type", path, contentTypeDefVal, "选择类别");

        // 跳转类型
        var jumpTypeDefVal = $("#jumpTypeDefVal").val();
        dictValueLoadSelectSort("contentJumpType", "jump_type", path,jumpTypeDefVal);

        // 位置
        var contentLocationDefVal = $("#contentLocationDefVal").val();
        //dictValueLoadSelectSort("contentLocation", "content_location", path, contentLocationDefVal, "选择位置");
        ruleValueLoadSelectSort("contentLocation", "content_manage", path, contentLocationDefVal, "选择位置");
        if (contentLocationDefVal != "") {
            changeLocation(contentLocationDefVal);
        }

        // 活动状态
        var activityStatusDefVal = $("#activityStatusDefVal").val();
        dictValueLoadSelectSort("activityStatus", "activity_status", path, activityStatusDefVal, "选择活动状态");

        //目标版本
        var versionCodeDefVal = $("#versionCodeDefVal").val();
        dictValueLoadOptionaAll("versionCode", "target_version", "versionCode", path, versionCodeDefVal);

        // 终端
        var targetContentChannelDefVal = $("#targetContentChannelDefVal").val();
        dictValueLoadOptionaAll("targetContentChannel", "target_channel", "targetContentChannel", path, targetContentChannelDefVal);


        //提交数据
        $("#content_saveBtn").bind("click", function () {

            // 1.校验
            var isValiResult = validateContent();
            if (!isValiResult) {
                return;
            }

            // 提交前跳转地址再次确认
            var jumpUrl = $("#contentUrl").val();
            if(!isEmpty(jumpUrl)) {
                var msg = "请确认跳转地址是否正确：\n" + jumpUrl;
                if (!confirm(msg)) {
                    return;
                }
            }

            // 2.按钮置灰
            var thatButton = $(this);
            thatButton.attr('disabled', 'disabled');

            // 3.表单提交
            var contentId = $("#content_EditForm").find("input[name=contentId]").val();
            var menuId = $("#content_EditForm").find("input[name=menuId]").val();
            var uniqueCode = $("#content_EditForm").find("input[name=uniqueCode]").val();
            var contentType = $("#content_type").find('option:selected').val();
            var locationCode = $("#contentLocation").find('option:selected').val();
            var activityStatus = $("#activityStatus").find('option:selected').val();
            var targetContentChannel = getCheckboxValOrAllVal("targetContentChannel");
            var targetVersion = getCheckboxValOrAllVal("versionCode");
            var channel = targetContentChannel.join(",");
            var versionCode = targetVersion.join(",");

            var content = $("#contentString").text();

            var jumpType = $("#contentJumpType").find('option:selected').val();
            var alternateJumpUrl = $("#alternateJumpUrl").val();

            var uploadParam = getImgList();

            var remarks = $("#remarks").val();

            var type = "content_manage";

            var data = {
                "id": contentId,
                "menuId": menuId,
                "uniqueCode": uniqueCode,
                "contentType": contentType,
                "type": type,
                "locationCode": locationCode,
                "activityStatus": activityStatus,
                "content": content,
                "jumpType": jumpType,
                "jumpUrl": jumpUrl,
                "alternateJumpUrl":alternateJumpUrl,
                "imgList": uploadParam,
                "channel": channel,
                "versionCode":versionCode,
                "remarks": remarks
            };
            $.ajax({
                url: path + '/contentManage/editContentManage',
                data: JSON.stringify(data),
                method: 'POST',
                dataType: "json",
                contentType: 'application/json;charset=UTF-8',
                success: function (data) {
                    if (200 == data.code) {
                        //关闭当前窗口
                        $("#contentManageEditModel").modal('hide');
                        // 需要刷新下页面

                        //pageSize标签存在于page.js中
                        var pageSize = $("#selectPageForm").val();
                        if (!pageSize) {
                            pageSize = 15;
                        }
                        contentListPaging = new PageView({
                            pageContainer: $("#page-table"),
                            pageListContainer: $("#data-table"),
                            pageViewName: 'contentListPaging',
                            url: path + "/contentManage/contentManageListData",
                            curPageName: 'currentPage',
                            pageSize: pageSize,
                            urlRequestData: {
                                "type": type,
                                "menuId": menuId,
                            }
                        });

                    } else {
                        // 允许页面数据重新编辑
                        thatButton.removeAttr('disabled');

                        // 显示之前的错误信息
                        $('#content_result').html(data.errorMessage);
                        $('#content_result').show();
                    }
                }
            });
        });

        // 校验
        function validateContent() {
            var content = $("#contentString").text();
            if (isEmpty(content)) {
                $('#content_result').html("至少输入一条文案！");
                $('#content_result').show();
                return false;
            }
            var minSizeContent = $("#minContentDefVal").val();
            var maxSizeContent = $("#maxContentDefVal").val();
            var minSizeImg = $("#minImgDefVal").val();
            var maxSizeImg = $("#maxImgDefVal").val();
            var contentList = content.split("\n");
            if ((minSizeContent != 0 && contentList.length < minSizeContent) ||
                    (maxSizeContent != 0 && contentList.length > maxSizeContent)) {
                $('#content_result').html("文案数量不符合要求！");
                $('#content_result').show();
                return false;

            }
            var imgList = getImgList();
            if ((minSizeImg != 0 && imgList.length < minSizeImg) ||
                    (maxSizeImg != 0 && imgList.length > maxSizeImg)) {
                $('#content_result').html("图片数量不符合要求！");
                $('#content_result').show();
                return false;

            }
            return true;
        }

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

    /**
     * 选中位置给出配置提示
     */
    function changeLocation(selectedVal) {
        var path = $("#path").val();
        var contentVal = $("#contentSpan");
        var imgVal = $("#imgSpan");
        //var selectedVal = $('#contentLocation  option:selected').val();

        if (selectedVal != "") {
            $.ajax({
                type: "get",
                url: path + "/contentConfigRule/getRuleValueByCode?code=" + selectedVal,
                dataType: 'json',
                success: function (data) {
                    $('#content_result').css('display', 'none');
                    contentVal.empty();
                    imgVal.empty();
                    if (data.code == 200) {
                        var minContent = data.data.minContent;
                        var maxContent = data.data.maxContent;
                        var minImg = data.data.minImg;
                        var maxImg = data.data.maxImg;
                        var content = "";
                        var img = "";
                        // 保存数据，用以新增编辑时校验
                        $("#minContentDefVal").val(minContent);
                        $("#maxContentDefVal").val(maxContent);
                        $("#minImgDefVal").val(minImg);
                        $("#maxImgDefVal").val(maxImg);
                        // 可配置文案数提示
                        if (minContent == 0 && maxContent == 0) {
                            content = "该位置下可配置的文案数量无限制！";
                        } else if (minContent == 0) {
                            content = "该位置下最多可配置 [ " + maxContent + " ] 条文案！"
                        } else if (maxContent == 0) {
                            content = "该位置下至少需要配置 [ " + minContent + " ] 条文案！"
                        } else if (minContent == maxContent) {
                            content = "该位置下仅可配置 [ " + minContent + " ] 条文案！"
                        } else {
                            content = "该位置下可配置的文案数量范围为 [" + minContent + ", " + maxContent + "] ！"
                        }
                        contentVal.text(content);
                        // 可配置图片数提示
                        if (minImg == 0 && maxImg == 0) {
                            img = "该位置下可配置的图片数量无限制！";
                        } else if (minImg == 0) {
                            img = "该位置下最多可配置 [ " + maxImg + " ] 张图片！"
                        } else if (maxImg == 0) {
                            img = "该位置下至少需要配置 [ " + minImg + " ] 张图片！"
                        } else if (minImg == maxImg) {
                            img = "该位置下仅可配置 [ " + minImg + " ] 张图片！"
                        } else {
                            img = "该位置下可配置的图片数量范围为 [" + minImg + ", " + maxImg + "] ！"
                        }
                        imgVal.text(img);
                    } else {
                        $('#content_result').html(data.errorMessage);
                        $('#content_result').show();
                    }
                }
            });
        } else {
            contentVal.empty();
            imgVal.empty();
        }
    }


</script>