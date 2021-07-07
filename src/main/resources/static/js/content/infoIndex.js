$(function() {
	var level = 1;//全局变量的层级

	var path = $("#path").val();
	var station = $("#station").val();
	var tree = $('#stationTree');
	function getLevels(node){
		level = 1;
		getLevel(node);
	}
	function getLevel(node) {
		
		if (node.nodeId == 0) {
			return;
		} else {
			level++;
			var pnode = tree.treeview('getParent', node);//此方法是获取父节点
			if ('length' in pnode) {//如果修改节点之后，就会出现levela多加了一个的情况，因此减1
				level--;
				return;
			}
			getLevel(pnode);
		}
}
	//初始化树
	function getTree(data) {
		$('#stationTree').treeview({
			levels : 1,
			emptyIcon : 'glyphicon',
			expandIcon : 'glyphicon glyphicon-chevron-right',
			collapseIcon : 'glyphicon glyphicon-chevron-down',
			data : data,
			onNodeExpanded : function(event, data) {
				getLevels(data);
				var parentId='';
				if(data.templateCode!="undefined"){
					parentId=data.id;
				}
				if (data.nodes.length<1) {
					$.ajax({
						type : "post",
						url : path + "/backendMenu/findTreeNode?parentMenuId=" + parentId+"&level="+level,
						format : "json",
						success : function(datas) {
							if (datas.success) {
								tree.treeview("addNewNodes", [data.nodeId, { "nodes": datas.data }]);
							} 
						}
					});
				}	
			},
			onNodeSelected : function(event, data) {
				 if (data.type=="tag") {
					 var url = path+"/backendContent/infoList?menuId=" + data.id;
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
			} else {
				alert(data.errorMessage);
			}
		}
	});
});
