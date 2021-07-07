<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/easyui/themes/icon.css">
</head>
<body>


<!--页面隐藏数据部分-->
<input type="hidden" id="path" value="${base}"/>
<input type="hidden" id="stationId" value="${stationId}"/>


<!--页面表单处理结果-->
<div id="active_result_tagPool" class="alert alert-danger" style="display:none"></div>

<!--查询条件-->
<div class="am-form-inline" id="search-box_tagPool">
    <button class="am-btn  am-btn-primary" id="insert-button_category">新增类目</button>
    <button class="am-btn  am-btn-primary" id="insert-button_tag" style="display:none">新增标签</button>
</div>

<!-- 列表数据-->
<div id="data-table_tagPool">
</div>



<!-- 新增标签 -->
<div class="modal fade" id="editTagInitDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>

<!-- 新增类目 -->
<div class="modal fade" id="editCategoryInitDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>

<!-- 新增标签全国操作 -->
<div class="modal fade" id="editTagQgtyInitDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>

<!-- 新增类目全国操作 -->
<div class="modal fade" id="editCategoryQgtyInitDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>

<!-- 删除 -->
<div class="modal fade" id="delFmModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="menuIdDel">
                <input type="hidden" id="idStrDel">
                <p>您确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="dataId"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="delectData" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<!-- 引入的js文件-->
<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script src="${base}/static/js/date/WdatePicker.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/static/js/jquery.easyui.min.js"></script>
<script type="text/javascript">
    var path = $("#path").val();
    var  paramTagPool = $('#data-table_tagPool');
    function initTreeGrid() {

        var menuId = $("#stationId").val();


        paramTagPool.treegrid({
            //url: '${base}/backendTag/tagPoolTree?menuId=' + menuId,
            url: '${base}/backendTag/getRootCategory?menuId=' + menuId,
            iconCls: 'icon-save',
            idField: 'id',  //关键字段来标识树节点，不能重复
            treeField: 'name',  //树节点字段，也就是树节点的名称
            fitColumns: true,
            rownumbers: true,//显示一个行号列
            collapsible: true,//收起表格的内容
            width: 1000,
            loadMsg: '数据加载中...',
            animate: true,//在节点展开或折叠的时候是否显示动画效果
            lines: true,//显示treegrid行
            columns: [[
                {field: 'name', title: '类目/标签', width: 100, align: 'left'},
                {field: 'code', title: '编码', width: 100, align: 'center'},
                {
                    field: 'sort', title: '排序', width: 60, align: 'center', formatter:
                        function (value, row, index) {
                                return row.sort;
                        }
                },
                {
                    field: 'status', title: '状态', width: 100, align: 'center', formatter:
                        function (value, row, index) {
                            return row.status == 1 ? "开" : "关";
                        }
                },
                // {field:'firstChannel',title:'渠道',width:100,align:'center'},
                {
                    field: 'oper', title: '操作', width: 80, align: 'center', formatter:
                        function (value, row, index) {
                            return '<a href="javascript:void(0)" onclick=to_edit_item_tag(\"' + row.id + '\",\"' + row.nodeType + '\")>编辑</a>'
                                + '&nbsp;&nbsp; <a href="javascript:void(0)" onclick=remove_item_tag(\"' + row.id + '\",\"' + row.nodeType + '\")>删除</a>';
                        }
                }
            ]],
            onBeforeExpand:function(row){
                paramTagPool.treegrid('options').url = '${base}/backendTag/getCategory?menuId=' + menuId+'&parentId='+row.id;
            }
        });
    }

    initTreeGrid();

    $("#insert-button_tag").bind("click", function tagAdd(){
        // 1.需要根据menuId弹出不同的新建页面
        var menuId = $("#stationId").val();

        $('#editTagInitDiv').load(path + "/backendTag/editCustomTagInit?menuId="+menuId);
        $('#editTagInitDiv').modal({});

    });

    $("#insert-button_category").bind("click", function categoryAdd(){
        // 1.需要根据menuId弹出不同的新建页面
        var menuId = $("#stationId").val();

        $('#editCategoryInitDiv').load(path + "/backendTag/editCustomTagCategoryInit?menuId=" + menuId);
        $('#editCategoryInitDiv').modal({});

        $("#categoryParentIdAdd").combotree('destroy');

    });


    function to_edit_item_tag(id, type){
        // 1.需要根据menuId弹出不同的新建页面
        var menuId = $("#stationId").val();

        // 修改标签
      if(0 == type){
          var cityTagId = id.split("_")[0];
          $('#editTagQgtyInitDiv').load(path + "/backendTag/editCustomTagQgtyInit?menuId="+menuId+"&cityTagId="+cityTagId);
          $('#editTagQgtyInitDiv').modal({});
      }else if(1== type){
          var cityTagId = id.split("_")[0];
          $('#editCategoryQgtyInitDiv').load(path + "/backendTag/editCustomTagCategoryQgtyInit?menuId=" + menuId+"&cityTagId="+cityTagId);
          $('#editCategoryQgtyInitDiv').modal({});
          $("#categoryParentId").combotree('destroy');
      }
    }

    function remove_item_tag(id, type){
        // 1.需要根据menuId弹出不同的新建页面
        var menuId = $("#stationId").val();

        // 隐藏字段
        $("#idStrDel").val(id);
        $("#menuIdDel").val(menuId);

        $('#delFmModel').modal();
    }


    /**
     * 确认删除后
     */
    $("#delectData").click(function () {
        var idAndType = $("#idStrDel").val();
        var menuId = $("#menuIdDel").val();
        $.ajax({
            type: "post",
            url: path + "/backendTag/delTagAndCategory?idAndType=" + idAndType+"&menuId="+menuId,
            format: "json",
            success: function (data) {
                if(data.code=="200"){
                    //window.location.href = path + "/backendTemplate/list";

                    alert("操作成功！");
                    initTreeGrid();
                }else{
                    alert(data.displayMessage);
                }
            }
        });
    });



</script>
</body>
</html>