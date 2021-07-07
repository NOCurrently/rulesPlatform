<!-- 数据字典值增加 -->
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">添加数据字典值</h4>
        </div>
        <div id="dictValue_result" class="alert alert-danger" style="display:none"></div>
        <form id="r_dictValueForm" class="form-horizontal" role="form" method="post" action="${base}/web/dict/addSysDictValue">
            <input name="typeId" type="hidden" value=${dictTypeResponse.id}>
            <div class="modal-body">
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>类型编码</label>
                    <div class="col-sm-9">
                        ${dictTypeResponse.code}
                        <input type="hidden" class="form-control" id="dictTypeCode" name="typeId" value="${dictTypeResponse.id}" placeholder="数据字典类型ID">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>值名称</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="valueName" name="name" placeholder="值名称">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>值编码</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="valueCode" name="code" placeholder="值编码">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger"></strong>排序</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="valueSort" name="sort" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')" value="0"
                               placeholder="请输入正整数">
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
                <button type="button" class="btn btn-primary" id="dictValueSaveBtn">保存</button>
            </div>
        </form>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript">

    //提交数据
    $("#dictValueSaveBtn").bind("click", function () {
        if (!$("#valueName").val()) {
            $('#dictValue_result').html("值名称不能为空！").show();
            return;
        }
        if (!$("#valueCode").val()) {
            $('#dictValue_result').html("值编码不能为空！").show();
            return;
        }
        $(this).attr('disabled', 'disabled');
        $('#r_dictValueForm').ajaxForm({
        	 dataType: 'json',
            success:function (data) {
            	 dictValueComplete(data); 
    			 $("#dictValueSaveBtn").removeAttr('disabled');
            },  
			 error: function (e) {
    			 $("#dictValueSaveBtn").removeAttr('disabled');
	         }
           
        }).submit();
        return false;
    });

    //提交成功后调用
    function dictValueComplete(data) {
        if (data.code == "200") {
            $("#createDictValueModel").modal('hide');
        } else {
            $('#dictValue_result').html(data.errorMessage).show();
        }
    }
</script>