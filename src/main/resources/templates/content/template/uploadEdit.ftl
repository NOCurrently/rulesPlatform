<link type="text/css" rel="stylesheet" href="${base}/static/js/date/skin/WdatePicker.css"/>
<style>
    .img-close {
        border: none;
        width: 30px;
        height: 20px;
        border-radius: 50%;
        background: url("${base}/static/img/close-icon.png") no-repeat center;
        background-size: 40px;
        right: 20;
        float: right;
        position: relative;
    }

    .img-moveUp {
        border: none;
        width: 30px;
        height: 20px;
        border-radius: 50%;
        background: url("${base}/static/img/moveUp.png") no-repeat center;
        background-size: 40px;
        right: 20;
        float: right;
        position: relative;
    }

    .img-moveDown {
        border: none;
        width: 30px;
        height: 20px;
        border-radius: 50%;
        background: url("${base}/static/img/moveDown.png") no-repeat center;
        background-size: 40px;
        right: 20;
        float: right;
        position: relative;
    }

</style>



<div class="modal-dialog">

    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="uploadTitleModalLabel">图片上传</h4>
        </div>

        <a type="button" class="btn btn-primary" id="insert_img">&nbsp;新增图片</a>
        <br>
        <div id="uploadImages">
            <div name="uploadImagesDiv">
                <input name="cfile" accept="image/*" style="display:none;" type="file">
                <img name="cEditImg" src="${base}/static/img/backImg.jpg" style="width:80px;height:80px">
                属性：<input type="text" name="cAlt" placeholder="alt">
                <button class="img-moveDown"></button>
                <button class="img-moveUp"></button>
                <button class="img-close"></button>
            </div>
        </div>

        <div class="modal-footer">
            <input type="hidden" id="contentTag" value="${tag!}"/>
            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            <button type="button" class="btn btn-primary" id="uploadSaveButton">保存</button>
        </div>

    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<!-- 图片上传通用div层 -->
<div style="display: none">
    <input id="uploadImageFile" type="file">
    <input id="multiUploadImageFile" type="file" multiple="multiple">
</div>

