package zookeepercontroller.util;

/**
 * User: PageLiu
 * Date: 12-11-28
 * Time: 下午10:09
 */
public class StringUtil {
    public static boolean isNotEmpty(String test){
        return test!=null&&!"".equals(test);

    }
    public static boolean isEmpty(String test){
        return test==null||"".equals(test);

    }
}
