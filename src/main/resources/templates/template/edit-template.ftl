<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">修改模版内容</h4>
        </div>
        <div id="m_template_result" class="alert alert-danger" style="display:none"></div>
        <form id="editTemplate_form" class="form-horizontal" role="form" method="post" action="${base}/backendTemplate/updateTemplate">
            <div class="modal-body">
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>表单code</label>
                    <div class="col-sm-9">
                        <input type="text" readonly="readonly" class="form-control" id="editTemplateCode" name="templateCode" value="${editTemplateInfo.templateCode!}" placeholder="表单code">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>标题</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="editTitle" name="title" value="${editTemplateInfo.title!}" placeholder="标题">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label">数据编码</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="editCode" name="code" value="${editTemplateInfo.code!}" placeholder="支持数字、字母和下划线...">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>模版路径</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="editTemplateUrl" name="templateUrl" value="${editTemplateInfo.templateUrl!}" placeholder="模版路径">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label">优先级</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="editPriority" name="priority" maxlength="3" value="${editTemplateInfo.priority!}" placeholder="优先级">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger"></strong>备注</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="editRemarks" name="remarks" value="${editTemplateInfo.remarks!}" placeholder="备注">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="templateUpdateBtn">保存</button>
            </div>
        </form>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript">

    var path = $("#path").val();
    //提交模版内容数据
    $("#templateUpdateBtn").bind("click",function(){
        if(!$("#editTitle").val()) {
            $('#m_template_result').html("标题不能为空！").show();
            return;
        }
        if ($("#editTitle").val().length > 100) {
            $('#m_template_result').html("标题长度不能超过100").show();
            return;
        }
        if(!$("#editPriority").val()) {
            $("#editPriority").val(1)
        }
        if(!(/(^[1-9]\d*$)/.test($("#editPriority").val()))) {
            $('#m_template_result').html("优先级为正整数！").show();
            return;
        }
        if(!$("#editTemplateUrl").val()) {
            $('#m_template_result').html("模版路径不能为空！").show();
            return;
        }
        if ($("#editTemplateUrl").val().length > 200) {
            $('#m_template_result').html("模版路径长度不能超过200").show();
            return;
        }
        if ($("#editRemarks").val().length > 200) {
            $('#m_template_result').html("备注长度不能超过200").show();
            return;
        }

        // 2.按钮置灰
        var thatButton = $(this);
        thatButton.attr('disabled', 'disabled');


        $('#editTemplate_form').ajaxForm({
            success:  uptadeTemplateComplete,  	 // post-submit callback
            dataType: 'json'
        }).submit();
        return true;
    });

    //提交成功后
    function uptadeTemplateComplete(data){
        if (data.code=='200'){
            //关闭当前窗口
            $("#modifyTemplateModel").modal('hide');

            var curPage = $("#pageInput").val();
            if (!curPage) {
                curPage = 1;
            }
            //pageSize标签存在于page.js中
            var pageSize = $("#selectPageForm").val();
            if(!pageSize) {
                pageSize = 15;
            }
            templateListPaging = new PageView({
                pageContainer: $("#page-table"),
                pageListContainer: $("#data-table"),
                pageViewName: 'templateListPaging',
                url: path + "/backendTemplate/page",
                curPageName: 'currentPage',
                curPage:curPage,
                pageSize:pageSize,
                urlRequestData: {
                }
            });
        } else {
            $('#m_template_result').html(data.errorMessage).show();

        }
        $("#templateUpdateBtn").removeAttr('disabled');
        
    }
</script>