<link type="text/css" rel="stylesheet" href="${base}/static/css/select2.css"/>
<link type="text/css" rel="stylesheet" href="${base}/static/css/select2-bootstrap.min.css"/>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">维护站点</h4>
        </div>
         <#if message??>
             <div id="r_result" class="alert alert-danger" >${message!}</div>

         <#else>
             <div id="r_result" class="alert alert-danger" style="display:none"></div>

         </#if>

        <form id="menuForm" class="form-horizontal" role="form" method="post" action="${base}/backendMenu/insertMenu">
            <input type="hidden" name="id" <#if station??>value="${station.id!}"</#if>>
            <div class="modal-body">
            <div class="form-group">
                    <label for="stationCode" class="col-sm-3 control-label"><strong class="text-danger">*</strong>集合名称</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="title" placeholder="集合名称" <#if station??>value="${station.title!}"</#if>>
                    </div>
                </div>
               
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>城市</label>
                    <div class="col-sm-9">
                        <select id="city" class="js-example-basic-single form-control" multiple="multiple" style="width: 100%">
                            <#if cityList??>
                                <#list cityList as city>
                                    <option value="${city.cityId!}">${city.cityCnName!}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>
                
              <div class="form-group">
                    <label for="onlineFlag" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>状态</label>
                    <div class="col-sm-9">
                        <div class="controls">
                            <label class="radio">
                                <input class="radio" type="radio" name="status" value="1"
                                       <#if !station??> checked
                                       <#elseif station?? &&  station.status== 1>checked</#if>>开
                            </label><label class="radio">
                            <input class="radio" type="radio" name="status" value="0"
                                       <#if station?? && station.status == 0>checked</#if>>关
                        </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="remarks" class="col-sm-3 control-label">备注说明</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="remarks" placeholder="请输入你的描述" <#if station??>value="${station.remarks!}"</#if>>
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
<script type="text/javascript" src="${base}/static/js/select2.js"></script>

<script type="text/javascript">
    $(function () {
    var cityList="";
    let hotCityVal = $('#city').select2({
            theme: "bootstrap",
            dropdownParent: $("#updateMenu"),
            language: "zh-CN",
            templateSelection: formatState
        });
        function formatState(state) {
            if (state.id) {
            cityList=hotCityVal.val();
                return state.text;
            }
        }
       <#if menus??>
         var b  = new Array();
        <#list menus as menu>
        b.push(${menu});
         </#list>
         hotCityVal.val(b).trigger("change");
       </#if>
        
            var path = $("#path").val();
            var menuId = $("#menuId").val();
            var menuTypeSelect='';
    
   //提交数据
    $("#saveBtn").click( function () {
     $(this).attr('disabled', 'disabled');
     let searchPara = $('#menuForm').serialize();
        $.ajax({
    		type : "post",
    		url : path + "/backendStation/insert?cityList=" + cityList+"&"+searchPara,
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
                url: path+"/backendStation/stationList",
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