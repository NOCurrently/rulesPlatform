<link type="text/css" rel="stylesheet" href="${base}/static/js/date/skin/WdatePicker.css"/>

<div class="modal-dialog">

    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">日期参数</h4>
        </div>

        <div id="r_result_date" class="alert alert-danger" style="display:none"></div>


            <div class="form-group">
                <label for="beginDate" class="col-sm-3 control-label"><strong class="text-danger">*</strong>开始日期</label>
                <div class="col-sm-9">
                    <input type="text" autocomplete="off" class="form-control" name="beginDate" placeholder="开始日期" id="beginDate"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});">
            </div>

            <div class="form-group">
                <label for="endDate" class="col-sm-3 control-label">结束日期</label>
                <div class="col-sm-9">
                    <input type="text" autocomplete="off" class="form-control" name="endDate" placeholder="结束日期"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'beginDate\')}'});">
                </div>
            </div>

            <div class="form-group">
                <label for="week" class="col-sm-3 control-label">周设置</label>
                <div class="col-sm-9">
                    <div class="form-control" >
                            <input type="checkbox" name="weekSet" value="7">周日
                            <input type="checkbox" name="weekSet" value="1">周一
                            <input type="checkbox" name="weekSet" value="2">周二
                            <input type="checkbox" name="weekSet" value="3">周三
                            <input type="checkbox" name="weekSet" value="4">周四
                            <input type="checkbox" name="weekSet" value="5">周五
                            <input type="checkbox" name="weekSet" value="6">周六
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="beginTime" class="col-sm-3 control-label">开始时间</label>
                <div class="col-sm-9">
                    <input type="text" autocomplete="off" class="form-control" name="beginTime" placeholder="开始时间"
                           onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:true});">
                </div>
            </div>

            <div class="form-group">
                <label for="endTime" class="col-sm-3 control-label">结束时间</label>
                <div class="col-sm-9">
                    <input type="text" autocomplete="off" class="form-control" name="endTime" placeholder="结束时间"
                           onclick="WdatePicker({dateFmt:'HH:mm:ss',isShowClear:true});" >
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="saveDateParam">保存</button>
            </div>

    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {

        // 从编辑页面渲染数据
            var dateParamHiddenObj = $("#timeParamJson").text();
            var dateParamHiddenJsonObj = {};
            try{
                dateParamHiddenJsonObj = JSON.parse(dateParamHiddenObj);
            }catch (e) {
                console.log("78===="+e);
            }

            console.log("dateParamHiddenObj==="+dateParamHiddenObj+"|||"+dateParamHiddenJsonObj.beginTime);
            if(!isEmpty(dateParamHiddenJsonObj.beginTime)){
                $("input[name=beginDate]").val(dateParamHiddenJsonObj.beginTime);
            }
            if(!isEmpty(dateParamHiddenJsonObj.endTime)){
                $("input[name=endDate]").val(dateParamHiddenJsonObj.endTime);
            }
            if(!isEmpty(dateParamHiddenJsonObj.showTime) && "00:00:00" != dateParamHiddenJsonObj.showTime){
                $("input[name=beginTime]").val(dateParamHiddenJsonObj.showTime);
            }
            if(!isEmpty(dateParamHiddenJsonObj.closeTime) && "00:00:00" != dateParamHiddenJsonObj.closeTime){
                $("input[name=endTime]").val(dateParamHiddenJsonObj.closeTime);
            }

            if(!isEmpty(dateParamHiddenJsonObj.showWeek)){
                var showWeekArray = JSON.parse(dateParamHiddenJsonObj.showWeek);
                console.log("96====="+showWeekArray.length);
                for(var showWeekIndex = 0 ; showWeekIndex < showWeekArray.length ; showWeekIndex++){
                    var showWeekIndexVal = showWeekArray[showWeekIndex];
                    console.log("999==showWeekIndex="+showWeekIndex+",showWeekIndexVal="+showWeekIndexVal);
                    if("1"==showWeekIndexVal){
                        $("input[name=weekSet]").eq(showWeekIndex).attr("checked",true);
                    }
                }
            }



        $("input[name=beginTime]").bind("onblur",function (){
            var beginTime = $(this).val();
            var endTime = $("input[name=endTime]").val();
            if(!isEmpty(beginTime) && isEmpty(endTime)){
                $("input[name=endTime]").val("23:59:59");
            }
        });

        $("input[name=endTime]").bind("onblur",function (){
            var endTime = $(this).val();
            var beginTime = $("input[name=beginTime]").val();
            if(!isEmpty(endTime) && isEmpty(beginTime)){
                $("input[name=beginTime]").val("00:00:00");
            }
        });


        //提交数据
        $("#saveDateParam").click(function () {
          var beginDate = $("input[name=beginDate]").val();
          var endDate = $("input[name=endDate]").val();

            if(isEmpty(beginDate)){
                $('#r_result_date').html("开始日期不能为空！");
                $('#r_result_date').show();
                return ;
            }

            if(isEmpty(endDate)){
                $('#r_result_date').html("结束日期不能为空！");
                $('#r_result_date').show();
                return ;
            }
            if((Date.parse(beginDate) > Date.parse(endDate)) || (Date.parse(beginDate) == Date.parse(endDate))){
                $('#r_result_date').html("开始日期必须小于结束日期！");
                $('#r_result_date').show();
                return ;
            }
            var nowDate = new Date();
            if(Date.parse(endDate) < nowDate){
                $('#r_result_date').html("结束日期不得小于当前日期！");
                $('#r_result_date').show();
                return ;
            }


            var array = new Array();//设置接受数组
            //遍历获取勾选checkbox元素
            $("input[name=weekSet]").each(function (index,item){
                if($(this).is(":checked")){ //判断是否选中
                    array[index] = 1;
                }else{
                    array[index] = 0;
                }
            });
          var vals = "["+array.join(",")+"]";
          var week = vals;
          var beginTime = $("input[name=beginTime]").val();
          var endTime = $("input[name=endTime]").val();

          if((!isEmpty(beginTime) && isEmpty(endTime)) || (isEmpty(beginTime) && !isEmpty(endTime))){
              $('#r_result_date').html("开始时间与结束时间必须同时设置！");
              $('#r_result_date').show();
              return ;
          }

          if(!isEmpty(beginTime) && vals != "[0,0,0,0,0,0,0]"){
              $('#r_result_date').html("周与开始时间和结束时间不能都填！");
              $('#r_result_date').show();
              return ;
          }
          if(!isEmpty(beginTime)){
              if(!compareTime(beginTime,endTime)){
                  $('#r_result_date').html("开始时间必须小于结束时间！");
                  $('#r_result_date').show();
                  return ;
              }
          }
            
            var param = {
             beginTime:beginDate,
             endTime: endDate,
             showWeek:week,
             showTime:beginTime,
             closeTime: endTime
         };
 		$("#timeParamJson").text(JSON.stringify(param));
        $("#date_data").modal('hide');

        });

    });
    
    //判断时间大小
    function compareTime(beginTime,endTime) {
        var beginStr = beginTime;
        var endStr = endTime;
        var beginArr = beginStr.split(':');
        var beginHs = parseInt(beginArr[0] * 3600);
        var beginMs = parseInt(beginArr[1] * 60);
        var beginSs = parseInt(beginArr[2]);
        var beginSeconds = beginHs + beginMs + beginSs;
        var endArr = endStr.split(':');
        var endHs = parseInt(endArr[0] * 3600);
        var endMs = parseInt(endArr[1] * 60);
        var endSs = parseInt(endArr[2]);
        var endSeconds = endHs + endMs + endSs;
        if(endSeconds > beginSeconds){
            return true;
        }else{
            return false;
        }
    }

</script>