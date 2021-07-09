    <div class="modal-dialog">
        <div class="modal-content">

        <table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
            <thead>
            <tr>
                <th nowrap="nowrap" style="width: 5%;">值</th>
                <th nowrap="nowrap" style="width: 5%;">默认显示值</th>
                <th nowrap="nowrap" style="width: 10%;">排序</th>
                <th nowrap="nowrap" style="width: 5%;">备注</th>
                <th nowrap="nowrap" style="width: 5%;">操作</th>
            </tr>
            </thead>

            <tbody>
    <#list sysDictValueList as dictValue>
    <tr class="dictValue_${dictValue.id}">
        <td>${dictValue.value!}</td>
        <td>${dictValue.labelDefault!}</td>
        <td>${dictValue.sort!}</td>
        <td>${dictValue.remark!}</td>
        <td>
            <a class="am-btn am-btn-xs am-btn-primary value_edit btn-info" href="javascript:void(0)" dictValueId = "${dictValue.id}">编辑</a>
        <!--     <a class="am-btn am-btn-xs am-btn-primary value_delete btn-danger" href="javascript:void(0)" dictValueId="${dictValue.id}" onClick="delvaluecfm('${base}/sysDictValue/deleteSysDictValue?id=${dictValue.id}')">删除</a>
    -->     </td>
    </tr>
    </#list>
            </tbody>
        </table>
    </div>
        </div>
</div>