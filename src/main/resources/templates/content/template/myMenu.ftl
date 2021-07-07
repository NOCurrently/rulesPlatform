<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">维护数据</h4>
        </div>


        <div id="menu_result" class="alert alert-danger" style="display:none"></div>


        <form id="menu_EditForm" class="form-horizontal" method="post" action="${base}/backendContent/savaMymenu">
            <input type="hidden" name="menuId" value="${menuId!}">
            <input type="hidden" name="infoId" <#if info??>value="${info.id!}"</#if> >
            <input type="hidden" id="baseUrlId" value="${base}">
            <div class="modal-body">
                <div class="form-group">
                    <label for="menu_title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>名称</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="title" id="menu_title" placeholder="名称"
                               <#if info??>value='${info.title!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="menu_subTitle" class="col-sm-3 control-label">副标题</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="subTitle" id="menu_subTitle" placeholder="副标题"
                               <#if info??>value='${info.subTitle!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="targetBannerVersion" class="col-sm-3 control-label">目标版本</label>
                    <div class="col-sm-9">
                        <div id="targetBannerVersion">
                        </div>
                        <input type="hidden" id="targetBannerVersionDefVal" <#if info??>value="${versionParamArray!}"</#if>>
                    </div>
                </div>


                <div class="form-group">
                    <label for="targetBannerChannel" class="col-sm-3 control-label">终端设备</label>
                    <div class="col-sm-9">
                        <div id="targetBannerChannel">
                        </div>
                        <input type="hidden" id="targetBannerChannelDefVal" <#if info??>value='${info.channel!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="targetBannerChannel" class="col-sm-3 control-label">目标人群</label>
                    <div class="col-sm-9">
                        <div id="targetCrowdId">
                            <input type="hidden" id="targetCrowdHidden" <#if info??>value='${info.targetCrowdId!}'</#if>>
                            <select  style="width: 200px;float: left;" class="search-input am-form-field" id="targetCrowdId" name="targetCrowdId" onchange="getCrowdDetail('${base}',this.value,'menu_result')">
                                <option value="0">请选择</option>
                                <#if crowdList??>
                                    <#list crowdList as item>
                                    <option value="${item.id}">${item.id}:${item.crowdName}</option>
                                    </#list>
                                </#if>
                            </select>
                            <input type="text" style="width: 200px;float: right;" class="form-control" id="inputTargetCrowdId" onblur="initTargetCrowd(this.value, 'menu_result');" placeholder="请输入目标人群id">
                        </div>
                    </div>
                </div>
                <div id="crowList">

                </div>

                <div class="form-group">
                    <label for="menu_dataCoding" class="col-sm-3 control-label"><strong class="text-danger"></strong>数据编码</label>
                    <div class="col-sm-9">
                        <select id="menu_dataCoding" class="form-control" name="menu_dataCoding" >
                        </select>
                        <input type="hidden" id="dataCode"<#if voDto??>value='${voDto.code!}'</#if>>
                        <input type="hidden" id="dataCodeDefVal"<#if info??>value='${info.code!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="menu_priority" class="col-sm-3 control-label"><strong
                            class="text-danger"></strong>排序</label>
                    <div class="col-sm-9">
                        <input type="number" class="form-control" name="priority" id="menu_priority" placeholder="排序,输入0以上" min="1"
                        <#if info??>value="${info.priority!}"<#else>value="1"</#if>>
                    </div>
                </div>


                <div class="form-group">
                    <label for="uploadParam" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>上传图片</label>
                    <div class="col-sm-9">
                        <div id="displayUploadImgs">
                            <#if info??>
                                <#list info.imgDTOS as eachImg>
                                    <img src="${eachImg.img!}" name="displayUploadImg" style="width:40px;height: 40px" alt="${eachImg.alt!}" imgid="${eachImg.id!}"/>
                                </#list>
                            </#if>
                        </div>
                        <input type="button"  id="upload-param" value="添加"></input>
                    </div>
                </div>

                <div class="form-group">
                    <label for="menu_jumpType" class="col-sm-3 control-label"><strong class="text-danger">*</strong>跳转类型</label>
                    <div class="col-sm-9">
                        <select id="menu_jumpType" class="form-control" name="type" >
                        </select>
                        <input type="hidden" id="jumpTypeDefVal" <#if info??>value='${info.jumpType!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="menu_jumpUrl" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>跳转页面(地址)</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="jumpUrl" id="menu_jumpUrl" placeholder="跳转页面(地址)"
                               <#if info??>value='${info.jumpUrl!}'</#if>>
                        <span style="color:red;display:block;">注意:请务必输入准确无误的跳转地址</span>
                    </div>
                </div>


                <!-- 时间版本兼容字段-->
                <div class="form-group">
                    <label for="dateParam" class="col-sm-3 control-label"><strong
                            class="text-danger"></strong>时间设置</label>
                    <div class="col-sm-9">
                        <input type="button"  id="date-param" value="添加"></input>
                        <div style="display:none" id="timeParamJson"><#if timeParamJson??>${timeParamJson!''}</#if></div>
                    </div>
                </div>


                <div class="form-group">
                    <label for="param" class="col-sm-3 control-label">自定义参数</label>
                    <div class="col-sm-9">
                        <input type="button"  id="insert-param" value="添加"></input>
                        <div style="display:none" id="customParamJson"><#if info??>${info.customParam!''}</#if></div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="menu_remarks" class="col-sm-3 control-label">备注说明</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="remarks" id="menu_remarks" placeholder="请输入你的描述"
                               <#if info??>value="${info.remarks!}"</#if>>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="menu_saveBtn">保存</button>
            </div>
        </form>


    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript" src="${base}/static/js/content/template/myMenu.js"></script>
