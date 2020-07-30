package ExtendTools;

import JavaBeans.Friend;
import databasesTools.DAO;

import java.util.List;

public class FriendDaoJdbc extends DAO<Friend> {


 public List<Friend> getFriendList(int userID ){
     String sql="SELECT * FROM friend WHERE userID=?";
     return getForList(sql,userID);
 }



}
