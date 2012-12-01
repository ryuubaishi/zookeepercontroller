package zookeepercontroller.util;

import zookeepercontroller.bean.ValueNode;
import zookeepercontroller.bean.ZTree;

import java.util.ArrayList;
import java.util.List;

/**
 * User: PageLiu
 * Date: 12-11-28
 * Time: 下午10:05
 */
public class ConvertTreeNode {
    public static ZTree  convertValueNode(ValueNode valueNode){
        String path = valueNode.getZpath();
        String data = valueNode.getValue();
        List<ValueNode> valueNodeList= valueNode.getChildNodes();
        ZTree root = new ZTree();
        root.setData(data);
        root.setName(getName(path));
        root.setZpath(path);
        root.setConnStr(valueNode.getConnStr());
        List<ZTree> zTreeList = new ArrayList<ZTree>();
        for(ValueNode valueN:valueNodeList){
            ZTree child = new ZTree();
            child.setData(valueN.getValue());
            child.setName(getName(valueN.getZpath()));
            child.setZpath(valueN.getZpath());
            child.setParent(valueN.getIsParent());
            child.setConnStr(valueN.getConnStr());
            zTreeList.add(child);
        }
        root.setChildTrees(zTreeList);
        return root;
    }

    private static String getName(String path) {
        if(StringUtil.isNotEmpty(path)){
            int pos =path.lastIndexOf('/');
            if(pos==-1){
                return path;
            }else{
                 return path.substring(pos+1);
            }
        }
        return "";  //To change body of created methods use File | Settings | File Templates.
    }
}
