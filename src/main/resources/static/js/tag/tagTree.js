
$(function() {

	var path = $("#path").val();
	var tree = $('#tagTree');
	//初始化树
	function getTree(data) {
		$('#tagTree').treeview({
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
					var url = path+"/backendTag/tagPoolIndex?stationId=" + data.id;
					if (url) {
						$.get(url, function (result) {
							$('#tagRightDivdatas').empty();
							$("#tagRightDivdatas").html(result);
						});
					}
				}else{
					$('#tagRightDivdatas').empty();
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
