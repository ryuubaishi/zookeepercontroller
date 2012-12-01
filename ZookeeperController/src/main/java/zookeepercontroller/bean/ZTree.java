package zookeepercontroller.bean;

import java.util.List;

/**
 * User: PageLiu
 * Date: 12-11-28
 * Time: 下午9:59
 */
public class ZTree {
    private String name;
    private String zpath;
    private String data;
    private boolean isParent;
    private String connStr;

    public String getConnStr() {
        return connStr;
    }

    public void setConnStr(String connStr) {
        this.connStr = connStr;
    }

    public boolean isParent() {
        return isParent;
    }

    public void setParent(boolean parent) {
        isParent = parent;
    }

    private List<ZTree> childTrees;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getZpath() {
        return zpath;
    }

    public void setZpath(String zpath) {
        this.zpath = zpath;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public List<ZTree> getChildTrees() {
        return childTrees;
    }

    public void setChildTrees(List<ZTree> childTrees) {
        this.childTrees = childTrees;
    }
}
