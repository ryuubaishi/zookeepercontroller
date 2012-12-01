package zookeepercontroller;

import org.apache.zookeeper.WatchedEvent;
import org.apache.zookeeper.Watcher;

/**
 * User: PageLiu
 * Date: 12-11-28
 * Time: 上午2:17
 */
public class EventWatcher implements Watcher {
    public void process(WatchedEvent event) {
        System.out.println(event.getPath()+";"+event.getState()+";"+event.getType());
    }
}
