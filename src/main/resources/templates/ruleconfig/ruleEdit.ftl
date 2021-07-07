<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">内容配置规则维护</h4>
        </div>

        <div id="rule_result" class="alert alert-danger" style="display:none"></div>

        <form id="rule_EditForm" class="form-horizontal" method="post" action="${base}">
            <input type="hidden" name="ruleId" <#if info??>value="${info.id!}"</#if> >
            <div class="modal-body">
                <div class="form-group">
                    <label for="type_code" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>类别</label>
                    <div class="col-sm-9">
                        <select id="type_code" class="form-control" name="type_code">
                        </select>
                        <input type="hidden" id="typeCodeDefVal" <#if info??>value='${info.typeCode!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="code_name" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>名称</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="code_name" name="code_name"
                               <#if info??>value="${info.name!}"</#if> placeholder="编码名称">
                    </div>
                </div>

                <div class="form-group">
                    <label for="rule_code" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>编码</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="rule_code" name="rule_code"
                               <#if info??>value="${info.code!}"</#if> placeholder="支持数字、字母和下划线">
                    </div>
                </div>

                <div class="form-group">
                    <label for="min_content" class="col-sm-3 control-label">可配置文案数</label>
                    <div class="col-sm-9">
                        <p style="float:left;margin:0;"><input style="width:180px;" type="number" class="form-control"
                                                               id="min_content" name="min_content"
                                                               <#if info??>value="${info.minContent!}"</#if>
                                                               placeholder="最小值（默认0无限制）"></p>
                        <p style="float:left;margin:0;font-size:150%;font-weight:bold;">&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;</p>
                        <p style="float:left;margin:0;"><input style="width:180px;" type="number" class="form-control"
                                                               id="max_content" name="max_content"
                                                               <#if info??>value="${info.maxContent!}"</#if>
                                                               placeholder="最大值（默认0无限制）"></p>
                        <span style="color:red">(ps:两边相等表示定值，均为0则表示无限制)</span>
                    </div>
                </div>

                <div class="form-group">
                    <label for="min_img" class="col-sm-3 control-label">可配置图片数</label>
                    <div class="col-sm-9">
                        <p style="float:left;margin:0;"><input style="width:180px;" type="number" class="form-control"
                                                               id="min_img" name="min_img"
                                                               <#if info??>value="${info.minImg!}"</#if>
                                                               placeholder="最小值（默认0无限制）"></p>
                        <p style="float:left;margin:0;font-size:150%;font-weight:bold;">&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;</p>
                        <p style="float:left;margin:0;"><input style="width:180px;" type="number" class="form-control"
                                                               id="max_img" name="max_img"
                                                               <#if info??>value="${info.maxImg!}"</#if>
                                                               placeholder="最大值（默认0无限制）"></p>
                        <span style="color:red">(ps:两边相等表示定值，均为0则表示无限制)</span>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="rule_saveBtn">保存</button>
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

        // 编码类别
        var typeCodeDefVal = $("#typeCodeDefVal").val();
        dictValueLoadSelectSort("type_code", "rule_config", path, typeCodeDefVal, "选择类别");

        //提交数据
        $("#rule_saveBtn").bind("click", function () {

            // 1.校验
            var isValiResult = validateRule();
            if (!isValiResult) {
                return;
            }

            // 2.按钮置灰
            var thatButton = $(this);
            thatButton.attr('disabled', 'disabled');

            // 3.表单提交
            var ruleId = $("#rule_EditForm").find("input[name=ruleId]").val();
            var typeCode = $("#type_code").find('option:selected').val();
            var name = $("#code_name").val();
            var code = $("#rule_code").val();
            var minContent = $("#min_content").val();
            var maxContent = $("#max_content").val();
            var minImg = $("#min_img").val();
            var maxImg = $("#max_img").val();

            var data = {
                "id": ruleId,
                "typeCode": typeCode,
                "name": name,
                "code": code,
                "minContent": minContent,
                "maxContent": maxContent,
                "minImg": minImg,
                "maxImg": maxImg
            };
            $.ajax({
                url: path + '/contentConfigRule/editRule',
                data: JSON.stringify(data),
                method: 'POST',
                dataType: "json",
                contentType: 'application/json;charset=UTF-8',
                success: function (data) {
                    if (200 == data.code) {
                        //关闭当前窗口
                        $("#ruleEditModel").modal('hide');
                        // 需要刷新下页面

                        //pageSize标签存在于page.js中
                        var pageSize = $("#selectPageForm").val();
                        if (!pageSize) {
                            pageSize = 15;
                        }
                        ruleListPaging = new PageView({
                            pageContainer: $("#page-table"),
                            pageListContainer: $("#data-table"),
                            pageViewName: 'ruleListPaging',
                            url: path + "/contentConfigRule/ruleListData",
                            curPageName: 'currentPage',
                            pageSize: pageSize,
                            urlRequestData: {}
                        });

                    } else {
                        // 允许页面数据重新编辑
                        thatButton.removeAttr('disabled');

                        // 显示之前的错误信息
                        $('#rule_result').html(data.errorMessage);
                        $('#rule_result').show();
                    }
                }
            });
        });

        // 校验
        function validateRule() {
            var minContent = $("#min_content").val();
            var maxContent = $("#max_content").val();
            var minImg = $("#min_img").val();
            var maxImg = $("#max_img").val();
            var pattern = /^\d+$/;
            if (!isEmpty(minContent)) {
                if (!pattern.test(minContent)) {
                    $('#rule_result').html("可配置文案数须为非负整数！");
                    $('#rule_result').show();
                    return false;
                }
            }
            if (!isEmpty(maxContent)) {
                if (!pattern.test(maxContent)) {
                    $('#rule_result').html("可配置文案数须为非负整数！");
                    $('#rule_result').show();
                    return false;
                }
            }
            if (!isEmpty(minContent) && !isEmpty(maxContent) && !(minContent == 0 || maxContent == 0)) {
                if (minContent > maxContent) {
                    $('#rule_result').html("最小文案数不允许大于最大文案数！");
                    $('#rule_result').show();
                    return false;
                }
            }
            if (!isEmpty(minImg)) {
                if (!pattern.test(minImg)) {
                    $('#rule_result').html("可配置图片数须为非负整数！");
                    $('#rule_result').show();
                    return false;
                }
            }
            if (!isEmpty(maxImg)) {
                if (!pattern.test(maxImg)) {
                    $('#rule_result').html("可配置图片数须为非负整数！");
                    $('#rule_result').show();
                    return false;
                }
            }
            if (!isEmpty(minImg) && !isEmpty(maxImg) && !(minImg == 0 || maxImg == 0)) {
                if (minImg > maxImg) {
                    $('#rule_result').html("最小图片数不允许大于最大图片数！");
                    $('#rule_result').show();
                    return false;
                }
            }
            return true;
        }


    });


</script>