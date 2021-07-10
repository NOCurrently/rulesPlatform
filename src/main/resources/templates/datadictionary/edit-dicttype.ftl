<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">修改数据字典类型</h4>
        </div>
        <div id="m_dictType_result"  class="alert alert-danger" style="display:none"></div>
        <form  id="m_dictTypeForm"  class="form-horizontal" role="form" method="post" action="${base}/sysDictType/updateSysDictType">
            <input name="id" type="hidden" value=${dictTypeResponse.id}>
            <div class="modal-body">
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>名称</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="editname" name="name" value="${dictTypeResponse.name}" placeholder="名称">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>编码</label>
                    <div class="col-sm-9">
                        ${dictTypeResponse.code}
                        <input type="hidden" class="form-control" id="editcode" name="code" value="${dictTypeResponse.code}" placeholder="编码">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>类型</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="edittype" name="type" maxlength="1" value="${dictTypeResponse.type}" placeholder="类型">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger"></strong>备注</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="editremark" name="remarks" value="${dictTypeResponse.remarks!}" placeholder="备注">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="dictTypeUpdateBtn">保存</button>
            </div>
        </form>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

  <script type="text/javascript">

      var path = $("#path").val();
      //提交数据
      $("#dictTypeUpdateBtn").bind("click",function(){
      	  if(!$("#editname").val()) {
    			$('#m_dictType_result').html("名称不能为空！").show();
    			return;
	      }
	      if(!$("#editcode").val()) {
    			$('#m_dictType_result').html("编码不能为空！").show();
    			return;
	      }
	      if(!$("#edittype").val()) {
	    	    $('#m_dictType_result').html("类型不能为空！").show();
	    	    return;
	      }
          $('#m_dictTypeForm').ajaxForm({
              success:       dictTypeComplete,  	 // post-submit callback
              dataType: 'json'
          }).submit();
          return true;
      });

      //提交成功后
      function dictTypeComplete(data){
          if (data.code=='0'){
              //关闭当前窗口
              $("#modifyDictTypeModel").modal('hide');

              var keyword = $(".search-input").val();
              //curPage为当前页码，此$("#pageInput").val()取值为page.js中input框参数
              var curPage = $("#pageInput").val();
              if (!curPage) {
                  curPage = 1;
              }
              //pageSize标签存在于page.js中
              var pageSize = $("#pageSize").val();
              if(!pageSize) {
                  pageSize = 15;
              }
              dictTypeList = new PageView({
                  pageContainer: $("#dictTypeListPaging"),
                  pageListContainer: $("#data-table"),
                  pageViewName: 'dictTypeList',
                  url: path + "/sysDictType/listSysDictType",
                  curPageName: 'currentPage',
                  pageSize: pageSize,
                  curPage: curPage,
                  urlRequestData: {
                      "keyword": keyword
                  }
              });
          } else {
              $('#m_dictType_result').html(data.errorMessage).show();
          }
      }
  </script>