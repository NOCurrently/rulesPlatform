/**
 * Created by wanghaiyang on 2016/3/28.
 */
$(function () {
	$("#username").focus();
	//判断登陆窗口是否在子页面中
	if (top.location !== self.location) {
		top.location=self.location;	
	}
	/*if (window != top) {
		top.location.href = location.href;
	}*/
	
    var classNames = [
        'login-spring',
        'login-summer',
        'login-autumn',
        'login-winter'
    ];
    var nowDate = new Date();
    nowDate.setMonth(nowDate.getMonth() - 2);
    var quarter = ~~(nowDate.getMonth() / 3);
    document.body.className = classNames[quarter];
    var path = $("#path").val();

    $(".submit-button").click(function () {
        $(".error").empty();
        var username = $("#username").val();
        var password = $("#password").val();
        if (username == "") {
            alert("请输入用户名");
            $("#username").focus();
            return false;
        }
        if (password == "") {
            alert("请输入密码");
            $("#password").foucs();
            return false;
        }
        $.ajax({
            type: "post",
            url: path + "/web/userLogin?username=" + username + "&password=" + password,
            format: "json",
            success: function (data) {
                if ($.trim(data.code) == '0') {
                    window.location.href = path + '/web/index?username='+username;
                } else {
                    $(".error").html(data.errorMessage);
                }
            }
        });

        return false;
    });

    //回车绑定登陆按钮
    $(document).keydown(function (event) {
    	if (event.keyCode == 13) {
    	$("#loginBtn").click();
    	}
    });
});