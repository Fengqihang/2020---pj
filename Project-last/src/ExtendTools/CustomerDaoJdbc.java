package ExtendTools;

import JavaBeans.Customer;
import JavaBeans.Friend;
import databasesTools.DAO;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CustomerDaoJdbc extends DAO<Customer> {


     public void add(Customer customer){
         String sql="INSERT INTO user(username,password,email,date) "+
                 "VALUES(?,?,?,?)";
         update(sql,customer.getUserName(),customer.getPassword(),customer.getEmail(),new Date());
     }

     public boolean isRegister(Object...args){
         String sql="SELECT username,password,email "+
                 "FROM user WHERE username=?";
         Customer customer=get(sql,args[0]);
         if (args.length==2){//再输入参数为两个的情况下判断密码是否匹配，一定是注册了的情况下
             if (customer!=null){
                 return customer.getPassword().equals(args[1]);//若已注册，返回是否匹配密码
             }
         }else{
             return customer!=null;//在输入参数为一个的情况下判断 是否已经注册
         }
         return false;
     }

     public int getUID(String username){
         String sql="SELECT UID FROM user WHERE username=?";
         return getForValue(sql,username);
     }

      public List<Customer> getMyFriend(List<Friend> friends){
         List<Customer> customers=new ArrayList<>();
         String sql="SELECT UID,username,email,date FROM user WHERE UID=?";
         for (Friend friend:friends){
             customers.add(get(sql,friend.getFriendID()));
         }
          return customers;
      }

}
