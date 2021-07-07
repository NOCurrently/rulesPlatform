<style>
    .content_span {
        overflow: hidden;
        font-size:15px;
        word-break:break-all;
        word-wrap: break-word;
    }
</style>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">变量管理</h4>
        </div>

        <div id="variable_result" class="alert alert-danger" style="display:none"></div>

        <form id="variable_EditForm" class="form-horizontal" method="post" action="${base}/backendContent">
            <input type="hidden" name="menuId" value="${menuId!}">
            <input type="hidden" name="contentId" <#if info??>value="${info.id!}"</#if> >
            <input type="hidden" name="uniqueCode" <#if info??>value="${info.uniqueCode!}"</#if> >
            <div class="modal-body">

                <div class="form-group">
                    <label for="variable_location" class="col-sm-3 control-label"><strong class="text-danger">*</strong>位置</label>
                    <div class="col-sm-9">
                        <select id="variable_location" class="form-control" name="variable_location">
                        </select>
                        <input type="hidden" id="variableLocationDefVal" <#if info??>value='${info.locationCode!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="content_type" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>值类型</label>
                    <div class="col-sm-9">
                        <div class="controls">
                            <label class="radio" style="display:block;float:left">
                                <input  class="radio" type="radio" <#if info??><#if info.contentType == "constant">checked=checked</#if></#if>
                                        name="contentType" value="constant">定值&nbsp;&nbsp;&nbsp;
                            </label>
                            <label class="radio" style="display:block;float:left">
                                <input  class="radio" type="radio" <#if info??><#if info.contentType == "range">checked=checked</#if></#if>
                                        name="contentType" value="range">区间范围值
                            </label>

                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="displayVariable" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>值</label>
                    <div class="col-sm-9">
                        <div id="displayVariable" style="display:inline;">

                        </div>
                        <div style="display:none" id="variableString"><#if content??>${content!}</#if></div>
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

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="variable_saveBtn">保存</button>
            </div>
        </form>


    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {

        // 页面上内容初始化
        var path = $("#path").val();

        // 位置
        var variableLocationDefVal = $("#variableLocationDefVal").val();
        //dictValueLoadSelectSort("variable_location", "variable_location", path, variableLocationDefVal, "选择位置");
        ruleValueLoadSelectSort("variable_location", "variable_manage", path, variableLocationDefVal, "选择位置");

        // 终端
        var targetContentChannelDefVal = $("#targetContentChannelDefVal").val();
        dictValueLoadOptionaAll("targetContentChannel", "target_channel", "targetContentChannel", path, targetContentChannelDefVal);

        // 值类型
        var contentType = $("input[type='radio']:checked").val();
        var variableString = $("#variableString").text();
        var variableList = [];
        var displayContentHtml = "";
        var displayVariableHtml = "";
        try{
            if(contentType == null){
                $("input:radio[value='constant']").attr('checked','true');
                displayContentHtml = '<input type="number" class="form-control" name="v" value="" placeholder="请输入定值...">';
                $("#displayVariable").html(displayContentHtml);
            }else if(contentType == "constant"){
                displayContentHtml = '<input type="number" class="form-control" name="v" value="'+variableString+'" placeholder="请输入定值...">';
                $("#displayVariable").html(displayContentHtml);
            }else if(contentType == "range"){
                variableList = variableString.split("\n");
                displayContentHtml = '<p style="float:left"><input style="width:180px;" type="number" class="form-control" name="v" value="'+variableList[0]+'" placeholder="开始值..."><p style="float:left">'
                                        +'<p style="float:left;font-size:150%;font-weight:bold;">&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;<p style="float:left">'
                                        +'<p style="float:left"><input style="width:180px;" type="number" class="form-control" name="v" value="'+variableList[1]+'" placeholder="结束值..."><p style="float:left">';
                $("#displayVariable").html(displayContentHtml);
            }

        }catch (e) {
            console.log("123===="+e);
        }

        $('input:radio[name="contentType"]').click(function(){
            var checkValue = $('input:radio[name="contentType"]:checked').val();
            if(checkValue == "constant"){
                $("#displayVariable").empty();
                displayVariableHtml = '<input type="number" class="form-control" name="v" value="" placeholder="请输入定值...">';
                $("#displayVariable").html(displayVariableHtml);
            }else if(checkValue == "range"){
                $("#displayVariable").empty();
                displayVariableHtml = '<p style="float:left"><input style="width:180px;" type="number" class="form-control" name="v" value="" placeholder="开始值..."></p>'
                        +'<p style="float:left;font-size:150%;font-weight:bold;">&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;</p>'
                        +'<p style="float:left"><input style="width:180px;" type="number" class="form-control" name="v" value="" placeholder="结束值..."></p>';
                $("#displayVariable").html(displayVariableHtml);
            }
        });

        //提交数据
        $("#variable_saveBtn").bind("click", function () {

            var $input = $("input[type='number'][type!='hidden'][name='v']");
            var variable = [];
            var flag = 0;
            $.each($input, function (i, item) {
                var val = $(item).val();
                if(isEmpty(val)){
                    flag = 1;
                    return;
                }
                if(val.length > 225){
                    flag = 2;
                    return;
                }
                if(/[\'\"]/.test(val)){
                    flag = 3;
                    return;
                }
                if (val < 0) {
                    flag = 4;
                    return;
                }
                if(val > 999){
                    flag = 5;
                    return;
                }
                variable[i] = val;
            });
            if(flag == 1){
                $('#variable_result').html("变量值不能为空！");
                $('#variable_result').show();
                return;
            }
            if(flag == 2){
                $('#variable_result').html("变量值长度不能超过225个字符！");
                $('#variable_result').show();
                return;
            }
            if(flag == 3){
                $('#variable_result').html("变量值不能包含单引号和双引号！");
                $('#variable_result').show();
                return;
            }
            if(flag == 4){
                $('#variable_result').html("请输入大于0的值！");
                $('#variable_result').show();
                return;
            }
            if(flag == 5){
                $('#variable_result').html("变量值不能大于999！");
                $('#variable_result').show();
                return;
            }
            if(variable.length > 1){
			    if(variable[0] > variable[1]){
			        $('#variable_result').html("最小值不得大于最大值！");
			        $('#variable_result').show();
			        return;
			    }
			}
            $("#variableString").text(variable.join("\n"));

            // 1.校验
            // var isValiResult = validateActivity();
            // if(!isValiResult)
            //     return;

            // 2.按钮置灰
            var thatButton = $(this);
            thatButton.attr('disabled', 'disabled');

            // 3.表单提交
            var contentId = $("#variable_EditForm").find("input[name=contentId]").val();
            var menuId = $("#variable_EditForm").find("input[name=menuId]").val();
            var uniqueCode = $("#variable_EditForm").find("input[name=uniqueCode]").val();
            var locationCode = $("#variable_location").find('option:selected').val();
            var targetContentChannel = getCheckboxValOrAllVal("targetContentChannel");
            var channel = targetContentChannel.join(",");

            var content = $("#variableString").text();
            var contentType = $("input[type='radio']:checked").val();
            var type = "variable_manage";


            var data = {
                "id": contentId,
                "menuId": menuId,
                "type":type,
                "uniqueCode": uniqueCode,
                "contentType": contentType,
                "locationCode": locationCode,
                "content": content,
                "channel": channel
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
                        $("#variableManageEditModel").modal('hide');
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
                        $('#variable_result').html(data.errorMessage);
                        $('#variable_result').show();
                    }
                }
            });
        });

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


</script>