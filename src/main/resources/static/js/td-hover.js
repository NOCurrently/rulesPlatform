//描述鼠标悬停显示全部内容
$(function () {
    var tip_index = 0;
    $("td").on("mouseenter",function() {
        if (this.offsetWidth < this.scrollWidth) {
            var that = this;
            var text = $(this).text();
            tip_index = layer.tips(text, that,{
                tips: 1,
                time: 0,       //设置显示时间
                area: 'auto',maxWidth:500
            });
        }
    }).on("mouseleave",function(){
        layer.close(tip_index);
    });
})