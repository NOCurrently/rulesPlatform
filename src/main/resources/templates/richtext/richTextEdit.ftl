<style>
    .modal{
        z-index:30;
    }
    .modal-backdrop{
        z-index:20;
    }
    .col-sm-3{
        width: 18%;
    }

</style>
<div class="modal-dialog" style="margin-left:280px;">
    <div class="modal-content" style="width:150%;margin-right: -80px;" >
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">富文本编辑</h4>
        </div>
        <div id="rich_text_result"  class="alert alert-danger" style="display:none"></div>
        <form  id="richText_EditForm"  class="form-horizontal"  role="form" method="post" action="${base}/noticeConfig/editContent">
            <input type="hidden" name="menuId" value="${menuId!}">
            <input type="hidden" name="richTextId" <#if info??>value="${info.id!}"</#if> >
            <input type="hidden" name="uniqueCode" <#if info??>value="${info.uniqueCode!}"</#if> >
            <div class="modal-body">

                <div class="form-group">
                    <label for="targetRichTextChannel" class="col-sm-3 control-label"><strong class="text-danger">*</strong>一级渠道</label>
                    <div class="col-sm-9">
                        <div id="targetRichTextChannel">
                        </div>
                        <input type="hidden" id="targetRichTextChannelDefVal" <#if info??>value='${info.firstChannel!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="richTextLocation" class="col-sm-3 control-label"><strong class="text-danger">*</strong>位置</label>
                    <div class="col-sm-9">
                        <select id="richTextLocation" class="form-control" name="richTextLocation">
                        </select>
                        <input type="hidden" id="richTextLocationDefVal" <#if info??>value='${info.code!}'</#if>>
                    </div>
                </div>


			 <div class="form-group">
                 <label for="editor" class="col-sm-3 control-label"><strong class="text-danger">*</strong>内容描述</label>
                 <div class="col-sm-9">
                     <script id="editor" type="text/plain" style="width:100%;height:240px;">${(info.content)!}</script>
                     <#--<span id="contentHidden" style="display:none">${(info.content)!}</span>-->
                 </div>
             </div>


             <div class="form-group">
                     <label for="title" class="col-sm-3 control-label">标题</label>
                     <div class="col-sm-9">
                         <input type="text" class="form-control" name="title" id="title" placeholder="最多50个字符，不支持特殊字符"
                           <#if info??>value='${info.title!}'</#if>>
                     </div>
             </div>


                <div class="form-group">
                    <label for="startTime" class="col-sm-3 control-label">开始时间</label>
                    <div class="col-sm-9">
                        <input type="text" id="startTime" autocomplete="off" class="form-control" name="startTime" placeholder="开始时间"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"
                               <#if info??  && info.startTime??>value='${info.startTime?string("yyyy-MM-dd HH:mm:ss")}'</#if>>
                    </div>
                </div>
                <div class="form-group">
                    <label for="endTime" class="col-sm-3 control-label">结束时间</label>
                    <div class="col-sm-9">
                        <input id="endTime" autocomplete="off" name="endTime" placeholder="结束时间" class="form-control" type="text"
                               onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')}'})"
                               <#if info??  && info.endTime??>value='${info.endTime?string("yyyy-MM-dd HH:mm:ss")}'</#if>>
                    </div>
                </div>


                <#--<div class="form-group">
                    <label for="inputPassword3" class="col-sm-3 control-label"><strong class="text-danger">*</strong>状态</label>
                    <div class="col-sm-9">
                        <div class="controls">
                            <label class="radio">
                                <input id="status1" class="radio" type="radio" name="status"  value="0" <#if !contentResponse??> checked <#elseif contentResponse.status?? &&  contentResponse.status== 0>checked</#if>>启用
                            </label>
                            <label class="radio">
                                <input id="status2" class="radio" type="radio" name="status" value="1" <#if contentResponse?? && contentResponse.status == 1>checked</#if>>关闭
                            </label>
                        </div>
                    </div>
                </div>-->

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="richText_saveBtn">保存</button>
            </div>
        </form>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
