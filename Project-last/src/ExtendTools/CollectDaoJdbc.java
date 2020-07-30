package ExtendTools;

import JavaBeans.Collect;
import JavaBeans.TravelImage;
import databasesTools.DAO;

import java.util.List;

public class CollectDaoJdbc extends DAO<Collect> {

    public String addCollection(int userID,int imageID,ImageDaoJdbc imageDaoJdbc){
        String sql="SELECT * FROM mycollection WHERE userID=? AND imageID=?";

        Collect collect=get(sql,userID,imageID);
        if (collect==null){
            sql="INSERT INTO mycollection(userID,imageID) VALUES(?,?)";
            update(sql,userID,imageID);
            sql="UPDATE image SET heat=heat+1 WHERE imageID=?";
            imageDaoJdbc.update(sql,imageID);
            return "Successful";
        }else{
            return "Already stored";
        }
    }

    public boolean show(int userID,int imageID){
        String sql="SELECT * FROM mycollection WHERE userID=? AND imageID=?";
        Collect collect=get(sql,userID,imageID);
        return collect!=null;
    }


    public long getCount(int userID){
        String sql="SELECT COUNT(*) FROM mycollection WHERE userID=?";
        return getForValue(sql,userID);
    }

    public List<Collect> getImageIDList(int currentPage,int userID){

        int x=(currentPage-1)*3;
        String sql="SELECT userID,imageID FROM mycollection WHERE userID=? LIMIT ?,3";
        return getForList(sql,userID,x);

    }

    public void delete(int userID,int imageID,ImageDaoJdbc imageDaoJdbc){
        String sql="DELETE FROM mycollection WHERE userID=? AND imageID=?";
        update(sql,userID,imageID);
        sql="UPDATE image SET heat=heat-1 WHERE imageID=?";
        imageDaoJdbc.update(sql,imageID);
    }





}
