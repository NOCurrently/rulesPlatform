<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 5%;">选择</th>
        <th nowrap="nowrap" style="width: 5%;">ID</th>
        <th nowrap="nowrap">名称</th>
        <th nowrap="nowrap">版本</th>
        <th nowrap="nowrap">图片链接</th>
        <th nowrap="nowrap" style="width: 6%;">跳转类型</th>
        <th nowrap="nowrap">上线时间</th>
        <th nowrap="nowrap">下线时间</th>
        <th nowrap="nowrap" style="width: 6%;">时间状态</th>
        <th nowrap="nowrap">终端类型</th>
        <th nowrap="nowrap" style="width: 5%;">排序</th>
        <th nowrap="nowrap" style="width: 6%;">目标用户</th>
        <th nowrap="nowrap" style="width: 5%;">状态</th>
        <th nowrap="nowrap" style="width: 16%;">操作</th>
    </tr>
    </thead>
    <tbody>
    <#if datas?? && datas.list??>
        <#list datas.list as info>
            <tr class="info_${info.id}">
                <td><input id="${info.id}"  name="dept" type='checkbox'/></td>
                <td>${info.id!}</td>
                <td>${info.title!}</td>
                <td>
                    <#if info.versionList??>
                        <#list info.versionList as v>
                            ${v!}
                        </#list>
                    </#if>
                </td>
                <td>
                    <#if info.imgDTOS??>
                        <#list info.imgDTOS as i>
                            <img id="imgUrlClick${i_index}" src="${i.img}" height="50" width="50" alt="${i.alt}"/>
                        </#list>
                    </#if>
                </td>
                <td>${info.jumpType!}</td>
                <td>
                    <#if info.contentTimeDTO??>
                        ${(info.contentTimeDTO.beginTime?string("yyyy-MM-dd HH:mm:ss"))!}
                    </#if>
                </td>
                <td>
                    <#if info.contentTimeDTO??>
                        ${(info.contentTimeDTO.endTime?string("yyyy-MM-dd HH:mm:ss"))!}
                    </#if>
                </td>
                <td>
                    <#if info.timeStatus??>
                        <#if info.timeStatus == 0>未定时
                        <#elseif info.timeStatus == 1>未开始
                        <#elseif info.timeStatus == 2>进行中
                        <#elseif info.timeStatus == 3>已过期
                        </#if>
                    </#if>
                </td>
                <td>${info.channel!}</td>
                <td>${info.priority!}</td>
                <td><#if info.targetUser?? && info.targetUser != "">${info.targetUser!}<#else>所有</#if></td>

                <td><#if info.status?? && info.status == 1>开<#else>关</#if></td>
                     <td>
                         <a class="am-btn am-btn-xs am-btn-primary edit btn-info" href="javascript:void(0)" infoId="${info.id!}">编辑</a>
                         <a class="am-btn am-btn-xs am-btn-primary deleteFlag_banner btn-danger" href="javascript:void(0)"
                            roleId="${info.id!}">删除</a>
                         <a class="am-btn am-btn-xs am-btn-primary changeFlag_banner btn-danger" href="javascript:void(0)"
                            roleId="${info.id!}" bannerStatusFlag="${info.status!}"><#if info.status?? && info.status == 1>关<#else>开</#if>
                         </a>
                 </td>
            </tr>
        </#list>
    </#if>
    </tbody>
</table>
<input id="totalCount" value="${datas.total!}" type="hidden"/>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>