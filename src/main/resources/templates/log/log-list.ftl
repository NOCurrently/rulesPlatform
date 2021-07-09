<html>
<head>
    <meta charset="UTF-8">
    <title>日志管理</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
      <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css" >
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>
<input type="hidden" id="path" value="${base}"/>

<div class="am-form-inline" id="search-box">
	<span>操作者姓名：</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field" id = "type"/>
    </div>
	<span>操作对象URL：</span>
    <div class="am-form-group">
        <input type="text" class="search-input1 am-form-field" id = "objectId"/>
    </div>
    <button class="am-btn am-btn-primary" id="search-button">搜索</button>
    <button class="am-btn  am-btn-primary" id="clear-btn" onclick="f_clean();">清空</button>
</div>

<div id = "data-table">
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
         <input type="hidden" id="confirm-model"/>  
         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>  
         <button type="button" id = "imsuer" class="btn btn-success" data-dismiss="modal">确定</button>
      </div>  
    </div><!-- /.modal-content -->  
  </div><!-- /.modal-dialog -->  
</div><!-- /.modal -->  

<div id="logListPaging">
	
</div>

<div class="modal fade" id="createUserModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">添加日志</h4>
      </div>
       <div id="user_result"  class="alert alert-danger" style="display:none"></div>
      <form  id="r_userForm"  class="form-horizontal" role="form" method="post" action="${base}/sysLog/add">
      <div class="modal-body">
          <div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>日志id</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="logId" name="logId" placeholder="日志id,请输入数字类型">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作类型</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="type" name="type" placeholder="操作类型,请输入数字类型">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作者Id</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="userId" name="userId"  placeholder="操作者Id,请输入数字类型">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作者姓名</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="userName" name="userName" placeholder="操作者姓名">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>ip</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="ip" name="ip" placeholder="ip">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作对象类型</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="objectType" name="objectType" placeholder="操作对象类型">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作对象Id</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="objectId" name="objectId" placeholder="操作对象Id,请输入数字类型">
			     </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>操作内容</label>
			     <div class="col-sm-9">
			      <input type="text" class="form-control" id="objectContent" name="objectContent" placeholder="操作内容">
			     </div>
			</div>
			
  </div>
	  <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" id="userSaveBtn">保存</button>
      </div>
     </form>	
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" id="modifyUserModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div><!-- /.modal -->


<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>

<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script type="text/javascript" src="${base}/static/js/log/log_list.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script> 
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script> 
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript">

function f_clean() {
	$("#type").val("");
	$(".search-input1").val("");
}

//提交数据
	$("#userSaveBtn").bind("click",function(){	
		 $('#r_userForm').ajaxForm({
	            success:       userComplete,  	 // post-submit callback
	            dataType: 'json'
	     }).submit();
		return false;
	});
	 
     //提交成功后
      function userComplete(data){
            $('#user_result').html(data.message).show();
            alert(data.message);
            window.location.reload();
            if (data.status== "1"){
             
            }
      }
</script>
</body>
</html>