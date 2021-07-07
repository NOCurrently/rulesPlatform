<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">维护站点</h4>
        </div>
        <div id="r_result" class="alert alert-danger" style="display:none"></div>
        <form id="menuForm" class="form-horizontal" role="form" method="post" action="${base}/backendMenu/insertMenu">
            <input type="hidden" name="id" <#if menu??>value="${menu.id!}"</#if>>
            <div class="modal-body">
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>节点名称</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="title" placeholder="节点名称" <#if menu??>value="${menu.title!}"</#if>>
                    </div>
                </div>
                <div class="form-group">
                    <label for="stationCode" class="col-sm-3 control-label"><strong class="text-danger">*</strong>节点编码</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="code" placeholder="节点编码" <#if menu??>value="${menu.code!}" readonly="readonly"</#if>>
                    </div>
                </div>
               <div class="form-group">
                    <label for="versionCode" class="col-sm-3 control-label"><strong class="text-danger">*</strong>节点类型</label>
                    <div class="col-sm-9">
                        <select id="menuType" class="form-control" name="menuType" <#if menu??>disabled="disabled"</#if>>
                        </select>
                    </div>
                </div>
                
 				<div class="form-group" id="formTypeDiv" style="display: none;">
                    <label for="versionCode" class="col-sm-3 control-label"><strong class="text-danger">*</strong>模板类型</label>
                    <div class="col-sm-9">
                        <select id="formType" class="form-control" name="templateCode">
                        </select>
                    </div>
                </div>
                 <div class="form-group">
                    <label for="priority" class="col-sm-3 control-label">优先级</label>
                    <div class="col-sm-9">
                        <input id="menuPriority" type="number" class="form-control" name="priority" placeholder="优先级" <#if menu??>value="${menu.priority!}"</#if>>
                    </div>
                </div>
                <div class="form-group">
                    <label for="remarks" class="col-sm-3 control-label">备注说明</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="remarks" placeholder="请输入你的描述" <#if menu??>value="${menu.remarks!}"</#if>>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <a type="button" class="btn btn-primary" id="saveBtn">保存</a>
            </div>
        </form>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {
            var path = $("#path").val();
            var menuId = $("#menuId").val();
            var menuTypeSelect='';
    <#if menu??>
    	menuTypeSelect='${menu.type!}';
    </#if>
            var formTypeSelect='';
    <#if menu??>
    	formTypeSelect='${menu.templateCode!}';
    </#if>
    
    DictValueLoadSelect("menuType", "menu_type", path,menuTypeSelect);
        $('#menuType').on('change',function(data) {
        	var type = $(this).val();
        	var display =$('#formTypeDiv').css('display');
        	
       		if(type=="tag"){

				$("#formTypeDiv").css("display","block");//显示div
	        }else{
	        	$("#formTypeDiv").css("display","none");//隐藏div
	        
	        }
        
        });
     $.ajax({
        type: "get",
        url: path + "/backendTemplate/getAllTemplateCode",
        dataType: 'json',
        success: function (jsonData) {
            var select = $("#formType");
            select.empty();
            select.append('<option value="">请选择</option>');
            if (jsonData.success) {
            	 $(jsonData.data).each(function(i,data){
                     select.append("<option value='"+data.templateCode+"'>"+data.title+"</option>");
                 });
			}
            $("#formType option[value='"+formTypeSelect+"']").prop("selected", true);
        }
    });
    
   //提交数据
    $("#saveBtn").click( function () {
        var priorityVal = $("#menuPriority").val();
        if(!isEmpty(priorityVal)) {
            if(priorityVal>999){
                $('#r_result').html("优先级必须小于999！");
                $('#r_result').show();
                return;
            }
        }
     $(this).attr('disabled', 'disabled');

        // 获取表单数据前移除select框disabled属性，否则获取不到数据
        $('#menuType').attr("disabled",false);
        let searchPara = $('#menuForm').serialize();

        $.ajax({
    		type : "post",
    		url : path + "/backendMenu/insertMenu?parentId=" + menuId+"&"+searchPara,
    		format : "json",
    		success : function(data) {
    			roleComplete(data);
    			 $("#saveBtn").removeAttr('disabled');
    			
    		},
    		 error: function (e) {
    			 $("#saveBtn").removeAttr('disabled');
            }
    	});
    });

    //提交成功后
    function roleComplete(data) {
        if (data.success) {
        //关闭窗口
        $("#updateMenu").modal('hide');
            //刷新页面
            listPaging = new PageView({
                pageContainer: $("#listPaging"),
                pageListContainer: $("#data-table"),
                pageViewName: 'listPaging',
                url: path + "/backendMenu/menuListData",
                curPageName: 'currentPage',
                pageSize: 15,
                urlRequestData: {
                    "parentId": menuId
                }
            });
        } else {
            $('#r_result').html(data.errorMessage).show();
        }
    }
    });
</script>