<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 5%;">名称</th>
        <th nowrap="nowrap" style="width: 4%;">类型</th>
        <th nowrap="nowrap" style="width: 10%;">编码</th>
        <th nowrap="nowrap" style="width: 10%;">备注</th>
        <th nowrap="nowrap" style="width: 14%;">操作</th>
    </tr>
    </thead>

    <tbody>
    <#if sysDictTypeList??>
        <#list sysDictTypeList.list as dictType>
            <tr class="dictType_${dictType.id}">
                <td>${dictType.name!}</td>
                <td>${dictType.type!}</td>
                <td>${dictType.code!}</td>
                <td>${dictType.remark!}</td>
                <td>
                    <a class="am-btn am-btn-xs am-btn-primary edit btn-info" href="javascript:void(0)" dictTypeId = "${dictType.id}">编辑</a>
                    <a class="am-btn am-btn-xs am-btn-primary delete btn-danger" href="javascript:void(0)" dictTypeId="${dictType.id}" onClick="delcfm('${base}/sysDictType/deleteSysDictType?id=${dictType.id}')">删除</a>
                  <a class="am-btn am-btn-xs am-btn-primary addvalue btn-info" href="javascript:void(0)" dictTypeId="${dictType.id}">添加数据字典值</a>
                    <a class="am-btn am-btn-xs am-btn-primary listvalue btn-info" href="javascript:void(0)" dictTypeId="${dictType.id}">查看值列表</a>
                </td>
            </tr>
        </#list>
    </#if>
    </tbody>
</table>
<input id="totalCount" value="${sysDictTypeList.total}" type="hidden"/>
