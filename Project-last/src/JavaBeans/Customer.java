package JavaBeans;

import java.util.Date;

public class Customer {
    private String userName="",password="",email="";
    private int UID;
    private Date date;

    public Customer(){}

    public Customer(String userName, String password, String email){
        this.userName=userName;
        this.password=password;
        this.email=email;
    }

    public void setUserName(String userName){this.userName=userName;}

    public String getUserName(){return  userName;}

    public void setPassword(String password){this.password=password;}

    public String getPassword(){return  password;}

    public void setEmail(String email){this.email =email;}

    public String getEmail(){return email;}

    public void setUID(int UID) {
        this.UID = UID;
    }

    public int getUID() {
        return UID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
