/**
 * Created by Administrator on 2018/7/29.
 */
$(function () {
    var path = $("#path").val();
    var option = $("#option").val();

    $(".sub-edit").on('click', function () {
        var logId = $("#logId").val();
        var type = $("#type").val();
        var userId = $("#userId").val();
        var userName = $("#userName").val();
        var ip = $("#ip").val();
        var objectType = $("#objectType").val();
        var objectId = $("#objectId").val();
        var objectContent = $("#objectContent").val();
        var createTime = $("#createTime").val();

        if (option == 'add') {
            href = path + "/sysLog/add?logId=" + logId + "&type=" + type + "&userId"+userId+ "&userName=" + userName + "&ip=" + ip +"&objectType"+ objectType + "&objectId"+ objectId + "&objectContent"+ objectContent + "&createTime"+ createTime;
        } else if (option == 'edit') {
        	href = path + "/sysLog/update?logId=" + logId + "&type=" + type + "&userId"+userId+ "&userName=" + userName + "&ip=" + ip +"&objectType"+ objectType + "&objectId"+ objectId + "&objectContent"+ objectContent + "&createTime"+ createTime;
        }

        console.log(option);
        $.ajax({
            type: "post",
            url: href,
            format: "json",
            success: function (data) {
                if ($.trim(data.code) == "200") {
                    alert(data.message);
                } else {
                    alert(data.message);
                }
                //$("#password").val("");
                //$("#verify").val("");
            }
        });

        return false;
    });
});