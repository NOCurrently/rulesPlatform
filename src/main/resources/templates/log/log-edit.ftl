<div class="modal-dialog"> 
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">日志编辑</h4>
      </div>
      <div id="m_user_result"  class="alert alert-danger" style="display:none"></div>
      <form  id="m_userForm"  class="form-horizontal" role="form" method="post" action="${base}/sysLog/update">
        <input name="logId" type="hidden" value=${sysLogVo.logId}>
      <div class="modal-body">
            <div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>日志id</label>
			     <div class="col-sm-9">
			      ${sysLogVo.logId}
			      <input type="hidden" class="form-control" id="logId" name="logId" value="${sysLogVo.logId}" placeholder="日志id,请输入数字类型">
			     </div>
			 </div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作类型</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="type" name="type" value="${sysLogVo.type}" placeholder="操作类型,请输入数字类型">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作者Id</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="userId" name="userId" value="${sysLogVo.userId}" placeholder="操作者Id,请输入数字类型">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作者姓名</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="userName" name="userName" value="${sysLogVo.userName}" placeholder="操作者姓名">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>ip</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="ip" name="ip" value="${sysLogVo.ip}" placeholder="ip">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作对象类型</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="objectType" name="objectType" value="${sysLogVo.objectType}" placeholder="操作对象类型">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作对象Id</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="objectId" name="objectId" value="${sysLogVo.objectId}" placeholder="操作对象Id,请输入数字类型">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作内容</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="objectContent" name="objectContent" value="${sysLogVo.objectContent}" placeholder="操作内容">
			     </div>
			</div>
			
	  </div>       
	  <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" id="userUpdateBtn">保存</button>
      </div>
     </form>	
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->

  <script type="text/javascript">
  
  
  	//提交数据
	$("#userUpdateBtn").bind("click",function(){	
		 $('#m_userForm').ajaxForm({
	            success:       userComplete,  	 // post-submit callback
	            dataType: 'json'
	     }).submit();
		return false;
	});
	 
     //提交成功后
      function userComplete(data){
            $('#m_user_result').html(data.message).show();
              alert(data.message);
              window.location.reload();
            if (data.status== "1"){
            }
      }
  </script>