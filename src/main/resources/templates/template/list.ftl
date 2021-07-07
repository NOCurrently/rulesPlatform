<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>


<!--页面隐藏数据部分-->
<input type="hidden" id="path" value="${base}"/>
<input type="hidden" id="id"/>


<!--页面表单处理结果-->
<div id="active_result_template" class="alert alert-danger" style="display:none"></div>

<!--查询条件-->
<div class="am-form-inline" id="search-box">
    <#--<div class="am-form-inline">-->
        <span>表单code:</span>
        <div class="am-form-group">
            <input type="text" class="search-input am-form-field" id="templateCode" name="templateCode"/>
        </div>
    <#--</div>-->

    <#--</br>-->
    <#--<div class="am-form-inline">-->
        <button class="am-btn  am-btn-primary" id="search-button_template">搜索</button>
        <button class="am-btn  am-btn-primary" id="clear-button_template">清空</button>
        <button class="am-btn  am-btn-primary" id="insert-button_template">新增</button>
    <#--</div>-->
</div>

<!-- 列表数据-->
<div id="data-table">
</div>

<!-- 分页数据 -->
<div id="page-table">
</div>


<!-- 查看 -->
<div class="modal fade" id="detail-table_template" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

</div>

<!-- 新增内容模版 -->
<div class="modal fade" id="createContentTemplateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加内容模版</h4>
            </div>
            <div id="contentTemplate_result" class="alert alert-danger" style="display:none"></div>
            <form id="contentTemplate_form" class="form-horizontal" role="form" method="post" action="${base}/backendTemplate/addTemplate">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>表单code</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="formCode" name="templateCode" placeholder="表单code">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>标题</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="title" name="title" placeholder="标题">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label">数据编码</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="code" name="code" placeholder="支持数字、字母和下划线...">
                        </div>
                    </div>
                     <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>模版路径</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="templateUrl" name="templateUrl" placeholder="模版路径">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label">优先级</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="priority" name="priority" maxlength="3" placeholder="优先级">
                        </div>
                    </div>
                   
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger"></strong>备注</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="remarks" name="remarks" placeholder="备注">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="contentTemplateSaveBtn">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 模版内容修改 -->
<div class="modal fade" id="modifyTemplateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>

<!-- 添加自定义参数 -->
<div class="modal fade" id="insertParamModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>

<!-- 删除选中模版 -->
<div class="modal fade" id="deleteTemplateModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">提示信息</h4>
            </div>
            <div class="modal-body">
                <p>您确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-success" id = "deleteTemplate" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 关闭/启用 -->
<div class="modal fade" id="changeTemplateStatusModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p id="templateStatusMessage"></p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="templateId"/>
                <input type="hidden" id="templateStatusFlag"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="changeTemplateStatus" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 引入的js文件-->
<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script type="text/javascript" src="${base}/static/js/template/list.js"></script>
<script src="${base}/static/js/date/WdatePicker.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</body>
</html>