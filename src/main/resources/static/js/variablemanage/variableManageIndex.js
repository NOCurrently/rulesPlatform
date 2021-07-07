
$(function() {

    var path = $("#path").val();
    var station = $("#station").val();
    var tree = $('#stationTree');
    //初始化树
    function getTree(data) {
        $('#stationTree').treeview({
            levels : 1,
            emptyIcon : 'glyphicon',
            expandIcon : 'glyphicon glyphicon-chevron-right',
            collapseIcon : 'glyphicon glyphicon-chevron-down',
            data : data,
            onNodeExpanded : function(event, data) {
                var parentId='';
                if(data.templateCode!="undefined"){
                    parentId=data.id;
                }
                if (data.nodes.length<1) {
                    $.ajax({
                        type : "post",
                        url : path + "/backendStation/findCityNode?id=" + parentId,
                        format : "json",
                        success : function(datas) {
                            if (datas.success) {
                                tree.treeview("addNewNodes", [data.nodeId, { "nodes": datas.data }]);
                            }
                        }
                    });
                }
            }
            ,
            onNodeSelected : function(event, data) {
                if (data.type=="page") {
                    var url = path + "/contentManage/variableManageList?menuId=" + data.id;
                    if (url) {
                        $.get(url, function (result) {
                            $('#datas').empty();
                            $("#datas").html(result);
                        });
                    }
                }else{
                    $('#datas').empty();
                }

            }
        });
    }
    $.ajax({
        type : "post",
        url : path + "/backendStation/findRegion",
        format : "json",
        success : function(data) {
            if (data.success) {
                getTree(data.data);
                // var url = path+"/contentManage/contentManageList";
                // if (url) {
                //     $.get(url, function (result) {
                //         $("#datas").html(result);
                //     });
                // }
            } else {
                alert(data.errorMessage);
            }
        }
    });
});
