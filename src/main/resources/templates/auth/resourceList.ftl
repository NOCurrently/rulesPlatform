<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css" >
    
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>
<input type="hidden" id="path" value="${base}"/>
<div class="am-form-inline" id="search-box">
	<span>名称：</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field" id = "authname"/>
    </div>
    <span>&nbsp;&nbsp;资源url：</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field" id = "authurl"/>
    </div>
    <button class="am-btn am-btn-primary" id="search-button">搜索</button>
    <button class="am-btn  am-btn-primary" id="clear-btn">清空</button>
    <button class="am-btn am-btn-primary" id="insert-button">新增</button>
</div>
<div id="data-table">
</div>
<div id="authListPaging">
	
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
         <input type="hidden" id="authId"/>  
         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>  
         <button type="button" id = "imsuer" class="btn btn-success" data-dismiss="modal">确定</button>
      </div>  
    </div><!-- /.modal-content -->  
  </div><!-- /.modal-dialog -->  
</div><!-- /.modal -->  


<div class="modal fade" id="createAuthModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">添加资源权限</h4>
      </div>
       <div id="auth_result"  class="alert alert-danger" style="display:none"></div>
      <form  id="r_authForm"  class="form-horizontal" role="form" method="post" action="${base}/web/auth/addSysAuth">
      
      <div class="modal-body">
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>资源名称</label>
			    <div class="col-sm-9">
			      <input type="text" class="form-control" id="name" name="name" placeholder="资源名称">
			    </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>资源编码</label>
			    <div class="col-sm-9">
			      <input type="text" class="form-control" id="code" name="code" placeholder="资源编码">
			    </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>url</label>
			    <div class="col-sm-9">
			      <input type="text" class="form-control" id="url" name="url" placeholder="url">
			    </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger"></strong>资源类别</label>
			    <div class="col-sm-9">
			     <select name="type" id="type" class="form-control">
			     	<option value="oneLevel">一级菜单</option>
			     	<option value="url">内部链接</option>
			     </select>
			     <span style="color:red">(ps:如选择有疑问可联系技术人员)</span>
			    </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label">排序</label>
			    <div class="col-sm-9">
			     <input type="text" class="form-control" id="sort" name="sort"  maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入数字类型">
			    </div>
			</div>
			
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label">图标icon</label>
			    <div class="col-sm-9">
			     <input type="text" class="form-control" id="icon" name="icon" value="fa-home">
			     <span style="color:red">(如果不要默认的，请联系管理员添加)</span>
			    </div>
			</div>
			 
			 <div class="form-group" id="oneLevel">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>选择一级菜单</label>
			    <div class="col-sm-9">
						<div class="controls">
							<select name="pid" class="form-control" id="pid" style="width: 170px;">
								
							</select>
						</div>		     
				</div>
			 </div>
			 
		    <div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>用户状态</label>
			    <div class="col-sm-9">
					<div class="controls">
						<label class="radio">
							<input id="status1" class="radio" type="radio" checked="" name="status" value="1">启用
						</label>
						<label class="radio">
						<input id="status2" class="radio" type="radio" name="status" value="0">关闭 
						</label>
					</div>			     
				</div>
			 </div>
			 <div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label">备注说明</label>
			    <div class="col-sm-9">
			     <input type="text" class="form-control" id="remark" name="remark" placeholder="请输入你的描述"">
			    </div>
			 </div> 
		
	  </div>
	  
	  <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" id="authSaveBtn">保存</button>
      </div>
     </form>	
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" id="modifyAuthModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div><!-- /.modal -->

<!-- 用户角色管理 -->
<div class="modal fade" id="authRoleModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div><!-- /.modal -->

<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>

<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script type="text/javascript" src="${base}/static/js/auth/auth-list.js"></script>

<script src="${base}/static/bounced/js/jquery.form.js"></script> 
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script> 
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</body>
</html>