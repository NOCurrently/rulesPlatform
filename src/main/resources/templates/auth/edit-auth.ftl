  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">修改资源</h4>
      </div>
       <div id="m_auth_result"  class="alert alert-danger" style="display:none"></div>
      <form  id="m_authForm"  class="form-horizontal" role="form" method="post" action="${base}/sysauth/updateSysAuth">
        <input name="id" type="hidden" value=${authResponse.id}>
        
      <div class="modal-body">
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>资源名称</label>
			    <div class="col-sm-9">
			      <input type="text" class="form-control" id="editname" name="name" value="${authResponse.name}" placeholder="资源名称">
			    </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>资源编码</label>
			    <div class="col-sm-9">
			      <input type="text" class="form-control" id="editcode" name="code" value="${authResponse.code}" placeholder="资源编码">
			    </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>url</label>
			    <div class="col-sm-9">
			      <input type="text" class="form-control" id="editurl" name="url" value="${authResponse.url}" placeholder="url">
			    </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label">资源类别</label>
			    <div class="col-sm-9">
			        <!-- <input type="text" class="form-control" id="type2" name="type" placeholder="type" value="{$type}"> -->
			        <select name="type" class="form-control" id="edittype" style="width: 200px;">
			            <option <#if authResponse.type == 'oneLevel'>selected</#if> value="oneLevel">一级菜单</option>
			            <option <#if authResponse.type == 'url'>selected</#if> value="url">内部链接</option>
			         </select>
				    <span style="color:red">(ps:如选择有疑问可联系技术人员)</span>
			    </div>
			</div>
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label">排序</label>
			    <div class="col-sm-9">
			     <input type="text" class="form-control" id="editsort" name="sort" placeholder="sort" value="${authResponse.sort?c}" maxlength="10" onkeyup="this.value=this.value.replace(/\D/g,'')">
			     <span style="color:red">(数字类型)</span>
			    </div>
			</div>
			
			<div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label">图标icon</label>
			    <div class="col-sm-9">
			     <input type="text" class="form-control" id="editicon" name="icon" placeholder="icon" value="${authResponse.icon}">
			     <span style="color:red">(如果不要默认的，请联系管理员添加)</span>
			    </div>
			</div>
			 
			 <div class="form-group" id="oneLevelModify">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>选择一级菜单</label>
			    <div class="col-sm-9">
					<div class="controls">
						<select name="pid" class="form-control" id="editpid" style="width: 170px;">
							<#list firstMenuList as firstMenu>
								<option value="${firstMenu.id}" data-lev="${firstMenu.pid}" <#if firstMenu.id == authResponse.pid>selected="true"</#if>>${firstMenu.name}</option>
							</#list>
						</select>
					</div>
				</div>
			 </div>		
			 
		    <div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>用户状态</label>
			    <div class="col-sm-9">
					<div class="controls">
						<label class="radio">
							<input id="status1" class="radio" type="radio" <#if authResponse.status == 1>checked=checked</#if> name="status" value="1">启用
						</label>
						<label class="radio">
						<input id="status2" class="radio" type="radio" name="status" <#if authResponse.status == 0>checked=checked</#if>  value="0">关闭 
						</label>
					</div>			     
				</div>
			 </div>
			 <div class="form-group">
	       		 <label for="inputPassword3" class="col-sm-3 control-label">备注说明</label>
			    <div class="col-sm-9">
			     <input type="text" class="form-control" id="editremark" name="remark" placeholder="请输入你的描述" value="${authResponse.remark}">
			    </div>
			 </div> 
		
	  </div>       
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary" id="authUpdateBtn">保存</button>
      </div>
     </form>	
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
 <script type="text/javascript" src="${base}/static/js/auth/edit-auth.js"></script>
