package zookeepercontroller.bean;

import java.util.List;

/**
 * User: PageLiu
 * Date: 12-11-28
 * Time: 下午8:47
 */
public class ValueNode {

    private String value;
    private String zpath;
    private boolean isParent;
    private String connStr;



    public String getConnStr() {
        return connStr;
    }

    public void setConnStr(String connStr) {
        this.connStr = connStr;
    }

    private List<ValueNode> childNodes;

    public boolean getIsParent() {
        return isParent;
    }

    public void setIsParent(boolean parent) {
        isParent = parent;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getZpath() {
        return zpath;
    }

    public void setZpath(String zpath) {
        this.zpath = zpath;
    }

    public List<ValueNode> getChildNodes() {
        return childNodes;
    }

    public void setChildNodes(List<ValueNode> childNodes) {
        this.childNodes = childNodes;
    }

    public boolean equals(ValueNode valueNode){
        return valueNode!=null&&zpath!=null&&getZpath().equals(valueNode.getZpath());

    }

}
