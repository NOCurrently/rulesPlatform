<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">添加日志</h4>
        </div>
        <div id="log_result" class="alert alert-danger" style="display:none"></div>
        <form id="logEditForm" class="form-horizontal" role="form" method="post" action="${base}/operationLog/insertLog">
        <input type="hidden" name="id" <#if menu??>value="${menu.id!}"></#if>>
            <div class="modal-body">
                <div class="form-group">
                    <label for="log_type" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作类型</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="type" placeholder="操作类型" id="log_type" <#if menu??>value="${menu.type!}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="log_username" class="col-sm-3 control-label"><strong class="text-danger"></strong>用户名</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="username" placeholder="用户名" id="log_username" <#if menu??>value="${menu.username!}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="log_url" class="col-sm-3 control-label"><strong class="text-danger"></strong>操作URL</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="url" placeholder="操作URL" id="log_url" <#if menu??>value="${menu.username!}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="log_table" class="col-sm-3 control-label"><strong class="text-danger"></strong>表名</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="table" placeholder="表名" id="log_table" <#if menu??>value="${menu.username!}"</#if>>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <a type="button" class="btn btn-primary" id="saveBtn_log">保存</a>
            </div>
        </form>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {
        var path = $("#path").val();

        //提交数据
        $("#saveBtn_log").bind("click",function(){
            if(!$("#log_type").val()) {
                $('#log_result').html("操作类型不能为空！").show();
                return;
            }
            if(!isInteger($("#log_type").val())) {
                $('#log_result').html("操作类型必须为数字！").show();
                return;
            }
            if ($("#log_username").val().length > 100) {
                $('#log_result').html("操作者姓名长度不能超过100").show();
                return;
            }
            if ($("#log_url").val().length > 200) {
                $('#log_result').html("操作URL长度不能超过200").show();
                return;
            }
            if ($("#log_table").val().length > 200) {
                $('#log_result').html("表名长度不能超过你50").show();
                return;
            }

            $('#logEditForm').ajaxForm({
                success: logEditComplete,
                dataType: 'json'
            }).submit();
            return true;
        });

        //提交成功后
        function logEditComplete(data) {
            if (data.success) {
                //关闭窗口
                $("#insertLogModel").modal('hide');
                //刷新页面

                //pageSize标签存在于page.js中
                var pageSize = $("#selectPageForm").val();
                if (!pageSize) {
                    pageSize = 15;
                }

                logListPaging = new PageView({
                    pageContainer: $("#logListPaging"),
                    pageListContainer: $("#data-table"),
                    pageViewName: 'logListPaging',
                    url: path + "/operationLog/logListData",
                    curPageName: 'currentPage',
                    pageSize: pageSize,
                    urlRequestData: {
                    }
                });
            } else {
                $('#log_result').html(data.errorMessage).show();
            }
        }
    });
</script>