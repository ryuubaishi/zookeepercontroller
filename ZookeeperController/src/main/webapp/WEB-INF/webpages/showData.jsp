<%--
  Created by IntelliJ IDEA.
  User: PageLiu
  Date: 12-11-28
  Time: 下午11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common/include.jsp"%>
<html>
<link rel="stylesheet" href="<%=basepath%>/css/zTreeStyle/demo.css" type="text/css">
<link rel="stylesheet" href="<%=basepath%>/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="<%=basepath%>/css/jqueryUI/themes/base/jquery.ui.all.css">

<link rel="stylesheet" href="<%=basepath%>/css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="<%=basepath%>/css/bootstrap/bootstrap-responsive.css">


<script type="text/javascript" src="<%=basepath%>/javascript/jquery.ztree-2.6-custom.js"></script>
<script src="<%=basepath%>/javascript/jqueryUI/jquery.ui.core.js"></script>
<script src="<%=basepath%>/javascript/jqueryUI/jquery.ui.widget.js"></script>
<script src="<%=basepath%>/javascript/jqueryUI/jquery.ui.mouse.js"></script>
<script src="<%=basepath%>/javascript/jqueryUI/jquery.ui.draggable.js"></script>
<script src="<%=basepath%>/javascript/jqueryUI/jquery.ui.position.js"></script>
<script src="<%=basepath%>/javascript/jqueryUI/jquery.ui.resizable.js"></script>
<script src="<%=basepath%>/javascript/jqueryUI/jquery.ui.dialog.js"></script>

