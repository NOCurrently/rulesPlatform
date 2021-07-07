<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">维护数据</h4>
        </div>


        <div id="member_result" class="alert alert-danger" style="display:none"></div>

        <form id="member_EditForm" class="form-horizontal" method="post" action="${base}/backendContent">
            <input type="hidden" name="menuId" value="${menuId!}">
            <input type="hidden" name="infoId" <#if info??>value="${info.id!}"</#if> >
            <input type="hidden" id="baseUrlId" value="${base}">
            <div class="modal-body">

                <div class="form-group">
                    <label for="member_title" class="col-sm-3 control-label"><strong class="text-danger">*</strong>名称</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="title" id="member_title" placeholder="名称"
                               <#if info??>value='${info.title!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="member_subTitle" class="col-sm-3 control-label">副标题</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="subTitle" id="member_subTitle" placeholder="副标题"
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
                            <select  style="width: 200px;float: left;" class="search-input am-form-field" id="targetCrowdId" name="targetCrowdId" onchange="getCrowdDetail('${base}',this.value,'member_result')">
                                <option value="0">请选择</option>
                                <#if crowdList??>
                                <#list crowdList as item>
                                    <option value="${item.id}">${item.id}:${item.crowdName}</option>
                                </#list>
                                </#if>
                            </select>
                            <input type="text" style="width: 200px;float: right;" class="form-control" id="inputTargetCrowdId" onblur="initTargetCrowd(this.value, 'member_result');" placeholder="输入id查询目标人群">
                        </div>
                    </div>
                </div>
                <div id="crowList">

                </div>

                <div class="form-group">
                    <label for="member_priority" class="col-sm-3 control-label">排序</label>
                    <div class="col-sm-9">
                        <input type="number" class="form-control" name="priority" id="member_priority" placeholder="排序,输入0以上" min="1" maxlength="3" <#if info??>value="${info.priority!}"<#else>value="1"</#if>>
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
                    <label for="member_jumpType" class="col-sm-3 control-label"><strong class="text-danger">*</strong>跳转类型</label>
                    <div class="col-sm-9">
                        <select id="member_jumpType" class="form-control" name="type">
                        </select>
                        <input type="hidden" id="jumpTypeDefVal" <#if info??>value='${info.jumpType!}'</#if>>
                    </div>
                </div>

                <div class="form-group">
                    <label for="member_jumpUrl" class="col-sm-3 control-label"><strong
                            class="text-danger">*</strong>跳转页面(地址)</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="jumpUrl" id="member_jumpUrl" placeholder="跳转页面(地址)"
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
                    <label for="member_remarks" class="col-sm-3 control-label">备注说明</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="remarks" id="member_remarks" placeholder="请输入你的描述"
                               <#if info??>value="${info.remarks!}"</#if>>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="member_saveBtn">保存</button>
            </div>
        </form>


    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<script type="text/javascript" src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript" src="${base}/static/js/content/template/memberBanner.js"></script>
</script>