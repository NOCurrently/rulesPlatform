<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 5%;">ID</th>
        <th nowrap="nowrap" style="width: 10%;">值类型</th>
        <th nowrap="nowrap" style="width: 25%;">位置</th>
        <th nowrap="nowrap" style="width: 20%;">变量</th>
        <th nowrap="nowrap" style="width: 15%;">创建时间</th>
        <th nowrap="nowrap" style="width: 5%;">状态</th>
        <th nowrap="nowrap" style="width: 16%;">操作</th>
    </tr>
    </thead>
    <tbody>
    <#if datas?? && datas.list??>
        <#list datas.list as info>
            <tr class="info_${info.id}">
                <td>${info.id!}</td>
                <td>
                    <#if info.contentType??>
                        <#if info.contentType == "constant">定值
                        <#elseif info.contentType == "range">区间范围值
                        <#else>${info.contentType!}
                        </#if>
                    </#if>
                </td>
                <td>${info.locationCode!}</td>
                <td>
                    <#if info.contentList??>
                        <#list info.contentList as c>
                            ${c!}</br>
                        </#list>
                    </#if>
                </td>
                <td>${(info.createTime?string("yyyy-MM-dd HH:mm:ss"))!}</td>

                <td>
                    <#if info.status?? && info.status == 1>开<#else>关</#if>
                </td>
                <td>
                    <a class="am-btn am-btn-xs am-btn-primary edit btn-info" href="javascript:void(0)"
                       contentId="${info.id!}">编辑</a>
                    <a class="am-btn am-btn-xs am-btn-primary delete_content btn-danger" href="javascript:void(0)"
                       contentId="${info.id!}" uniqueCode="${info.uniqueCode!}">删除</a>
                    <a class="am-btn am-btn-xs am-btn-primary changeContentStatus btn-danger" href="javascript:void(0)"
                       contentId="${info.id!}" contentStatus="${info.status!}" uniqueCode="${info.uniqueCode!}">
                          <#if info.status?? && info.status == 1>关<#else>开</#if>
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