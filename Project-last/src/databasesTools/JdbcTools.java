package databasesTools;

import java.sql.*;

public class JdbcTools {

   public JdbcTools(){
      try{
         Class.forName("com.mysql.jdbc.Driver");
      }catch (Exception e){
         e.printStackTrace();
      }
   }

     public static Connection getConnection() {
        final String url="jdbc:mysql://localhost:3306/pj";
        final String username="root";
        final String password="Fqh121672";

         Connection connection=null;
         try{
             connection= DriverManager.getConnection(url,username,password);
         }catch (Exception e){
             e.printStackTrace();
         }
         return connection;
     }

     public static void release(ResultSet resultSet,Statement statement,Connection connection){
       if (resultSet!=null){
           try{resultSet.close();}catch (Exception e){
               e.printStackTrace();
           }
       }
       if (statement!=null){
           try{statement.close();}catch (Exception e){
               e.printStackTrace();
           }
       }
       if (connection!=null){
           try{connection.close();}catch (Exception e){
               e.printStackTrace();
           }
       }
     }


}
