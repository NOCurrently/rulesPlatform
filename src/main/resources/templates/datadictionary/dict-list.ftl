<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="/css/dictType-list.css">
    <link rel="stylesheet" type="text/css" href="/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="/css/page.css" >

    <link rel="stylesheet" type="text/css" href="/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>
<input type="hidden" id="path" value="${base}"/>
<div class="am-form-inline" id="search-box">
	<span>名称：</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field"/>
    </div>
    <button class="am-btn am-btn-primary" id="search-button">搜索</button>
    <button class="am-btn  am-btn-primary" id="clear-btn">清空</button>
    <button class="am-btn  am-btn-primary" id="insert-button">新增</button>
</div>
<div id="data-table">
</div>
<!-- 信息删除确认 -->
<div class="modal fade" id="delcfmModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p>您确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="dictTypeId"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id = "imsuer" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="modal fade" id="delvaluecfm">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p>您确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="dictValueId"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id = "imsdictvalue" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div id="dictTypeListPaging">
</div>
<div class="modal fade" id="dictValueListPaging" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

</div>
<!-- 数据字典类型增加 -->
<div class="modal fade" id="createDictTypeModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">添加数据字典类型</h4>
            </div>
            <div id="dictType_result"  class="alert alert-danger" style="display:none"></div>
            <form  id="r_dictTypeForm"  class="form-horizontal" role="form" method="post" action="/sysDictType/addSysDictType">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>名称</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="name" name="name" placeholder="名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>编码</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="code" name="code" placeholder="编码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>类型</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="type" name="type" maxlength="1" placeholder="类型">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger"></strong>备注</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="remark" name="remark" placeholder="备注">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="dictTypeSaveBtn">保存</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- 数据字典类型修改 -->
<div class="modal fade" id="modifyDictTypeModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div><!-- /.modal -->
<!-- 数据字典值修改 -->
<div class="modal fade" id="modifyDictValueModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div><!-- /.modal -->
<div class="modal fade" id="createDictValueModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div><!-- /.modal -->
<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/page.js"></script>
<script type="text/javascript" src="/js/dict-list.js"></script>
<script src="/bounced/js/jquery.form.js"></script>
<script src="/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</body>
</html>