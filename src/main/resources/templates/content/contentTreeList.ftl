<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>运营内容</title>

    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
    <script type="text/javascript" src="${base}/static/js/jquery-3.1.1.min.js"></script>
    <script type="text/javascript" src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${base}/static/treeview/js/bootstrap-treeview.js"></script>
</head>
<body>


<!--页面隐藏数据部分-->
<div id="contentTreeMainDiv">
    <div id="contentTreeLeft" style="width:20%"></div>
    <div id="conteentTreeRight" style="width:80%"></div>
</div>


<script>
$(function () {
    function getTree() {
        var tree = [
            {
                text: "Parent 1",
                nodes: [
                    {
                        text: "Child 1",
                        nodes: [
                            {
                                text: "Grandchild 1"
                            },
                            {
                                text: "Grandchild 2"
                            }
                        ]
                    },
                    {
                        text: "Child 2"
                    }
                ]
            },
            {
                text: "Parent 2"
            },
            {
                text: "Parent 3"
            },
            {
                text: "Parent 4"
            },
            {
                text: "Parent 5"
            }
        ];
        return tree;
    }

    $('#contentTreeLeft').treeview({data: getTree()});


   });

</script>
</body>
</html>