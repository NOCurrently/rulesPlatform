<link rel="stylesheet" type="text/css" href="${base}/static/css/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${base}/static/css/easyui/themes/icon.css">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">编辑类目</h4>
        </div>


        <div id="tagCategory_result" class="alert alert-danger" <#if !msg??>style="display:none"</#if>>
            <#if msg??>
                ${msg!''}
            </#if>
        </div>


        <form id="tagCategory_EditForm" class="form-horizontal">
            <div class="modal-body">
                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>类目名称</label>
                    <div class="col-sm-9">
                        <input type="hidden" name="categoryId" <#if tagCateDb??>value="${tagCateDb.id!''}"</#if>>
                        <input type="hidden" name="categoryUniqueCode" <#if tagCateDb??>value="${tagCateDb.uniqueCode!''}"</#if>>
                        <input type="text" class="form-control" name="categoryName" placeholder="类目名称" <#if tagCateDb??>value="${tagCateDb.categoryName!''}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="type" class="col-sm-3 control-label"><strong class="text-danger">*</strong>编码</label>
                    <div class="col-sm-9">
                        <input id="categoryCodeCustom" class="form-control" name="categoryCodeCustom" disabled="true" <#if tagCateDb??>value="${tagCateDb.categoryCode!''}"</#if>>
                    </div>
                </div>


                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">上级类目</label>
                    <div class="col-sm-9">
                        <input type="text" class="easyui-combotree" id="categoryParentId" name="categoryParentId" placeholder="上级类目" readonly>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">分类图标</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="catgoryImgUrl" placeholder="分类图标" <#if tagCateDb??>value="${tagCateDb.imgUrl!''}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>排序</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="categorySort" placeholder="排序" <#if tagCateDb??>value="${tagCateDb.sort!''}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">最大展示个数</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="categoryDisplayCount" placeholder="最大展示个数" <#if tagCateDb??>value="${tagCateDb.displayCount!''}"</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>状态</label>
                    <div class="col-sm-9">
                        <div class="controls">
                            <label class="radio">
                                <input class="radio" type="radio" name="categoryStatus" value="1"
                                    <#if !tagCateDb??> checked
                                    <#elseif tagCateDb?? &&  tagCateDb.status== 1>checked</#if>>开
                            </label>
                            <label class="radio">
                                <input class="radio" type="radio" name="categoryStatus" value="0"
                                    <#if !tagCateDb??> checked
                                    <#elseif tagCateDb?? &&  tagCateDb.status== 0>checked</#if>>关
                            </label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title" class="col-sm-3 control-label">对应标签</label>
                    <div class="col-sm-9">
                        <#if tagList??>
                                <table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact" id="checkTagTable">
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
                                            <td><input tagId="${info.id}"  name="tagPoolId" type='checkbox' <#if tagCateDb??>
                                                                                                                <#if tagCateDb.tagPoolIds?? >
                                                                                                                    <#list tagCateDb.tagPoolIds as eachId>
                                                                                                                        <#if eachId==info.id>
                                                                                                                              checked
                                                                                                                        </#if>
                                                                                                                    </#list>

                                                                                                                </#if>

                                                                                                             </#if>/>

                                            </td>
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
                <button type="button" class="btn btn-default" id="editCategoryQgtyInitDivCancel" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveCategoryCustom">保存</button>
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

        var categoryParentIdObj = $("#categoryParentId");

        categoryParentIdObj.combotree('loadData',${cateTreeData!});
        <#if tagCateDb.parentId??>
            categoryParentIdObj.combotree('setValue',${tagCateDb.parentId!});
        </#if>
        var categoryParentIdObjQgtyTree = categoryParentIdObj.combotree("tree");

        //提交数据
        $("#saveCategoryCustom").bind("click", function () {

            // 1.校验
            var isValiResult = saveCategoryCustom();
            if(!isValiResult)
                return;

            // 2.按钮置灰
            var thatButton = $(this);
            thatButton.attr('disabled', 'disabled');

            // 3.表单提交
            var menuId = $("#stationId").val();
            var id = $("input[name=categoryId]").val();
            var uniqueCode = $("input[name=categoryUniqueCode]").val();
            var tagName = $("input[name=categoryName]").val();
            var tagCodeCustom = $("#categoryCodeCustom").val();
            var categoryParentId = categoryParentIdObjQgtyTree.tree("getSelected").id;
            var catgoryImgUrl = $("input[name=catgoryImgUrl]").val();
            var categorySort = $("input[name=categorySort]").val();
            var categoryDisplayCount = $("input[name=categoryDisplayCount]").val();
            var categoryStatus = $("input[name=categoryStatus]:checked").val();
            var tagIds = getCheckedIds();


            var data = {
                "id":id,
                "menuId":menuId,
                "uniqueCode":uniqueCode,
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
                url: path+'/backendTag/editCustomTagCategoryQgty',
                data: JSON.stringify(data),
                method: 'POST',
                dataType: "json",
                contentType: 'application/json;charset=UTF-8',
                success: function (data) {
                    if(200 == data.code){
                        //关闭当前窗口
                        $("#editCategoryQgtyInitDivCancel").click();

                        initTreeGrid();

                        categoryParentIdObj.combotree('destroy');

                    }else{
                        // 允许页面数据重新编辑
                        thatButton.removeAttr('disabled');

                        // 显示之前的错误信息
                        $('#tagCategory_result').html(data.displayMessage).show();
                    }
                }
            });
        });


        /**
         * 校验表单
         */
        function saveCategoryCustom() {

            // 1.校验标签名称
            var tagName = $("input[name=categoryName]").val();
            if(isEmpty(tagName)){
                $('#tagCategory_result').html("类目名称不能为空！").show();
                return false;
            }
            if(tagName.length > 100){
                $('#tagCategory_result').html("类目名称长度不能超过100！").show();
                return false;
            }

            // 2.类目编码
            var tagCodeCustom = $("#categoryCodeCustom").val();
            if(isEmpty(tagCodeCustom)){
                $('#tagCategory_result').html("类目编码不能为空！").show();
                return false;
            }

            // 3.排序
            var priority = $("input[name=categorySort]").val();
            if(!isEmpty(priority)) {
                if (!(/^\+?[1-9][0-9]*$/).test(priority)) {
                    $('#tagCategory_result').html("排序必须为正整数！");
                    $('#tagCategory_result').show();
                    return false;
                }

                if(priority> 1000){
                    $('#tagCategory_result').html("排序最大为999！");
                    $('#tagCategory_result').show();
                    return false;
                }
            }else{
                $('#tagCategory_result').html("排序不能为空！").show();
                return false;
            }


            // 4.最大展示个数
            var min = $("input[name=categoryDisplayCount]").val();
            if(!isEmpty(min)) {
                if (!isPlusNumeric(min)) {
                    $('#tagCategory_result').html("展示个数必须为正数！");
                    $('#tagCategory_result').show();
                    return false;
                }

                if(min> 10000){
                    $('#tagCategory_result').html("展示个数最大为9999！");
                    $('#tagCategory_result').show();
                    return false;
                }
            }

            var categoryParentId ="";
            try{
                 categoryParentId = categoryParentIdObjQgtyTree.tree("getSelected").id;
            }catch(err){
                console.log(err);
             }
            if(isEmpty(categoryParentId)) {
                $('#tagCategory_result').html("上级类目选择异常，请刷新后重试！");
                $('#tagCategory_result').show();
                return false;
            }

            return true;

        }


        /**
         * 勾选对应标签
         */
        function getCheckedIds(){
           // 拼接ids
           var ids = new Array();
           var inputCheckIds = $("#checkTagTable").find("input[name=tagPoolId]:checked").each(function(i){
            ids.push($(this).attr("tagId"))
           });
           return ids;
        }


    });


</script>