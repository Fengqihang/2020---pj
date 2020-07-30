package databasesTools;

import JavaBeans.Customer;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Connection;

import java.util.List;

public class DAO<T> {
    private Class<T> clazz;
    private QueryRunner queryRunner=new QueryRunner();

    public DAO(){
        Type superClass=getClass().getGenericSuperclass();
        if (superClass instanceof ParameterizedType){
            ParameterizedType parameterizedType=(ParameterizedType)superClass;
            Type [] typeArgs=parameterizedType.getActualTypeArguments();
            if (typeArgs != null&&typeArgs.length>0){
                if (typeArgs[0] instanceof Class){
                    clazz=(Class<T>)typeArgs[0];
                }
            }

        }


    }
    //更新数据库
    public void update(String sql,Object...args){

        Connection connection=null;
        try{ connection=JdbcTools.getConnection();
            queryRunner.update(connection,sql,args);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
           JdbcTools.release(null,null,connection);
        }

    }
    //获取某一对象
    public T get(String sql,Object...args){
        Connection connection=null;
        try{
             connection=JdbcTools.getConnection();
             return queryRunner.query(connection,sql,new BeanHandler<>(clazz),args);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JdbcTools.release(null,null,connection);
        }
        return null;
    }
    //获取对象列表
    public List<T> getForList(String sql,Object...args){
        Connection connection=null;
        try{
            connection=JdbcTools.getConnection();
            return queryRunner.query(connection,sql,new BeanListHandler<>(clazz),args);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JdbcTools.release(null,null,connection);
        }

        return null;
    }
    //根据某些条件获取某条性质
    public <E> E getForValue(String sql,Object...args){
        Connection connection=null;
        try{
            connection=JdbcTools.getConnection();
            return (E)queryRunner.query(connection,sql,new ScalarHandler(),args);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JdbcTools.release(null,null,connection);
        }

        return null;
    }

}