<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript">
    $(function () {
        var uploadParamPage = new Array();
        $("#displayUploadImgs").find("img").each(function (index, element) {
            var eachCom = $(element);
            var eachComImg = eachCom.attr("src");
            var id = eachCom.attr("imgid");
            var eachComAlt = eachCom.attr("alt");

            uploadParamPage[index] = {"id": id, "img": eachComImg, "alt": eachComAlt};
        });

        // 在上层页面上渲染数据
        if (uploadParamPage.length > 0) {
            var displayImgPageHtml = "";
            for (var i = 0; i < uploadParamPage.length; i++) {
                var eachObj = uploadParamPage[i];
                displayImgPageHtml += "<div name='uploadImagesDiv'>" +
                        "                    <input name='cfile' accept='image/*' style='display:none;' type='file'>" +
                        "                    <img name='cEditImg' src='" + eachObj.img + "' style='width:80px;height:80px' imgid='" + eachObj.id + "'>" +
                        "                    属性：<input type='text' name='cAlt' placeholder='alt' value='" + eachObj.alt + "'>" +
                        "                    <button class='img-moveDown'></button>" +
                        "                    <button class='img-moveUp'></button>" +
                        "                    <button class='img-close'></button>" +
                        "             </div>";
            }

            $("#uploadImages").html(displayImgPageHtml);

        }

        // 上传图片后的显示
        $("img[name=cEditImg]").bind("click", cEditImgClick);

        function cEditImgClick() {
            var thatObj = $(this);
            uploadImage(300, function (imgUrl) {
                $(thatObj).attr("src", imgUrl);
            });
        }

        // 删除图片
        $("button[class=img-close]").bind("click", imgCloseClick);

        function imgCloseClick() {
            var uploadParamLength = $("#uploadImages").find("div[name=uploadImagesDiv]").length;
            var contentTag = $("#contentTag").val();
            if (contentTag == "content") {
                $(this).parent().remove();
            } else if (uploadParamLength <= 1) {
                alert("图片要至少保留1个哦！");
            } else {
                $(this).parent().remove();
            }
        }

        // 图片上移
        $("button[class=img-moveUp]").bind("click", imgMoveUpClick);

        function imgMoveUpClick() {
            var uploadParamLength = $("#uploadImages").find("div[name=uploadImagesDiv]").length;

            if (uploadParamLength <= 1) {
                alert("图片上移至少要2个哦！");
            } else {
                var tempPrevObj = $(this).parent().prev();
                // 判断其上移的元素是否在存在
                if (tempPrevObj.length == 0) {
                    alert("图片已到达最上端哦！");
                    return;
                }
                var tempObj = $(this).parent();

                exchangeDivVal(tempPrevObj, tempObj);

            }
        }

        // 图片下移
        $("button[class=img-moveDown]").bind("click", imgMoveDownClick);

        function imgMoveDownClick() {
            var uploadParamLength = $("#uploadImages").find("div[name=uploadImagesDiv]").length;

            if (uploadParamLength <= 1) {
                alert("图片下移至少要2个哦！");
            } else {
                var tempNextObj = $(this).parent().next();

                // 判断其下移的元素是否在存在
                if (tempNextObj.length == 0) {
                    alert("图片已到达最底端哦！");
                    return;
                }

                var tempObj = $(this).parent();
                exchangeDivVal(tempObj, tempNextObj);
            }
        }

        /**
         * div中元素的数值交换
         * @param tempObj
         * @param tempNextObj
         */
        function exchangeDivVal(tempObj, tempNextObj) {

            var tempNextHtmlCIdValue = tempNextObj.find("img[name=cEditImg]").attr("imgid");
            var tempNextHtmlCSrcValue = tempNextObj.find("img[name=cEditImg]").attr("src");
            var tempNextHtmlCAltValue = tempNextObj.find("input[name=cAlt]").val();


            var tempHtmlCIdValue = tempObj.find("img[name=cEditImg]").attr("imgid");
            var tempHtmlCSrcValue = tempObj.find("img[name=cEditImg]").attr("src");
            var tempHtmlCAltValue = tempObj.find("input[name=cAlt]").val();

            tempNextObj.find("img[name=cEditImg]").attr("imgid", tempHtmlCIdValue);
            tempNextObj.find("img[name=cEditImg]").attr("src", tempHtmlCSrcValue);
            tempNextObj.find("input[name=cAlt]").val(tempHtmlCAltValue);

            tempObj.find("img[name=cEditImg]").attr("imgid", tempNextHtmlCIdValue);
            tempObj.find("img[name=cEditImg]").attr("src", tempNextHtmlCSrcValue);
            tempObj.find("input[name=cAlt]").val(tempNextHtmlCAltValue);
        }


        //上传图片
        function uploadImage(maxSize, callback) {//参数：图片最大限制(单位KB)、回调方法
            $("#uploadImageFile").off("change");//如不先解绑，将触发多次，jquery的bug
            $("#uploadImageFile").change(function () {
                var fileName = $(this).val();
                if (fileName) {
                    if (!/.(gif|jpg|jpeg|png|gif|jpg|png)$/.test(fileName)) {
                        alert("图片类型必须是.gif,jpeg,jpg,png中的一种");
                        return;
                    }
                    var fileData = this.files[0];
                    var size = fileData.size;
                    if (size > maxSize * 1024) {
                        alert("图片大小不得超过" + maxSize + "KB");
                        return;
                    }
                    var formData = new FormData();
                    formData.append('image', fileData);
                    $.ajax({
                        url: '${base}/backendImg/upload',
                        method: 'POST',
                        data: formData,
                        contentType: false,
                        processData: false,
                        cache: false,
                        success: function (data) {
                            if (data.code == 200) {
                                var img = data.data;
                                callback(img);
                            } else {
                                alert("上传失败:" + data.displayMessage);
                            }
                        },
                        error: function () {
                            alert("上传失败");
                        }
                    });
                }
            });
            $("#uploadImageFile").click();
        }

        // 新增事件
        $("#insert_img").click(function () {
            var thatObj = $(this);

            var insertHtml = "<div name='uploadImagesDiv'>" +
                    "                    <input name='cfile' accept='image/*' style='display:none;' type='file'>" +
                    "                    <img name='cEditImg' src='${base}/static/img/backImg.jpg' style='width:80px;height:80px'>" +
                    "                    属性：<input type='text' name='cAlt' placeholder='alt'>" +
                    "                    <button class='img-moveDown'></button>" +
                    "                    <button class='img-moveUp'></button>" +
                    "                    <button class='img-close'></button>" +
                    "             </div>";
            $("#uploadImages").append(insertHtml);
            $("#uploadImages").find("img[name=cEditImg]").last().bind("click", cEditImgClick);
            $("#uploadImages").find("button[class=img-close]").last().bind("click", imgCloseClick);
            $("#uploadImages").find("button[class=img-moveDown]").last().bind("click", imgMoveDownClick);
            $("#uploadImages").find("button[class=img-moveUp]").last().bind("click", imgMoveUpClick);
        });

        // 保存数据
        $("#uploadSaveButton").click(function () {

            var uploadParam = new Array();
            var uploadParamIndex = 0;
            $("#uploadImages").find("div[name=uploadImagesDiv]").each(function (index, element) {
                var eachCom = $(element);
                var eachComId = eachCom.find("img[name=cEditImg]").attr("imgid");
                var eachComImg = eachCom.find("img[name=cEditImg]").attr("src");
                var eachComAlt = eachCom.find("input[name=cAlt]").val();

                if ("" == eachComImg || "${base}/static/img/backImg.jpg" == eachComImg) {
                    return;
                }
                uploadParam[uploadParamIndex] = {"id": eachComId, "img": eachComImg, "alt": eachComAlt};
                uploadParamIndex++;
            });


            // 在上层页面上渲染数据
            var displayImgHtml = "";
            for (var i = 0; i < uploadParam.length; i++) {
                var eachObj = uploadParam[i];
                displayImgHtml += "<img src='" + eachObj.img + "' name='displayUploadImg' style='width:40px;height: 40px' alt='" + eachObj.alt + "' imgid='" + eachObj.id + "'/>";
            }

            $("#displayUploadImgs").html(displayImgHtml);


            $("#upload_data").modal('hide');

        });


    });
</script>