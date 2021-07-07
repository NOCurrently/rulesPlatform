<div id="aaa" class="modal-dialog" style="width:100%;height:80%">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
            <h4 class="modal-title" id="myModalLabel">${productHotelInfoRespDto.name!}</h4>
        </div>
        <div id="m_auth_result" class="alert alert-danger" style="display:none"></div>
        <input type="hidden" id="path" value="${base}"/>
        <input type="hidden" id="detailId" value="${productHotelInfoRespDto.id!}"/>
        <div class="am-form-inline" id="search-box">
            <div class="am-form-inline">
                <span>广告位置:</span>
                <div class="am-form-group">
                    <select class="search-input data-am-selected" id="detailAdLocation" name="adLocation">
                        <option value=""> 选择广告位置</option>
                    </select>
                </div>
                <span>&nbsp;&nbsp;广告类型:</span>
                <div class="am-form-group">
                    <select class="search-input data-am-selected" id="detailAdType" name="adType">
                        <option value=""> 选择广告类型</option>
                    </select>
                </div>
                <span>&nbsp;&nbsp;使用状态:</span>
                <div class="am-form-group">
                    <select class="search-input data-am-selected" id="detailAdStatus" name="adStatus">
                        <option value=""> 选择使用状态</option>
                    </select>
                </div>
                <button class="am-btn am-btn-primary" id="search-button2">搜索</button>
                <button class="am-btn  am-btn-primary" id="clear-btn2">清空</button>
            </div>
        </div>
        <div id="sub-data-table">
        </div>

        <div id="viewcfmModel" style="display:none;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" onclick="subClose()"><span aria-hidden="true">×</span></button>
                    </div>
                    <img id="imgurlId" src="" height="400" width="590"/>
                </div>
            </div>
        </div>

        <div id="adInfoListPaging">
        </div>
    </div>
</div>

<script>

    function subClose() {
        $('#viewcfmModel').css('display','none');
    }
</script>
<script type="text/javascript" src="${base}/static/js/advertisement/edit-advertisement.js"></script>



