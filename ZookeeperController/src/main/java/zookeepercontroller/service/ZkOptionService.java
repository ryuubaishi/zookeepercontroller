package zookeepercontroller.service;

import org.apache.zookeeper.KeeperException;
import org.apache.zookeeper.ZooKeeper;
import zookeepercontroller.bean.ValueNode;
import zookeepercontroller.zkconn.ZookeeperConnection;

import java.io.IOException;

/**
 * User: PageLiu
 * Date: 12-11-28
 * Time: 下午8:42
 */
public interface ZkOptionService {
     public ValueNode getValueNode(String path,ZookeeperConnection zkConn) throws InterruptedException, KeeperException, IOException;
     public String createPath(String path,ZookeeperConnection zkConn) throws IOException;
     public String createPath(String path,byte[] data,ZookeeperConnection zkConn) throws IOException;

    public boolean setData(ZookeeperConnection zkConn,String path,String content) throws IOException;
    public boolean  deletePath(String path,ZookeeperConnection zkConn) throws IOException;

}
