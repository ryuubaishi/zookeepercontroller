package zookeepercontroller.zkconn;

import org.apache.zookeeper.Watcher;
import org.apache.zookeeper.ZooKeeper;

import java.io.IOException;

/**
 * User: PageLiu
 * Date: 12-11-28
 * Time: 上午2:22
 */
public class ZookeeperConnection {
    private String connectString;
    private int sessionTimeout;
    private Watcher watcher;


    public String getConnectString() {
        return connectString;
    }

    public void setConnectString(String connectString) {
        this.connectString = connectString;
    }

    public int getSessionTimeout() {
        return sessionTimeout;
    }

    public void setSessionTimeout(int sessionTimeout) {
        this.sessionTimeout = sessionTimeout;
    }

    public Watcher getWatcher() {
        return watcher;
    }

    public void setWatcher(Watcher watcher) {
        this.watcher = watcher;
    }
    ZooKeeper zooKeeper  = null;
    public ZooKeeper createZookeeper() throws IOException {
        zooKeeper = new ZooKeeper(connectString,sessionTimeout,watcher);
        return zooKeeper;
    }
    public void close() throws InterruptedException {
        if(zooKeeper!=null){
            zooKeeper.close();
        }
    }
}