<script type="text/javascript">
    var zkTree;
    var setting;
    var startTime;
    var endTime;
    var zNodes =<%=request.getAttribute("rootNodes")%>;
    setting = {
        async: true,
        asyncUrl: getUrl,  //获取节点数据的URL地址
        titleCol:"zpath",
        editable : true,
        edit_removeBtn : true,
        edit_renameBtn:false,
        edit_addBtn:true,
        callback:{
            beforeExpand: zTreeBeforeExpand,
            asyncSuccess: zTreeAjaxSuccess,
            asyncError: zTreeAjaxError,
            beforeRemove: zTreeBeforeDel,
            click: zTreeOnClick,
            remove: zTreeOnRemove,
            add:zTreeOnAdd,
            beforeRename: zTreeBeforeRename
        }
    };

    function zTreeOnRemove(event, treeId, treeNode) {
        alert("删除节点"+treeNode.zpath+"成功！");

        return true;
    }
    function zTreeOnAdd(event, treeId, treeNode) {

        $("#addNodeDialog").dialog(
                {height: 320,width:330,title:"增加节点",resizable:false,
                    modal: true,
                    buttons: {
                        Ok: function() {
                            if(treeNode){
                                $.ajax({
                                    async:false,
                                    type: "POST",
                                    url:"<%=basepath%>/addZKNode",
                                    data: "zpath="+treeNode.zpath+"&nodeName="+$("#nodeName").val()+"&nodeValue="+$("#nodeValue").val()+"&connectStr="+treeNode.connStr,
                                    dataType: "json",
                                    success: function(msg) {
                                        var res = msg.result ;
                                        if(res){
                                            treeNode.isParent = true;
                                            ajaxGetNodes(treeNode, "refresh");
                                        }
                                    },
                                    error:function(){
                                        alert("调用Ajax失败！");

                                    }

                                }) ;
                            }else{
                                alert("请选择一个节点！");
                            }
                            $( this ).dialog( "close" );
                        },
                        Cancel: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                }
        );
        return true;
    }

    function zTreeBeforeDel(treeId, treeNode) {
        if(confirm("是否要删除？")){
            var r = false;
            $.ajax({
                async:false,
                type: "POST",
                url:"<%=basepath%>/removeZKNode",
                data: "zpath="+treeNode.zpath+"&connectStr="+treeNode.connStr,
                dataType: "json",
                success: function(msg) {
                    var res = msg.result ;
                    if(res){
                       r=true;
                    }
                }
            }) ;
            if(!r){
               alert("删除失败，不能删除非空目录！");
            }
            return r;
        }else{
        return false;
        }
    }


    function zTreeOnClick(event, treeId, treeNode) {
//        alert(treeNode.tId + ", " + treeNode.name);
        $("#content").val(treeNode.data);

    }
    function zTreeBeforeRename(treeId, treeNode) {

        return false;
    }




    function zTreeBeforeExpand(treeId, treeNode) {
        if (!treeNode.isAjaxing) {
            startTime = new Date();
            ajaxGetNodes(treeNode, "refresh");
            return false;
        } else {
            alert("zTree 正在下载数据中，请稍后展开节点。。。");
            return false;
        }
        return true;
    }
    function ajaxGetNodes(treeNode, reloadType) {
        if (reloadType == "refresh") {
            treeNode.icon = "<%=webbasepath%>css/zTreeStyle/img/loading.gif";
            zkTree.updateNode(treeNode);
        }
        zkTree.reAsyncChildNodes(treeNode, reloadType);
    }
    function zTreeAjaxSuccess(event, treeId, treeNode, msg) {
        if (!msg || msg.length == 0) {
            return;
        }
        var totalCount = treeNode.count;
        var ajaxInfo = "treeNode:" + treeNode.name;
        if (treeNode.nodes.length < totalCount) {
            var percent = treeNode.nodes.length*100/totalCount + "%";
            ajaxInfo += ("<br/>进度：" + percent);
            setTimeout(function() {ajaxGetNodes(treeNode);}, 100);
        } else {
            endTime = new Date();
            var usedTime = (endTime.getTime() - startTime.getTime())/1000;
            ajaxInfo += ("<br/>加载完毕，共"+treeNode.nodes.length+"个子节点, 耗时："+ usedTime + "秒");
            treeNode.icon = "";
            zkTree.updateNode(treeNode);
            zkTree.selectNode(treeNode.nodes[0]);
        }
        $("#onAsync").html(ajaxInfo);
    }

    function zTreeAjaxError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
        alert("异步获取数据出现异常。");
//        treeNode.icon = "";
        zkTree.updateNode(treeNode);
    }




    function getUrl(treeNode) {
        if(treeNode){
         var param = "zpath="+treeNode.zpath+"&connectStr="+treeNode.connStr;
//		return "asyncData/nodeForHugeData.jsp?" + param;
        return "<%=basepath%>/getPathData?" + param;
        }
    }

    $(function(){

        zkTree = $("#zkTree").zTree(setting, zNodes);

        $("#addNode").click(function(){


        });


        $("#addRoot").click(function(){
            $("#addRootDialog").dialog(
                    {height: 140,width:311,
                        resizable:false,
                        title:"增加连接(host:port)",
                        modal: true,
                        buttons: {
                            Ok: function() {

                                    $.ajax({
                                        async:false,
                                        type: "POST",
                                        url:"<%=basepath%>/addRootNode",
                                        data: "connectStr="+$("#connectStr").val(),
                                        dataType: "json",
                                        success: function(msg) {
                                            var res = msg.result ;
                                            if(res){
                                                window.location.reload();
                                            }
                                        },
                                        error:function(){
                                            alert("调用Ajax失败！");

                                        }

                                    }) ;

                                $( this ).dialog( "close" );
                            },
                            Cancel: function() {
                                $( this ).dialog( "close" );
                            }
                        }
                    }
            );
        });


        $("#editContent").click(function(){
            $.ajax({
                async:false,
                type: "POST",
                url:"<%=basepath%>/modifyNode",
                data: "connectStr="+zkTree.getSelectedNode().connStr+"&zpath="+zkTree.getSelectedNode().zpath+"&content="+$("#content").val(),
                dataType: "json",
                success: function(msg) {
                    var res = msg.result ;
                    if(res){
                        alert("更新成功！");
                    }
                },
                error:function(){
                    alert("调用Ajax失败！");

                }

            }) ;

        });
    });
</script>
<head>
    <title></title>
</head>
<body>
<%=request.getAttribute("data")%>

<table border="0" cellpadding="0">
    <tr>
        <td>

        </td>
        <td></td>
    </tr>
    <tr>
        <td><div style="">
            <ul id="zkTree" class="tree" style="width: 200px;height: 366px "></ul>
        </div></td>
        <td>
            <div id="contentDiv"><textarea id="content" cols="50" rows="17"></textarea></div>
        </td>
    </tr>
    <tr>
        <td style="padding-left: 20px"><button  id="addRoot" class="btn btn-primary">增加连接</button></td>
        <td align="right"><button id="editContent" class="btn btn-primary">修改</button></td>
    </tr>
</table>




<div style="display: none;" id="addNodeDialog">
    <table>
        <tr>
            <td> 节点名称：</td><td><input type="text" id="nodeName" name="nodeName"  style="height: 30px"/></td>
        </tr>
        <tr>
            <td> 节点内容：</td><td><textarea id="nodeValue" name="nodeValue" cols="31" rows="7"></textarea></td>
        </tr>
 </table>
</div>

<div style="display: none;" id="addRootDialog">
    <table>
        <tr>
            <td> 连接串：</td><td><input type="text" id="connectStr" name="connectStr" style="height: 30px"/></td>
        </tr>

    </table>
</div>
</body>
</html>