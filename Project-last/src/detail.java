import ExtendTools.CollectDaoJdbc;
import ExtendTools.ImageDaoJdbc;
import JavaBeans.Customer;
import JavaBeans.TravelImage;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class detail extends HttpServlet {
    private ImageDaoJdbc imageDaoJdbc=new ImageDaoJdbc();
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
           doPost(req,resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getParameter("add")!=null){
            String method=req.getParameter("method");
            int imageID=Integer.parseInt(req.getParameter("add"));
            Customer user=(Customer) req.getSession().getAttribute("user");
            CollectDaoJdbc collectDaoJdbc=new CollectDaoJdbc();
            switch(method){
                case "store" :
                    String message=collectDaoJdbc.addCollection(user.getUID(),imageID,imageDaoJdbc);
                    resp.getWriter().write(message);
                    break;
                case "checkStore":
                  boolean bol=collectDaoJdbc.show(user.getUID(),imageID);
                  resp.getWriter().write(bol+"");
                  break;
            }

        }else{
            int id=Integer.parseInt(req.getParameter("id"));
            req.getSession().setAttribute("imageID",id);
            TravelImage travelImage=imageDaoJdbc.getById(id);
            req.setAttribute("detail",travelImage);
            req.getRequestDispatcher("detail.jsp").forward(req,resp);
        }

    }
}
