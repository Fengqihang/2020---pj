import ExtendTools.ImageDaoJdbc;
import JavaBeans.Customer;
import JavaBeans.TravelImage;
import net.sf.json.JSONArray;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class upload extends HttpServlet {
    private ImageDaoJdbc imageDaoJdbc=new ImageDaoJdbc();
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          String method=req.getParameter("method");
          Customer user=(Customer)req.getSession().getAttribute("user");
          int userID=user.getUID();

          switch(method){
              case "pageCount":  long x=imageDaoJdbc.getMyImageCount(userID);
                                   resp.getWriter().write(Math.ceil(x/3.0)+"");
                                   break;
              case "load":
                  List<TravelImage> images=imageDaoJdbc.getMyPage(Integer.parseInt(req.getParameter("currentPage")),userID);
                  JSONArray j = JSONArray.fromObject(images);
                  resp.getWriter().write(j.toString());
                  break;
              case "delete":
                  int imageID=Integer.parseInt(req.getParameter("imageID"));
                  imageDaoJdbc.deleteByImageID(imageID);
                  break;
              case "upload":insert(req,resp,userID);
                             resp.getWriter().write("");
                            break;
              case "change1":
                  int imageID1=Integer.parseInt(req.getParameter("imageID"));
                  TravelImage travelImage= imageDaoJdbc.getById(imageID1);
                  System.out.println("change1:"+imageID1);
                  req.getSession().setAttribute("myUpload",travelImage);
                  req.getSession().setAttribute("imageID1",imageID1);
                  resp.sendRedirect("upload.jsp");
                  break;
              case "change":change(req,resp);
                            resp.getWriter().write("");
                         break;
          }
    }

    private void insert(HttpServletRequest request,HttpServletResponse response,int UID){
         TravelImage travelImage=new TravelImage();
         travelImage.setTitle(request.getParameter("title"));
         travelImage.setAuthor(request.getParameter("author"));
         travelImage.setSubject(request.getParameter("subject"));
         travelImage.setCity(request.getParameter("city"));
         travelImage.setCountry(request.getParameter("country"));
         travelImage.setDescription(request.getParameter("description"));
         travelImage.setOwnerID(UID);
         travelImage.setImageFileName(request.getParameter("inputfile"));
         imageDaoJdbc.insert(travelImage);
    }

    private void change(HttpServletRequest request,HttpServletResponse response){
        System.out.println("到达upload");
        TravelImage travelImage=new TravelImage();
        travelImage.setTitle(request.getParameter("title"));
        travelImage.setAuthor(request.getParameter("author"));
        travelImage.setSubject(request.getParameter("subject"));
        travelImage.setCountry(request.getParameter("country"));
        travelImage.setCity(request.getParameter("city"));
        travelImage.setDescription(request.getParameter("description"));
        int imageID=(int)request.getSession().getAttribute("imageID1");
        System.out.println(imageID);
        travelImage.setImageID(imageID);
        imageDaoJdbc.change(travelImage);
        request.getSession().removeAttribute("imageID1");
        request.getSession().removeAttribute("myUpload");
    }
}
