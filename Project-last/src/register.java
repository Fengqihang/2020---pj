import ExtendTools.CustomerDaoJdbc;
import JavaBeans.Customer;


import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;


public class register extends HttpServlet {
   private CustomerDaoJdbc customerDaoJdbc=new CustomerDaoJdbc();

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          doPost(req,resp);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String method=request.getParameter("method");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String username=request.getParameter("username");

        String password=request.getParameter("password");

        String email=request.getParameter("email");
        Customer customer=new Customer(username,password,email);
        try {
            switch (method) {
                case "register": doRegister(customer, request, response);break;
                case "login":doLogin(customer,request,response);break;
                case "logout":doLogout(request,response); break;
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }


    private void doRegister(Customer customer,HttpServletRequest request,HttpServletResponse response) throws Exception{
        if (Register(customer)){
                doLogin(customer,request,response);//如果注册成功进行登录
        }else{
            HttpSession session=request.getSession();
            session.setAttribute("wrong1",customer);
            session.setAttribute("message","用户名已存在");
            response.sendRedirect("register.jsp");
            //还要提示已经注册过了
        }
    }



    private boolean Register(Customer customer){
        if (!customerDaoJdbc.isRegister(customer.getUserName())){
              customerDaoJdbc.add(customer);
              return true;
        }else{//已经注册过了
            return false;
        }
    }

    private void doLogin(Customer customer,HttpServletRequest request,HttpServletResponse response) throws Exception {
        HttpSession session=request.getSession();
        if (customerDaoJdbc.isRegister(customer.getUserName())){
            //还要加上密码的判断
           if(customerDaoJdbc.isRegister(customer.getUserName(),customer.getPassword())) {
               System.out.println("登陆成功");
               session.setAttribute("success","登陆成功");
               customer.setUID(customerDaoJdbc.getUID(customer.getUserName()));
               session.setAttribute("user",customer);
               //转到登陆前的界面
               response.sendRedirect(request.getSession().getAttribute("path").toString());

           }else{
               session.setAttribute("wrong",customer);
               session.setAttribute("fail","用户名或密码错误");
              response.sendRedirect("login.jsp");
           }
        }else{
            session.setAttribute("wrong",customer);
            session.setAttribute("fail","用户名或密码错误");
            response.sendRedirect("login.jsp");
            //还要加上提示
        }

    }


    private void  doLogout(HttpServletRequest request,HttpServletResponse response){
       Cookie[] cookies=request.getCookies();
       for (Cookie cookie: cookies){
           String s=cookie.getName();
           if (s.startsWith("R_")){
               cookie.setMaxAge(0);
               response.addCookie(cookie);

           }
       }

        request.getSession().removeAttribute("user");


}





}
