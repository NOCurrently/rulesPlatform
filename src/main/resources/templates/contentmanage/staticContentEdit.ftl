<link type="text/css" rel="stylesheet" href="${base}/static/js/date/skin/WdatePicker.css"/>

<div class="modal-dialog">

    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">添加文案</h4>
        </div>


        <a type="button" class="btn btn-primary" id="insert_input">&nbsp;新增文案&nbsp;</a>

        <div id="r_result" class="alert alert-danger" style="display:none"></div>



        <form id="paramForm" class="form-horizontal" role="form" method="post" >
            <div>
                <table style="text-align:center;border-collapse:separate; border-spacing:0px 5px;" id="param_table">
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveContent">保存</button>
            </div>
        </form>

    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {
        // 从编辑页面渲染数据
        var contentString = $("#contentString").text();
        var contentList = [];
        try{
            if(contentString != null) {
                //contentList = contentString;
                contentList = contentString.split("\n");

            }else {
                $("#param_table").append(' <tr>'
                        +'<td style="width:95%"><input type="text" class="form-control" name="c" value="" placeholder="至少添加一条文案..."></td>'
                        +'<td style="width:5%"><a href="javascript:void(0)" onclick="javascript:$(this).parent().parent().remove();">删除</a></td>'
                        +'</tr>');
            }
        }catch (e) {
            console.log("47===="+e);
        }

        contentList.forEach(content=>{
            $("#param_table").append(' <tr>'
                    +'<td style="width:95%"><input type="text" class="form-control" name="c" value="'+content+'" placeholder="至少添加一条文案..."></td>'
                    +'<td style="width:5%"><a href="javascript:void(0)" onclick="javascript:$(this).parent().parent().remove();">删除</a></td>'
                    +'</tr>');
        });

        $("#insert_input").click(function () {
            $("#param_table").append(' <tr>'
                    +'<td style="width:95%"><input type="text" class="form-control" name="c" value="" placeholder="至少添加一条文案..."></td>'
                    +'<td style="width:5%"><a href="javascript:void(0)" onclick="javascript:$(this).parent().parent().remove();">删除</a></td>'
                    +'</tr>');
        });

        //提交数据
        $("#saveContent").click(function () {
            var $input = $("input[type='text'][type!='hidden'][name='c']");
            var content = [];
            var firstFlag = 0;
            var secondFlag = 0;
            var flag = 0;

            $.each($input, function (i, item) {
                var val = $(item).val();
                if(!isEmpty(val)){
                    secondFlag = 1;
                }
                if(isEmpty(val) && i == 0){
                    firstFlag = 1;
                }
                if((secondFlag == 1 && isEmpty(val)) || (firstFlag == 1 && !isEmpty(val))){
                    flag = 1;
                    return;
                }
                if(/[\'\"]/.test(val)){
                    flag = 2;
                    return;
                }
                if (val != "" && val != null && val != undefined) {
                    content[i] = val;
                    if(val.length > 225){
                        flag = 3;
                        return;
                    }
                    console.log("3333======"+i+":"+content[i]);
                }
            });
            if(flag == 1){
                $('#r_result').html("文案不能存在空数据！");
                $('#r_result').show();
                return;
            }else if(flag == 2){
                $('#r_result').html("文案中不能有单引号或双引号！");
                $('#r_result').show();
                return;
            }else if(flag == 3){
                $('#r_result').html("单条文案长度不能超过225！");
                $('#r_result').show();
                return;
            }
            if(content.length == 0){
                $("#contentString").empty();
                $('#r_result').html("请至少输入一条文案！");
                $('#r_result').show();
                return;
            }else if(content.join("\n").length > 1000){
                $('#r_result').html("文案总长度不能超过1000！");
                $('#r_result').show();
                return;
            }else{
                $("#contentString").text(content.join("\n"));
            }

            // 在上层页面上渲染数据
            var displayContentHtml = "";
            for(var i =0 ; i < content.length; i++){
                var eachObj = content[i];
                displayContentHtml += "<span class='content_span'>"+eachObj+"</span></br>";
            }

            $("#displayContent").html(displayContentHtml);


            $("#param_data").modal('hide');


        });

    });
</script>