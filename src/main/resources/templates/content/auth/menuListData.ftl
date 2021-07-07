<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap">序号</th>
        <th nowrap="nowrap">名称</th>
        <th nowrap="nowrap">编码</th>
        <th nowrap="nowrap">类型</th>
        <th nowrap="nowrap">模板</th>
        <th nowrap="nowrap">状态</th>
        <th nowrap="nowrap" style="width: 16%;">操作</th>
    </tr>
    </thead>
    <tbody>
    <#if datas?? && datas.list??>
        <#list datas.list as info>
            <tr class="info_${info.id}">
                <td>${info_index+1}</td>
                <td>${info.title!}</td>
                <td>${info.code!}</td>
                <td>${info.typeName!}</td>
                <td>${info.templateName!}</td>
                <td>
                    <#if info.status?? && info.status == 0>关<#else>开</#if>
                </td>
                     <td>
                         <a class="am-btn am-btn-xs am-btn-primary edit btn-info" href="javascript:void(0)"
                            dataId="${info.id!}" id="dataEdit">编辑</a>
                            <a class="am-btn am-btn-xs am-btn-primary deleteFlag btn-danger" href="javascript:void(0)"
                            dataId="${info.id!}" id="dataDelete">删除</a>
                         <a class="am-btn am-btn-xs am-btn-primary changeFlag btn-danger" href="javascript:void(0)"
                            dataId="${info.id!}" status="${info.status!}" id="dataChange">
                          <#if info.status?? && info.status == 0>开<#else>关</#if>
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