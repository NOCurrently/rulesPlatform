$(function () {
    var path = $("#path").val();
    //form表单参数
    let searchPara = $('#r_searchForm').serialize();
    $('#data-table').load(path + "/web/report/reportData?" + searchPara);
//    $("#clear-btn").click(function () {
//        $(".search-input").val("");
//        $(".search-input").focus();
//    });
    $("#search-buttonss").click(function () {
    	 //form表单参数
        let searchParas = $('#r_searchForm').serialize();
        $('#data-table').load(path + "/web/report/reportData?" + searchParas,$("#data-table"));
       
        
//        $.ajax({
//            type: "GET",
//            url: path + "/web/report/reportData?" + searchParas,
//            //async: false,//一条请求
//            error:function(data){
//                //alert('11');
//            },
//
//            success: function(data){
//                for (var i = 0; i < data.length; i++) {
//                      $("#"+id).append("<option value='"+data[i].value+"'>"+data[i].labelDefault+"</option>");
//                }
//            }
//        });
        
    })
});
