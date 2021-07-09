<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">修改数据字典值</h4>
        </div>
        <input id = "dictVTypeId" type="hidden" value=${dictValueResponse.typeId}>
        <div id="m_dictValue_result"  class="alert alert-danger" style="display:none"></div>
        <form  id="m_dictValueForm"  class="form-horizontal" role="form" method="post" action="${base}/sysDictValue/updateSysDictValue">
            <input name="id" type="hidden" value=${dictValueResponse.id}>
            <div class="modal-body">
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>值</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="value" name="value" value="${dictValueResponse.value}" placeholder="值">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>默认显示</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="labelDefault" name="labelDefault" value="${dictValueResponse.labelDefault}" placeholder="默认显示">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger"></strong>排序</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="sort" name="sort" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')" value="${dictValueResponse.sort}" placeholder="输入正整数">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger"></strong>备注</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="remark" name="remark" value="${dictValueResponse.remark}" placeholder="备注">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="dictValueUpdateBtn">保存</button>
            </div>
        </form>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

  <script type="text/javascript">

	$(function () {
		  var path = $("#path").val();
	      //提交数据
	      $("#dictValueUpdateBtn").bind("click",function(){
	          $('#m_dictValueForm').ajaxForm({
	              success:       dictValueComplete,  	 // post-submit callback
	              dataType: 'json'
	          }).submit();
	          return false;
	      });
	
	      //提交成功后
	      function dictValueComplete(data){
	          if (data.code== "200"){
	          	var id = $("#dictVTypeId").val();
	          	$("#modifyDictValueModel").modal('hide');
	          	$('#dictValueListPaging').load(path + "/sysDictValue/listSysDictValue?id="+id);
	          } else {
	          	$('#m_dictValue_result').html(data.errorMessage).show();
	          }
	      }
	});
  </script>
