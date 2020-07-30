import ExtendTools.ImageDaoJdbc;
import ExtendTools.JsonDateValueProcessor;
import JavaBeans.TravelImage;


import net.sf.json.JSONArray;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

public class search extends HttpServlet {
    @Override
      public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
           ImageDaoJdbc imageDaoJdbc=new ImageDaoJdbc();
           String method=req.getParameter("method");
           String keyWord=req.getParameter("keyWord");
           String first=req.getParameter("first");
           String second=req.getParameter("second");

           switch (method){
               case "pageCount": long x= imageDaoJdbc.getCount(first,keyWord);
                                 resp.getWriter().write(Math.ceil(x/6.0)+"");
                                 break;
               case "load":
                   List<TravelImage> images=imageDaoJdbc.getSearch(Integer.parseInt(req.getParameter("currentPage")),keyWord,first,second);
                   JsonConfig jsonConfig=new JsonConfig();
                   jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
                   JSONArray j = JSONArray.fromObject(images,jsonConfig);
                   resp.getWriter().write(j.toString());
                   break;
           }


}


}

