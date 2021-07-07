<link rel="stylesheet" type="text/css" href="${base}/static/css/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${base}/static/css/easyui/themes/icon.css">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">新增类目</h4>
        </div>


        <div id="tagCategoryAdd_result" class="alert alert-danger" <#if !msg??>style="display:none"</#if>>
            <#if msg??>
                ${msg!''}
            </#if>
        </div>


        <form id="tagCategory_EditForm" class="form-horizontal">
            <div class="modal-body">
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>类目名称</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="categoryNameAdd" placeholder="类目名称">
                    </div>
                </div>

                <div class="form-group">
                    <label for="type" class="col-sm-3 control-label"><strong class="text-danger">*</strong>编码</label>
                    <div class="col-sm-9">
                        <select id="categoryCodeCustomAdd" name="categoryCodeCustomAdd">
                        </select>
                    </div>
                </div>


                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>上级类目</label>
                    <div class="col-sm-9">
                        <input type="text" class="easyui-combotree" id="categoryParentIdAdd" name="categoryParentIdAdd" placeholder="上级类目">
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">分类图标</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="catgoryImgUrlAdd" placeholder="分类图标">
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>排序</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="categorySortAdd" placeholder="排序" value="1">
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">最大展示个数</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="categoryDisplayCountAdd" placeholder="最大展示个数">
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>状态</label>
                    <div class="col-sm-9">
                        <div class="controls">
                            <label class="radio">
                                <input class="radio" type="radio" name="categoryStatusAdd" value="1" checked>开
                            </label>
                            <label class="radio">
                                <input class="radio" type="radio" name="categoryStatusAdd" value="0">关
                            </label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">对应标签</label>
                    <div class="col-sm-9">
                        <#if tagList??>
                                <table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact" id="checkTagTableAdd">
                                    <thead>
                                    <tr>
                                        <th nowrap="nowrap">选择</th>
                                        <th >标签名称</th>
                                        <th >标签编码</th>
                                        <th style="display:none">标签来源分类</th>
                                        <th style="display:none">标签类型</th>
                                        <th >来源</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <#list tagList as info>
                                        <tr class="info_${info.id}">
                                            <td><input tagId="${info.id}"  name="tagPoolId" type='checkbox'/></td>
                                            <td>${info.tagName!}</td>
                                            <td>${info.tagCode!}</td>
                                            <td style="display:none">${info.tagcategory!}</td>
                                            <td style="display:none">${info.tagType!}</td>
                                            <td><#if info.syncFlag??>
                                                    <#if info.syncFlag == 1>同步
                                                    <#else>自建
                                                    </#if>
                                                 </#if>
                                              </td>
                                        </tr>
                                        </#list>
                                    </tbody>
                                </table>
                        </#if>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="saveCategoryCustomCancleAdd">取消</button>
                <button type="button" class="btn btn-primary" id="saveCategoryCustomAdd">保存</button>
            </div>
        </form>


    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/jquery-3.1.1.min.js"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/static/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {

        // 页面上内容初始化
        var path = $("#path").val();

        var tagCodeCustomDefVal = "";
        dictValueLoadSelectSort("categoryCodeCustomAdd", "tag_category_code", path,tagCodeCustomDefVal);


        var thatCategroyParentIdAdd = $("#categoryParentIdAdd");
        thatCategroyParentIdAdd.combotree("loadData",${cateTreeData!});
        thatCategroyParentIdAdd.combotree("setValue",0);
        var thatCategroyParentIdAddTree = $("#categoryParentIdAdd").combotree("tree");


        //提交数据
        $("#saveCategoryCustomAdd").bind("click", function () {

            // 1.校验
            var isValiResult = saveCategoryCustomAdd();
            if(!isValiResult)
                return;

            // 2.按钮置灰
            var thatButton = $(this);
            thatButton.attr('disabled', 'disabled');

            // 3.表单提交
            var tagName = $("input[name=categoryNameAdd]").val();
            var tagCodeCustom = $("#categoryCodeCustomAdd").find('option:selected').val();
            var categoryParentId =  thatCategroyParentIdAddTree.tree("getSelected").id;
            var catgoryImgUrl = $("input[name=catgoryImgUrlAdd]").val();
            var categorySort = $("input[name=categorySortAdd]").val();
            var categoryDisplayCount = $("input[name=categoryDisplayCountAdd]").val();
            var categoryStatus = $("input[name=categoryStatusAdd]:checked").val();
            var tagIds = getCheckedIdsAdd();
            var menuId = $("#stationId").val();


            var data = {
                "categoryName":tagName,
                "categoryCode":tagCodeCustom,
                "parentId":categoryParentId,
                "imgUrl":catgoryImgUrl,
                "sort":categorySort,
                "displayCount":categoryDisplayCount,
                "status":categoryStatus,
                "tagIds":tagIds,
                "menuId":menuId
            };
            $.ajax({
                url: path+'/backendTag/editCustomTagCategory',
                data: JSON.stringify(data),
                method: 'POST',
                dataType: "json",
                contentType: 'application/json;charset=UTF-8',
                success: function (data) {
                    if(200 == data.code){
                        //关闭当前窗口
                        $("#saveCategoryCustomCancleAdd").click();

                        initTreeGrid();

                        thatCategroyParentIdAdd.combotree('destroy');

                    }else{
                        // 允许页面数据重新编辑
                        thatButton.removeAttr('disabled');

                        // 显示之前的错误信息
                        $('#tagCategoryAdd_result').html(data.displayMessage).show();

                    }
                }
            });
        });


        /**
         * 校验表单
         */
        function saveCategoryCustomAdd() {

            // 1.校验标签名称
            var tagName = $("input[name=categoryNameAdd]").val();
            if(isEmpty(tagName)){
                $('#tagCategoryAdd_result').html("类目名称不能为空！").show();
                return false;
            }
            if(tagName.length > 100){
                $('#tagCategoryAdd_result').html("类目名称长度不能超过100！").show();
                return false;
            }

            // 2.类目编码
            var tagCodeCustom = $("#categoryCodeCustomAdd").find('option:selected').val();
            if(isEmpty(tagCodeCustom)){
                $('#tagCategoryAdd_result').html("类目编码不能为空！").show();
                return false;
            }

            // 3.排序
            var priority = $("input[name=categorySortAdd]").val();
            if(!isEmpty(priority)) {
                if (!(/^\+?[1-9][0-9]*$/).test(priority)) {
                    $('#tagCategoryAdd_result').html("排序必须为正整数！");
                    $('#tagCategoryAdd_result').show();
                    return false;
                }

                if(priority> 1000){
                    $('#tagCategoryAdd_result').html("排序最大为999！");
                    $('#tagCategoryAdd_result').show();
                    return false;
                }
            }else{
                $('#tagCategoryAdd_result').html("排序不能为空！").show();
                return false;
            }


            // 4.最大展示个数
            var min = $("input[name=categoryDisplayCountAdd]").val();
            if(!isEmpty(min)) {
                if (!isPlusNumeric(min)) {
                    $('#tagCategoryAdd_result').html("展示个数必须为正数！");
                    $('#tagCategoryAdd_result').show();
                    return false;
                }

                if(min> 10000){
                    $('#tagCategoryAdd_result').html("展示个数最大为9999！");
                    $('#tagCategoryAdd_result').show();
                    return false;
                }
            }
            var categoryParentId ="";
            try{
                categoryParentId = thatCategroyParentIdAddTree.tree("getSelected").id;
            }catch(err){
                console.log(err);
            }

            if(isEmpty(categoryParentId)) {
                    $('#tagCategoryAdd_result').html("上级类目选择异常，请刷新页面后重试！");
                    $('#tagCategoryAdd_result').show();
                    return false;
             }

            return true;

        }


        /**
         * 勾选对应标签
         */
        function getCheckedIdsAdd(){
           // 拼接ids
           var ids = new Array();
           var inputCheckIds = $("#checkTagTableAdd").find("input[name=tagPoolId]:checked").each(function(i){
            ids.push($(this).attr("tagId"))
           });
           return ids;
        }


    });


</script>