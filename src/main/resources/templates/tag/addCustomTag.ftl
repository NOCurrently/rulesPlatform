<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">新增标签</h4>
        </div>


        <div id="tag_result" class="alert alert-danger" <#if !msg??>style="display:none"</#if>>
            <#if msg??>
                ${msg!''}
            </#if>
        </div>


        <form id="tag_EditForm" class="form-horizontal">
            <div class="modal-body">
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>标签名称</label>
                    <div class="col-sm-9">
                        <input type="hidden" id="id" <#if tagDb??>value="${tagDb.id!''}"</#if>>
                        <input type="text" class="form-control" name="tagNameCustom" placeholder="标签名称" <#if tagDb??>value="${tagDb.tagName!''}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="type" class="col-sm-3 control-label"><strong class="text-danger">*</strong>编码</label>
                    <div class="col-sm-9">
                        <#if tagDb??>
                                <input type="text" name="tagCodeCustom" disabled="true" <#if tagDb??>value="${tagDb.tagCode!''}"</#if>>
                            <#else>
                                <select id="tagCodeCustom" class="form-control" name="tagCodeCustom">
                                </select>
                        </#if>

                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>排序</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="sort" placeholder="排序" <#if tagDb??>value="${tagDb.sort!'1'}"<#else>value="1"</#if>>
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">最小值</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="min" placeholder="最小值" <#if tagDb??>value="${tagDb.minVal!''}"</#if> >
                    </div>
                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">最大值</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="max" placeholder="最大值" <#if tagDb??>value="${tagDb.maxVal!''}"</#if>>
                    </div>
                </div>
                <div class="form-group">
                    <label for="onlineFlag" class="col-sm-3 control-label"><strong
                                class="text-danger">*</strong>状态</label>
                    <div class="col-sm-9">
                        <div class="controls">
                            <label class="radio">
                                <input class="radio" type="radio" name="status" value="1"  <#if !tagDb??> checked
                                    <#elseif tagDb?? &&  tagDb.status== 1>checked</#if>>开
                            </label>
                            <label class="radio">
                                <input class="radio" type="radio" name="status" value="0" <#if !tagDb??> checked
                                    <#elseif tagDb?? &&  tagDb.status== 0>checked</#if>>关
                            </label>
                        </div>
                    </div>
                </div>

                <div class="form-group" style="display:none">
                    <label for="targetBannerChannel" class="col-sm-3 control-label">终端设备</label>
                    <div class="col-sm-9">
                        <div id="targetBannerChannel">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="remarks" class="col-sm-3 control-label">备注说明</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="remark" placeholder="请输入你的描述"  <#if tagDb??>value="${tagDb.remark!''}"</#if>>
                    </div>
                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveTagCustom">保存</button>
            </div>
        </form>


    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {

        // 页面上内容初始化
        var path = $("#path").val();

        var tagCodeCustomDefVal = "";
        dictValueLoadSelectSort("tagCodeCustom", "tag_code", path,tagCodeCustomDefVal);

        var bannerChannelDefVal = "";
        dictValueLoadOptionaAll("targetBannerChannel", "target_channel", "targetBannerChannel",path,bannerChannelDefVal);



        //提交数据
        $("#saveTagCustom").bind("click", function () {


            // 1.校验
            var isValiResult = validateTagCustom();
            if (!isValiResult)
                return;

            // 2.按钮置灰
            var thatButton = $(this);
            thatButton.attr('disabled', 'disabled');

            // 3.表单提交
            var id = $("#id").val();
            var tagName = $("input[name=tagNameCustom]").val();
            var tagCodeCustom ="";
            if (id != "") {
                tagCodeCustom= $("input[name=tagCodeCustom]").val();
            } else {
                tagCodeCustom = $("#tagCodeCustom").find('option:selected').val();
            }
            var sort = $("input[name=sort]").val();
            var min = $("input[name=min]").val();
            var max = $("input[name=max]").val();
            var targetBannerChannel = getCheckboxValOrAllVal("targetBannerChannel").join(",");
            var status = $("input[name=status]:checked").val();
            var ramark = $("input[name=remark]").val();

            var data = {
                "id":id,
                "tagName":tagName,
                "tagCode":tagCodeCustom,
                "sort":sort,
                "minVal":min,
                "maxVal":max,
                "firstChannel":targetBannerChannel,
                "status":status,
                "remark":ramark
            };

            $.ajax({
                url: path+'/backendTag/editCustomTag',
                data: JSON.stringify(data),
                method: 'POST',
                dataType: "json",
                contentType: 'application/json;charset=UTF-8',
                success: function (data) {
                    if(200 == data.code){
                        //关闭当前窗口
                        $("#editTagInitDiv").modal('hide');

                        $("#search-button").click();

                    }else{
                        // 允许页面数据重新编辑
                        thatButton.removeAttr('disabled');

                        // 显示之前的错误信息
                        $('#tag_result').html(data.displayMessage).show();
                    }
                }
            });
        });


        /**
         * 校验表单
         */
        function validateTagCustom() {

            // 1.校验标签名称
            var tagName = $("input[name=tagNameCustom]").val();
            if(isEmpty(tagName)){
                $('#tag_result').html("标签名称不能为空！").show();
                return false;
            }
            if(tagName.length > 100){
                $('#tag_result').html("标签名称长度不能超过100！").show();
                return false;
            }

            // 2.编码
            var tagCodeCustom ="";
            var id = $("#id").val();
            if (id != "") {
                tagCodeCustom= $("input[name=tagCodeCustom]").val();
            } else {
                tagCodeCustom = $("#tagCodeCustom").find('option:selected').val();
            }
            if(isEmpty(tagCodeCustom)){
                $('#tag_result').html("编码不能为空！").show();
                return false;
            }

            // 3.排序
            var priority = $("input[name=sort]").val();
            if(!isEmpty(priority)) {
                if (!(/^\+?[1-9][0-9]*$/).test(priority)) {
                    $('#tag_result').html("排序必须为正整数！");
                    $('#tag_result').show();
                    return false;
                }

                if(priority> 1000){
                    $('#tag_result').html("排序最大为999！");
                    $('#tag_result').show();
                    return false;
                }
            }else{
                $('#tag_result').html("排序不能为空！").show();
                return false;
            }


            // 4.最小值
            var min = $("input[name=min]").val();
            if(!isEmpty(min)) {
                if (!isPlusNumeric(min)) {
                    $('#tag_result').html("最小值必须为正数！");
                    $('#tag_result').show();
                    return false;
                }

                if(min> 1000){
                    $('#tag_result').html("最小值最大为999！");
                    $('#tag_result').show();
                    return false;
                }
            }

            // 5.最大值
            var max = $("input[name=max]").val();
            if(!isEmpty(max)) {
                if (!isPlusNumeric(max)) {
                    $('#tag_result').html("最大值必须为正数！");
                    $('#tag_result').show();
                    return false;
                }

                if(max> 1000){
                    $('#tag_result').html("最大值最大为999！");
                    $('#tag_result').show();
                    return false;
                }

                if(!isEmpty(min) && isPlusNumeric(min)){
                    var plus = parseFloat(max) - parseFloat(min);
                    if(plus <0){
                        $('#tag_result').html("最大值必须大于最小值！");
                        $('#tag_result').show();
                        return false;
                    }
                }
            }


            // 6.备注说明
            var remarks = $("input[name=remark]").val();
            if(remarks.length > 200){
                $('#tag_result').html("备注长度不能超过200！").show();
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


</script>