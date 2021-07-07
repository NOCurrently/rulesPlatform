<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 5%;">ID</th>
        <th nowrap="nowrap" style="width: 10%;">终端类型</th>
        <th nowrap="nowrap" style="width: 15%;">位置</th>
        <th nowrap="nowrap">内容描述</th>
        <th nowrap="nowrap" style="width: 10%;">开始时间</th>
        <th nowrap="nowrap" style="width: 10%;">结束时间</th>
        <th nowrap="nowrap" style="width: 10%;">创建时间</th>
        <th nowrap="nowrap" style="width: 5%;">状态</th>
        <th nowrap="nowrap" style="width: 16%;">操作</th>
    </tr>
    </thead>
    <tbody>
    <#if datas?? && datas.list??>
        <#list datas.list as info>
            <tr class="info_${info.id}">
                <td>${info.id!}</td>
                <td>${info.firstChannel!}</td>
                <td>${info.code!}</td>
                <td>${info.content!}</td>
                <td>${(info.startTime?string("yyyy-MM-dd HH:mm:ss"))!}</td>
                <td>${(info.endTime?string("yyyy-MM-dd HH:mm:ss"))!}</td>
                <td>${(info.createTime?string("yyyy-MM-dd HH:mm:ss"))!}</td>
                <td>
                    <#if info.status?? && info.status == 1>开<#else>关</#if>
                </td>
                <td>
                    <a class="am-btn am-btn-xs am-btn-primary edit btn-info" href="javascript:void(0)"
                       richTextId="${info.id!}" >编辑</a>
                    <a class="am-btn am-btn-xs am-btn-primary deleteRichText btn-danger" href="javascript:void(0)"
                       richTextId="${info.id!}" uniqueCode="${info.uniqueCode!}">删除</a>
                    <a class="am-btn am-btn-xs am-btn-primary changeRichTextStatus btn-danger" href="javascript:void(0)"
                       richTextId="${info.id!}" richTextStatus="${info.status!}" uniqueCode="${info.uniqueCode!}">
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
