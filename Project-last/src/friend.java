import ExtendTools.CustomerDaoJdbc;
import ExtendTools.FriendDaoJdbc;
import ExtendTools.JsonDateValueProcessor;
import JavaBeans.Customer;
import JavaBeans.Friend;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;

public class friend extends HttpServlet {
    private FriendDaoJdbc friendDaoJdbc=new FriendDaoJdbc();
    private CustomerDaoJdbc customerDaoJdbc=new CustomerDaoJdbc();

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method=req.getParameter("method");


        switch (method){
            case "show":
                doShow(req,resp);
                break;

        }


    }



    private void doShow(HttpServletRequest request,HttpServletResponse response) {

        Customer user=(Customer) request.getSession().getAttribute("user");
        int userId=user.getUID();
        List<Friend> friends=friendDaoJdbc.getFriendList(userId);

        List<Customer> customers=customerDaoJdbc.getMyFriend(friends);
        JsonConfig jsonConfig=new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
        JSONArray j = JSONArray.fromObject(customers,jsonConfig);
        try{
            response.getWriter().write(j.toString());
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
