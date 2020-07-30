import ExtendTools.CollectDaoJdbc;
import ExtendTools.ImageDaoJdbc;
import JavaBeans.Collect;
import JavaBeans.TravelImage;
import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.synth.SynthTextAreaUI;
import java.io.IOException;
import java.util.List;

public class collection extends HttpServlet {
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       doPost(req,resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userID=Integer.parseInt(req.getParameter("userID"));
        String method=req.getParameter("method");
        CollectDaoJdbc collectDaoJdbc=new CollectDaoJdbc();
        ImageDaoJdbc imageDaoJdbc=new ImageDaoJdbc();
        switch(method){
            case "pageCount":long x=collectDaoJdbc.getCount(userID);
                resp.getWriter().write(Math.ceil(x/3.0)+"");
                break;
            case "load":
                List<Collect> collects=collectDaoJdbc.getImageIDList(Integer.parseInt(req.getParameter("currentPage")),userID);
                List<TravelImage> images=imageDaoJdbc.getCollections(collects);

                JSONArray j = JSONArray.fromObject(images);
                resp.getWriter().write(j.toString());
                break;

            case "delete":   int imageID=Integer.parseInt(req.getParameter("iI"));
                              collectDaoJdbc.delete(userID,imageID,imageDaoJdbc);


        }

    }
}
