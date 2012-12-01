package zookeepercontroller.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.io.*;
import java.util.*;

/**
 * User: PageLiu
 * Date: 12-11-28
 * Time: 下午8:56
 */
public class JSONFile  {

    public static void persistConnect(Set<String> connSet) throws IOException {
         if(connSet!=null){
        JSONObject jsonObject = new JSONObject();
        ArrayList<String> conns = new ArrayList<String>();
        Iterator iterator = connSet.iterator();
        while(iterator.hasNext()){
            String i = (String)iterator.next();
            conns.add(i);
        }

        jsonObject.put("conns",conns) ;

        File jsonFile = new File(System.getProperty("user.home"));
        if(jsonFile.exists()&&jsonFile.isDirectory()){
            File file = new File(jsonFile,".zkcontroller");
            file.mkdir();
            File jFile = new File(file,"conns.json");
            FileWriter fw = new FileWriter(jFile);
            fw.write(jsonObject.toJSONString());
            fw.close();
        }else{
            throw new IOException("没有找到用户路径！");
        }
         }
    }

       public static void persistConnect(String jsonString) throws IOException {
            if(StringUtil.isNotEmpty(jsonString)){
            File jsonFile = new File(System.getProperty("user.home"));
           if(jsonFile.exists()&&jsonFile.isDirectory()){
               File file = new File(jsonFile,".zkcontroller");
               file.mkdir();
               File jFile = new File(file,"conns.json");
               FileWriter fw = new FileWriter(jFile);
               fw.write(jsonString);
               fw.close();
           }else{
               throw new IOException("没有找到用户路径！");
           }
            }
       }

       public static Set<String> readConnects() throws IOException {
           File jsonFile = new File(System.getProperty("user.home"));
           Set<String> connSet = new HashSet<String>();
           if(jsonFile.exists()&&jsonFile.isDirectory()){
               File file = new File(jsonFile,".zkcontroller");
               if(!file.exists()||!file.isDirectory()){
                   file.mkdir();

               }

               File jFile = new File(file,"conns.json");
               if(jFile.exists()){
                   FileReader fr = new FileReader(jFile);
                   char[] chas = new char[1024];
                   StringBuffer sbs = new StringBuffer();
                   int n=0;
                   while((n=fr.read(chas))!=-1){
                       sbs.append(chas,0,n);
                   }
                   fr.close();
                   JSONObject jsonObject = JSON.parseObject(sbs.toString());
                   JSONArray jsonArray = jsonObject.getJSONArray("conns");
                   for(int i=0;i<jsonArray.size();i++){
                       String conn = jsonArray.getString(i);
                       connSet.add(conn);
                   }



               }else{
                 InputStream inputStream = JSONFile.class.getResourceAsStream("/settings.properties");
                   if(inputStream!=null){
                   try{
                   Properties properties = new Properties();
                   properties.load(inputStream);
                   String defaultConns = (String) properties.get("defaultConns");
                   String[] conns = defaultConns.split(",");
                   for(String conn:conns){
                       connSet.add(conn);
                   }
                   }catch (NullPointerException e){

                   }   finally {
                       inputStream.close();
                   }
                   }


               }
           }else{
                throw new IOException("没有找到用户路径！");
           }
           return connSet;
    }

       public static void main(String[] args){
           System.out.println(System.getProperties());
       }


}
