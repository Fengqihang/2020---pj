
import ExtendTools.ImageDaoJdbc;
import JavaBeans.TravelImage;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class query extends HttpServlet {
    private ImageDaoJdbc imageDaoJdbc=new ImageDaoJdbc();
    @Override
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<TravelImage> list=imageDaoJdbc.getHeat();
        req.setAttribute("img",list);
        List<TravelImage> list1=imageDaoJdbc.getNewest();
        req.setAttribute("ns",list1);
        req.getRequestDispatcher("home.jsp").forward(req,resp);
    }
}
