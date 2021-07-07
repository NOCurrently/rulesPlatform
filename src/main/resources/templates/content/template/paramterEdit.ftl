<link type="text/css" rel="stylesheet" href="${base}/static/js/date/skin/WdatePicker.css"/>

<div class="modal-dialog">

    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">自定义参数</h4>
        </div>


        <a type="button" class="btn btn-primary" id="insert_input">&nbsp;新增键值对&nbsp;</a>
        
        <div id="r_result" class="alert alert-danger" style="display:none"></div>



        <form id="paramForm" class="form-horizontal" role="form" method="post" >
           <div>
                   <table style="text-align:center;border-collapse:separate; border-spacing:0px 5px;" id="param_table">
                    </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveParam">保存</button>
            </div>
        </form>

    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {
        // 从编辑页面渲染数据
        var customParamHiddenObj = $("#customParamJson").text();
        console.log("42===="+customParamHiddenObj);
        var customParamHiddenJsonObj = {};
        try{
            if(!isEmpty(customParamHiddenObj)) {
                console.log("43===="+customParamHiddenObj);
                customParamHiddenJsonObj = JSON.parse(customParamHiddenObj);
            }else {
                $("#param_table").append(' <tr>'
                    +'<td style="width:40%"><input type="text" class="form-control" name="a" value="" placeholder="key值"></td>'
                    +'<td>=</td>'
                    +'<td style="width:40%"><input type="text" class="form-control" name="a" value="" placeholder="value值"></td>'
                    +'<td style="width:40%"><a href="javascript:void(0)" onclick="javascript:$(this).parent().parent().remove();">删除</a></td>'
                    +'</tr>');
            }
        }catch (e) {
            console.log("47===="+e);
        }

        for (var key in customParamHiddenJsonObj) {
            console.log(key);     //获取key值
            console.log(customParamHiddenJsonObj[key]); //获取对应的value值
            $("#param_table").append(' <tr>'
                +'<td style="width:40%"><input type="text" class="form-control" name="a" value="'+key+'" placeholder="key值"></td>'
                +'<td>=</td>'
                +'<td style="width:40%"><input type="text" class="form-control" name="a" value="'+customParamHiddenJsonObj[key]+'" placeholder="value值"></td>'
                +'<td style="width:40%"><a href="javascript:void(0)" onclick="javascript:$(this).parent().parent().remove();">删除</a></td>'
                +'</tr>');
        }



    $("#insert_input").click(function () {
       $("#param_table").append(' <tr>'
            +'<td style="width:40%"><input type="text" class="form-control" name="a" value="" placeholder="key值"></td>'
            +'<td>=</td>'
            +'<td style="width:40%"><input type="text" class="form-control" name="a" value="" placeholder="value值"></td>'
           +'<td style="width:40%"><a href="javascript:void(0)" onclick="javascript:$(this).parent().parent().remove();">删除</a></td>'
        +'</tr>');
    });




        //提交数据
        $("#saveParam").click(function () {
         var $input = $("input[type='text'][type!='hidden'][name='a']");
         var param = {};
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
            console.log("81====i="+i+":"+val);
            if (val != "" || val != null || val != undefined) {
                if(i%2==0){
                    var paramVal = $(item).parent().next().next().find("input[name=a]").val();
                    param[val] = paramVal;

                    console.log("86=-======"+val+":"+paramVal);
                }
               
            } 
         });
         if(flag == 1){
             $('#r_result').html("自定义参数不能为空！");
             $('#r_result').show();
             return;
         }else if(flag == 2){
             $('#r_result').html("自定义参数不能有单引号或双引号！");
             $('#r_result').show();
             return;
         }
         if(JSON.stringify(param) == "{}" || JSON.stringify(param) == "{\"\":\"\"}"){
             $("#customParamJson").empty();
         }else{
             $("#customParamJson").text(JSON.stringify(param));
         }

         $("#param_data").modal('hide');
            
            
        });

    });
</script>