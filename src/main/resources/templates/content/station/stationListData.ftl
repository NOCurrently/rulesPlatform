<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap">ID</th>
        <th nowrap="nowrap">名称</th>
        <th nowrap="nowrap">状态</th>
        <th nowrap="nowrap" style="width: 16%;">操作</th>
    </tr>
    </thead>
    <tbody>
    <#if datas?? && datas.list??>
        <#list datas.list as info>
            <tr class="info_${info.id}">
                <td>${info.id}</td>
                <td>${info.title!}</td>
                
                <td>
                    <#if info.status?? && info.status == 0>关<#else>开</#if>
                </td>
                     <td>
                      <#if info.id?? && info.id == 1><#else>
                         <a class="am-btn am-btn-xs am-btn-primary edit btn-info" href="javascript:void(0)"
                            dataId="${info.id!}" id="dataEdit">编辑</a>
                         <a class="am-btn am-btn-xs am-btn-primary changeFlag btn-danger" href="javascript:void(0)"
                            dataId="${info.id!}" status="${info.status!}" id="dataChange">
                          <#if info.status?? && info.status == 0>开<#else>关</#if>
                         </a>
                      </#if>
                 </td>
            </tr>
        </#list>
   
    </tbody>
</table>
<input id="totalCount" value="${datas.total!}" type="hidden"/>
 </#if>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>