<script type="text/javascript" src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/static/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/static/ueditor/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${base}/static/ueditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript">
    var ue = UE.getEditor('editor',{autoFloatEnabled:false});
    $(function () {
        // 初始化编辑器
        //var contentView = $("#contentHidden").html();
        ue.ready(function() {
           // ue.setContent("");
            //异步回调 重新渲染
           // ue.execCommand('insertHtml', contentView);
        });

        // 页面上内容初始化
        var path = $("#path").val();

        // 终端
        var targetRichTextChannelDefVal = $("#targetRichTextChannelDefVal").val();
        dictValueLoadOptionaAll("targetRichTextChannel", "target_channel", "targetRichTextChannel", path, targetRichTextChannelDefVal);

        // 位置
        var richTextLocationDefVal = $("#richTextLocationDefVal").val();
        dictValueLoadSelectSort("richTextLocation", "richtext_location", path, richTextLocationDefVal, "选择位置");


        //提交数据
        $("#richText_saveBtn").bind("click", function () {

            // 1.校验
            var isValiResult = validateRichText();
            if (!isValiResult) {
                return;
            }


            // 2.按钮置灰
            var thatButton = $(this);
            thatButton.attr('disabled', 'disabled');

            // 3.表单提交
            var richTextId = $("#richText_EditForm").find("input[name=richTextId]").val();
            var menuId = $("#richText_EditForm").find("input[name=menuId]").val();
            var uniqueCode = $("#richText_EditForm").find("input[name=uniqueCode]").val();
            var code = $("#richTextLocation").find('option:selected').val();
            var targetRichTextChannel = getCheckboxValOrAllVal("targetRichTextChannel");
            var firstChannel = targetRichTextChannel.join(",");

            var content = UE.getEditor('editor').getContent();

            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            var title = $("#title").val();

            var data = {
                "id": richTextId,
                "menuId": menuId,
                "uniqueCode": uniqueCode,
                "code": code,
                "content": content,
                "startTime": startTime,
                "endTime": endTime,
                "firstChannel": firstChannel,
                "title": title
            };
            $.ajax({
                url: path + '/backendRichText/editRichText',
                data: JSON.stringify(data),
                method: 'POST',
                dataType: "json",
                contentType: 'application/json;charset=UTF-8',
                success: function (data) {
                    if (200 == data.code) {
                        //关闭当前窗口
                        $("#richTextEditModel").modal('hide');
                        // 需要刷新下页面
                        var curPage = $("#pageInput").val();
                        if (!curPage) {
                            curPage = 1;
                        }
                        //pageSize标签存在于page.js中
                        var pageSize = $("#selectPageForm").val();
                        if (!pageSize) {
                            pageSize = 15;
                        }
                        richTextListPaging = new PageView({
                            pageContainer: $("#page-table"),
                            pageListContainer: $("#data-table"),
                            pageViewName: 'richTextListPaging',
                            url: path + "/backendRichText/richTextList",
                            curPageName: 'currentPage',
                            curPage: curPage,
                            pageSize: pageSize,
                            urlRequestData: {
                                "menuId": menuId,
                            }
                        });

                    } else {
                        // 允许页面数据重新编辑
                        thatButton.removeAttr('disabled');

                        // 显示之前的错误信息
                        $('#rich_text_result').html(data.errorMessage);
                        $('#rich_text_result').show();
                    }
                }
            });
        });

        function validateRichText(){
            var startTime = $("#startTime").val();
            var endTime = $("#endTime").val();
            if((!isEmpty(startTime) && isEmpty(endTime)) || (isEmpty(startTime) && !isEmpty(endTime))){
                $('#rich_text_result').html("开始时间与结束时间必须同时设置！");
                $('#rich_text_result').show();
                return false;
            }
            if(!isEmpty(startTime) && !isEmpty(endTime)) {
                if ((Date.parse(startTime) > Date.parse(endTime)) || (Date.parse(startTime) == Date.parse(endTime))) {
                    $('#rich_text_result').html("开始时间必须小于结束时间！");
                    $('#rich_text_result').show();
                    return false;
                }
                var nowDate = new Date();
                if(Date.parse(endTime) < nowDate){
                    $('#rich_text_result').html("结束时间不得小于当前时间！");
                    $('#rich_text_result').show();
                    return ;
                }
            }
            return true;

        }

        /**
         * 获取checkbox中选中的值或者全部值
         */
        function getCheckboxValOrAllVal(inputName) {
            var obj = $("#" + inputName).find("input[type=checkbox][name=" + inputName + "]");
            var check_val = [];
            for (var k = 0; k < obj.length; k++) {  // 为空的话,即为选中全部
                if (obj[k].checked)
                    check_val.push(obj[k].value);
            }

            // 为空的话,即为选中全部
            if (0 == check_val.length) {
                for (var ki = 0; ki < obj.length; ki++) {
                    check_val.push(obj[ki].value);
                }
            }
            return check_val;
        }
    });



    // 编辑器功能定义
    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

/*    function getLocalData () {
        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('editor').execCommand( "clearlocaldata" );
        alert("已清空草稿箱")
    }*/
</script>