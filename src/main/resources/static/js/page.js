/**
 * 分页类
 * @param options   初始化配置参数
 * @constructor
 */
var PageView = function (options) {
    /**
     *  分页的一些初始化参数默认值
     * @type {{pageSize: number, pageStartMax: number, pageContainer: null, pageListContainer: null, pageViewName: null, url: null, urlRequestData: {}, skin: string, curPage: number, totalRecordNumber: null}}
     */
    var pageModel = {
        /*选填*/
        pageSize: 10,//每页显示的最大条目数
        pageStartMax: 5,//页数超过该页数进入省略页数显示状态
        curPageName: "curPage", //当前页参数的名字
        pageSizeName: "pageSize", //页面大小参数的名字
        loading: true, //是否显示loading画面
        callback: null, //获取页面后回调函数
        /*必填*/
        pageContainer: null,//分页的容器
        pageListContainer: null,//列表的容器
        pageViewName: null,//分页对象名字
        url: null,//获取分页数据远程url
        urlRequestData: {},//获取分页数据远程url所需的参数当前页除外
        skin: 'snPages',//分页样式皮肤名称
        /*必不填*/
        curPage: 1,//当前页
        totalRecordNumber: null//记录总条数，一定不需要填写
    };
         //TODO
    //分页的初始化的参数值与默认值得融合
    if (arguments.length > 0 && typeof(arguments[0]) == 'object') {
        $.extend(pageModel, options);
    }


    /**
     *    分页渲染函数，私有函数
     * @param totalRecordNumber 总页数
     * @param pageSize      每页大小
     * @param curPageStr    要跳入的页
     * @returns {Array}
     * @private
     */
    function _renderPager(totalRecordNumber, pageSize, curPageStr) {
        if (totalRecordNumber > 0) {
            var curPage = parseInt(curPageStr);
            /**计算总的页数*/
            var maxpage = Math.ceil(totalRecordNumber / pageSize);
            /**显示5个固定页码**/
            var pageCodeNum = pageModel.pageStartMax;
            /**初始化显示第一个页码是1**/
            var blockStartNum = 2;
            /**初始化显示的最后一个页码是5**/
            var blockEndNum = pageModel.pageStartMax - 1;

            var pageViewName = pageModel.pageViewName;

            //构造中间显示区段
            var i = 0;
            if ((curPage >= (pageCodeNum - 1)) && (maxpage > pageCodeNum)) {
                var blockStart = (3 - 1) * i + 3 - 1;
                var blockEnd = (3 - 1) * (i + 1) + 3 - 1;
                var flag = false;
                while (flag != true) {
                    blockStart++;//3,4
                    blockEnd++;  //5,6
                    if ((curPage == (blockStart + 1)) || (blockEnd == (maxpage - 1))) {
                        flag = true;//找到了要显示的部分
                        blockStartNum = blockStart;
                        blockEndNum = blockEnd;
                    }
                    i++;
                }
            }else if( maxpage < pageCodeNum){
                blockStartNum = 2;
                blockEndNum = maxpage -1;
            }

            //开始构造分页显示内容
            var pageHtml = [];
            //当前页为第一页不可向上翻页（上一页）
            if (curPage == 1) {
                pageHtml.push('<div class="pages-wraper"><ul class="pagination am-pagination am-pagination-default"><li class="disabled am-disabled"><a class="prev" href="javascript:void(0);">&laquo;</a></li>');
            } else {
                pageHtml.push('<div class="pages-wraper"><ul class="pagination am-pagination am-pagination-default"><li><a class="prev" href="javascript:' + pageViewName + '.goPage(' + (curPage - 1) + ');">&laquo;</a></li>');
            }

            //第一页显示
            if (maxpage >= 1) {
                var firstPageHtml = '<li ';
                if (curPage == 1) {
                    firstPageHtml += ' class="active am-active" ';//@1
                }
                firstPageHtml += '><a href="javascript:' + pageViewName + '.goPage(1);">1</a></li>';
                pageHtml.push(firstPageHtml);
            }

            //前面点的显示
            if (blockStartNum > 2) {
                pageHtml.push('<li class="disabled am-disabled"><a href="javascript:void(0);">...</a></li>');
            }

            //除第一页和最后一页的绘制
            var blockIndex = blockStartNum;
            while (blockIndex <= blockEndNum) {
                var buttonHtml = "<li ";
                if (blockIndex == curPage) {
                    buttonHtml += ' class="active am-active"';//@2
                }
                buttonHtml += '><a href="javascript:' + pageViewName + '.goPage(' + blockIndex + ');">' + blockIndex + '</a></li>';
                pageHtml.push(buttonHtml);
                blockIndex++;
            }

            //末位点的绘制
            if ((blockEndNum + 1) < maxpage) {
                pageHtml.push('<li class="disabled am-disabled"><a href="javascript:void(0);">...</a></li>');
            }

            //第maxpage页的绘制
            if (maxpage != 1) {
                if (curPage == maxpage) {
                    pageHtml.push('<li class="active am-active"><a href="javascript:' + pageViewName + '.goPage(' + maxpage + ');" >' + maxpage + '</a></li>');
                } else {
                    pageHtml.push('<li><a href="javascript:' + pageViewName + '.goPage(' + maxpage + ');">' + maxpage + '</a></li>');
                }
            }

            //如果当前页是最后一个则下一页不可用（下一页）
            var nextPageBtnHtml = '<li><a class="next" href="javascript:' + pageViewName + '.goPage(' + (curPage + 1) + ');">&raquo;</a></li></ul>';
            if (curPage == maxpage) {
                nextPageBtnHtml = '<li class="am-disabled disabled"><a class="next" href="javascript:void(0);">&raquo;</a></li></ul>';
            }
            pageHtml.push(nextPageBtnHtml);

            //当前页为第一页不可向上翻页（上一页）
            //  pageHtml.push('<li class="active am-active">共'+totalRecordNumber+'条记录，当前显示第'+curPage+'/'+maxpage+'页</li>');
            pageHtml.push('<label class="page_foot" for="pageSize">共'+totalRecordNumber+'条记录，当前显示第'+curPage+'/'+maxpage+'页</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');


            pageHtml.push('<label class="page_foot" for="pageSize" >每页显示</label>');
            var select = 'selected="selected"';
            pageHtml.push('<select class="jump_input" id="selectPageForm" onchange="' + pageViewName + '.selectPage();"><option value="15" ');
            if(pageSize == 15){
                pageHtml.push('selected="selected" ')
            }
            pageHtml.push('>15</option><option value="30" ');
            if(pageSize == 30){
                pageHtml.push('selected="selected" ')
            }
            pageHtml.push('>30</option><option value="50" ');
            if(pageSize == 50){
                pageHtml.push('selected="selected" ')
            }
            pageHtml.push('>50</option> </select>');
            pageHtml.push('<label for="pageSize">条</label><span id= "pageSizeError" class="errorMessage"></span>');

            //跳至多少页的部分(跳页）
            // pageHtml.push('<div class="pages"><span class="lgauge">向第&nbsp;</span><span><input id="pageInput" class="form-control" style="width:40px;" type="text" value=' + curPage + '></span>');
            // pageHtml.push('<span class="rgauge">&nbsp;页</span><a class="jumpPage" onclick="' + pageViewName + '.jumpToPage(' + maxpage + ');">跳转</a></div></div>');

            pageHtml.push('<div class="pages">向第&nbsp;<input id="pageInput" class="jump_input" style="width:40px;" type="text" value=' + curPage + '>');
            pageHtml.push('&nbsp;页<a class="jumpPage" onclick="' + pageViewName + '.jumpToPage(' + maxpage + ');">跳转</a></div></div>');

            //最后将分页加入容器中
            pageHtml = pageHtml.join("");

            console.log(pageHtml)
            return pageHtml;
        }
    }

    /**
     *   跳页函数，对外开放
     * @param curPage    要跳入的页
     */
    this.goPage = function (curPage) {
        var urlRequestData = pageModel.urlRequestData;
        urlRequestData[pageModel.pageSizeName] = pageModel.pageSize;
        pageModel.curPage = urlRequestData[pageModel.curPageName] = curPage;
        $.ajax({
            url: pageModel.url,
            type: "get",
            data: urlRequestData,
            dataType: "text",
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (data) {
                //构造列表
                pageModel.pageListContainer.empty().html(data);
                //插入loading画面
                if(pageModel.loading){
                    pageModel.pageListContainer.css("position","relative")
                        .append('<div class="loading hide"></div>');
                }
                //获取总页数,和当前页
                pageModel.totalRecordNumber = $("#totalCount", pageModel.pageListContainer).val();
                //构造分页
                var renderPage = _renderPager(pageModel.totalRecordNumber, pageModel.pageSize, pageModel.curPage);
                pageModel.pageContainer.empty().html(renderPage);
                //执行回调
                if(pageModel.callback){
                    pageModel.callback();
                }
            },
            beforeSend: function() {
                if(pageModel.loading){
                    $('.loading', pageModel.pageListContainer).removeClass("hide");
                }
            }
        });
    };

    /**
     *   输入页数的跳页函数，对外开放
     * @param maxPages 最大页数
     */
    this.jumpToPage = function (maxPages) {
        var pagesStr = pageModel.pageContainer.find('div.pages').find('input').val();
        if (null == pagesStr || "" == pagesStr) {
            alert("不能为空！");
            return;
        }
        var charCheck = new RegExp("^[0-9]*$");
        if (!charCheck.test(pagesStr)) {
            alert("类型不匹配，请输入正确的格式！");
            return;
        }
        var pages = parseInt(pagesStr);
        if (pages < 1 || pages > maxPages) {
            alert("页码超出范围，请注意!");
        } else {
            this.goPage(pages);
        }
    };

    /**
     * 初始化第一页的调用
     */
    this.goPage(pageModel.curPage);

    /**
     * 选择每页显示的条数
     * @param pageSize
     */
    this.selectPage = function(){
        var select = pageModel.pageContainer.find('select');
        var newPageSize = select.val();
        var pageSize = 15;
        if(!(null == newPageSize || '' == newPageSize || undefined == newPageSize)){
            pageSize = newPageSize;
        }
        pageModel.pageSize = pageSize;
        this.goPage(1);
    }

};

