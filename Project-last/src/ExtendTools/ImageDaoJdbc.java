package ExtendTools;

import JavaBeans.Collect;
import JavaBeans.TravelImage;
import com.sun.org.apache.regexp.internal.RE;
import databasesTools.DAO;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

public class ImageDaoJdbc extends DAO<TravelImage> {

    //获取最热
    public List<TravelImage> getHeat(){
        String sql="SELECT * FROM image ORDER BY heat DESC LIMIT 5";
        return getForList(sql);
    }
   //获取最新
    public List<TravelImage> getNewest(){
        String sql="SELECT * FROM image ORDER BY timeReleased DESC LIMIT 3";
        return getForList(sql);
    }
   //由imageID获取图片
    public TravelImage getById(int id){
        String sql="SELECT * FROM image WHERE imageID=?";
        return get(sql,id);
    }
    //由当前页数，关键字，关键字是title还是subject，以及排序方式获取图片对象集合
    public List<TravelImage> getSearch(int currentPage,String keyWord,String first,String second){
        int x=(currentPage-1)*6;
        String sql;
        if (first.equals("subject")&&second.equals("heat")){
            sql="SELECT imageID,imageFileName,title,subject,timeReleased ,heat FROM image WHERE subject LIKE '%' ?"+
                    " '%'  ORDER BY heat DESC LIMIT ?,6";
        }else if (first.equals("title") && second.equals("heat")){
            sql="SELECT imageID,title,imageFileName,subject,timeReleased,heat FROM image WHERE title LIKE '%' ?"+
                    " '%'  ORDER BY heat DESC LIMIT ?,6";
        }else if(first.equals("subject")&&second.equals("timeReleased")){
            sql="SELECT imageID,title,imageFileName,subject,timeReleased,heat FROM image WHERE subject LIKE '%' ?"+
                    " '%'  ORDER BY timeReleased DESC LIMIT ?,6";
        }else{
            sql="SELECT imageID,title,imageFileName,subject,timeReleased,heat FROM image WHERE title LIKE '%' ?"+
                    " '%'  ORDER BY timeReleased DESC LIMIT ?,6";
        }

        return getForList(sql,keyWord,x);
        //获取某一页的信息
    }
   //获取搜索界面图片的数目
    public long getCount(String first,String keyWord){
        String sql;
     if (first.equals("title")){
              sql="SELECT COUNT(*) FROM image WHERE title LIKE '%' ?"+
        " '%' ";
        }else{
        sql="SELECT COUNT(*) FROM image WHERE subject LIKE '%' ?"+
                 " '%' ";
        }
        //获取总共的条数

        return getForValue(sql,keyWord);
    }

    //由收藏表在image表中获取相应imageID的图片对象集合
    public List<TravelImage> getCollections(List<Collect> collects){
        List<TravelImage> travelImages=new LinkedList<>();

        String sql="SELECT imageID,title,imageFileName,subject,timeReleased,heat FROM image WHERE imageID=?";
        for (Collect collect:collects){
            TravelImage travelImage=get(sql,collect.getImageID());
                travelImages.add(travelImage);
         }

        return travelImages;
    }

    //获取我的藏品的数目
    public long getMyImageCount(int userID){
        String sql="SELECT COUNT(*) FROM image WHERE ownerID=?";
        return getForValue(sql,userID);
    }

    public List<TravelImage> getMyPage(int currentPage,int userID){
        int x=(currentPage-1)*3;
        String sql="SELECT * FROM image WHERE ownerID=?  ORDER BY imageID ASC LIMIT ?,3 ";
        return getForList(sql,userID,x);

    }

    public void deleteByImageID(int imageID){
        String sql="DELETE FROM image WHERE imageID=?";
        update(sql,imageID);
    }

    public void insert(TravelImage travelImage){
        String sql="INSERT INTO image(author,title,subject,imageFileName,description,country,city,heat,ownerID,timeReleased) "+
                "VALUES(?,?,?,?,?,?,?,?,?,?)";
        update(sql,travelImage.getAuthor(),travelImage.getTitle(),travelImage.getSubject(),travelImage.getImageFileName(),
                travelImage.getDescription(),travelImage.getCountry(),travelImage.getCity(),0,travelImage.getOwnerID(),new Date());

    }

    public void change(TravelImage travelImage){
        String sql="UPDATE image SET author=?,title=?,subject=?,description=?,timeReleased=?,country=?,city=?" +
                " WHERE imageID=?";
       // System.out.println("到达change");
        update(sql,travelImage.getAuthor(),travelImage.getTitle(),travelImage.getSubject(),travelImage.getDescription(),new Date(),travelImage.getCountry(),
                travelImage.getCity(),travelImage.getImageID());

    }


}
