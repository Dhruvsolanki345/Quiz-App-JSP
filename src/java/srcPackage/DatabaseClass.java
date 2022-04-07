/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package srcPackage;

/**
 *
 * @author dhruv
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import srcPackage.ExamDetail;
import srcPackage.Exams;
import srcPackage.Questions;
import srcPackage.User;

public class DatabaseClass {
    private Connection conn;
    
    public DatabaseClass(){
        establishConnection();
    }
    
    private void establishConnection() {
        try{
            Class.forName("com.mysql.jdbc.Driver");
            conn= DriverManager.getConnection("jdbc:mysql:///online_system","root","");  
        }catch(ClassNotFoundException | SQLException e){
            System.out.println("establishConnection: catch: "+e);
        }
    }

    public boolean loginValidate(String userName, String userPass) throws SQLException{
    
        String sql="SELECT * FROM user WHERE username=? and pass=?";
        PreparedStatement pstm=conn.prepareStatement(sql);
        pstm.setString(1,userName);
        pstm.setString(2,userPass);
        System.out.println("loginValidate");
        ResultSet rs=pstm.executeQuery();

        return rs.next();
          
    }

    public String getUserType(String userId){
        String str="";
        PreparedStatement pstm;
        try {
            pstm = conn.prepareStatement("Select * from user where username=?");
            pstm.setString(1, userId);
            ResultSet rs=pstm.executeQuery();
            while(rs.next()){
                str= rs.getString("type");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            str= "error";
        }
        return str;
    }

    public boolean addNewStudent(String name,String uName,String pass,String email,String type){
        try {
            String sql0="SELECT * FROM user WHERE username=?";
            PreparedStatement pst=conn.prepareStatement(sql0);
            pst.setString(1,uName);
            ResultSet rs0=pst.executeQuery();
            if(!rs0.next()){
                String sql="INSERT into user(name,username,pass,email,type) Values(?,?,?,?,?)";

                PreparedStatement pstm=conn.prepareStatement(sql);
                pstm.setString(1,name );
                pstm.setString(2,uName );
                pstm.setString(3,pass );
                pstm.setString(4,email );
                pstm.setString(5,type );
                pstm.executeUpdate();
                return true;
            }else{
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseClass.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public ArrayList<User> getAllUsers(){
        ArrayList<User> list=new ArrayList<>();
        User user=null;
        PreparedStatement pstm;
        try {
            pstm = conn.prepareStatement("Select * from user");
            ResultSet rs=pstm.executeQuery();
            while(rs.next()){
                user =new User(rs.getString("username"), rs.getString("name"), 
                rs.getString("pass"), rs.getString("email"), rs.getString("type"));
            list.add(user);
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            
        }
        return list;
    }

    public void updateStudent(String name,String uName,String pass,String email,String type){
        try {
            String sql="Update user set name=? , pass=? , email=?, type=? where username=?";
            
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1,name );
            pstm.setString(2,pass );
            pstm.setString(3,email );
            pstm.setString(4,type );
            pstm.setString(5,uName );
            pstm.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Update catch:  "+ex);  
        }
    }
    
    public User getUserDetails(String userId){
        User userDetails=null;
        
        try {
           String sql="Select * from user where username=?";
           PreparedStatement pstm=conn.prepareStatement(sql);
           pstm.setString(1, userId);
           ResultSet rs=pstm.executeQuery();
           while(rs.next()){
               userDetails=new User(rs.getString("username"), rs.getString("name"), 
                    rs.getString("pass"), rs.getString("email"), rs.getString("type"));
           }
           pstm.close();
           
       } catch (SQLException ex) {
           System.out.println("Userdetail:  "+ex);
       }
        return userDetails;
    }

    public void delUser(String uid){
        try {
            String sql="DELETE from user where username=?";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1,uid);
            pstm.executeUpdate();
            pstm.close();
        } catch (SQLException ex) {
            Logger.getLogger(DatabaseClass.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<ExamDetail> getAllExam(){
        ArrayList<ExamDetail> list=new ArrayList<>();
        try {
            String sql="SELECT * from examdetail";
            PreparedStatement pstm=conn.prepareStatement(sql);
            ResultSet rs=pstm.executeQuery();
            while(rs.next()){
                list.add(new ExamDetail(rs.getInt("id"), rs.getString("eName"),
                            rs.getInt("tMarks"), rs.getString("examTime")));
            }
            pstm.close();
        } catch (SQLException ex) {
            System.out.println("getAllExam Catch: "+ex);
        }
        return list;
    }

    public boolean addNewExam(String eName,int tMarks,String time){
        try {
            String sql="INSERT into examdetail(eName,tMarks,examTime) Values(?,?,?)";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1, eName);
            pstm.setInt(2,tMarks);
            pstm.setString(3,time);
            pstm.executeUpdate();
            pstm.close();
            return true;
        } catch (SQLException ex) {
            System.out.println("addNewExam Catch: "+ex);
            return false;
        }
    }
    
    public ExamDetail getSelectedExam(String eName){
        ExamDetail exam = null;
        try {
            String sql="SELECT * from examdetail where eName=?";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1, eName);
            ResultSet rs=pstm.executeQuery();
            rs.next();
            exam = new ExamDetail(rs.getInt("id"), rs.getString("eName"),rs.getInt("tMarks"), rs.getString("examTime"));
            pstm.close();
        } catch (SQLException ex) {
            System.out.println("getAllExam Catch: "+ex);
        }
        return exam;
    }
    
    public void delExam(String eName){
        try {
            String sql="DELETE from examdetail where eName=?";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1,eName);
            pstm.executeUpdate();
            pstm.close();
        } catch (SQLException ex) {
            System.out.println("delExam catch: "+ex);
        }
    }

    public ArrayList<Exams> getAllExamStudent(String eName){
        ArrayList<Exams> list=new ArrayList<>();
        try {
            String sql="SELECT * from exams where eName=?";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1, eName);
            ResultSet rs=pstm.executeQuery();
            while(rs.next()){
                list.add(new Exams(rs.getInt("id"), rs.getString("username"), rs.getString("eName"),
                    rs.getInt("tMarks"), rs.getInt("obtMarks"), rs.getString("examTime"), rs.getString("date")));
            }
            pstm.close();
        } catch (SQLException ex) {
            System.out.println("getAllExamStudent Catch: "+ex);
        }
        return list;
    }
    
    public void addNewExamRecord(String username,String eName,int tMarks,int obtMarks,String time,String date){
        try {
            String sql="INSERT into exams(username,eName,tMarks,obtMarks,examTime,date) Values(?,?,?,?,?,?)";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1, username);
            pstm.setString(2, eName);
            pstm.setInt(3,tMarks);
            pstm.setDouble(4,obtMarks);
            pstm.setString(5,time);
            pstm.setString(6,date);
            pstm.executeUpdate();
            pstm.close();
        } catch (SQLException ex) {
            System.out.println("addNewExam Catch: "+ex);
        }
    }
    
    public ArrayList<Exams> getAllAttendedExam(String username){
        ArrayList<Exams> list=new ArrayList<>();
        try {
            String sql="SELECT * from exams where username=?";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1, username);
            ResultSet rs=pstm.executeQuery();
            while(rs.next()){
                list.add(new Exams(rs.getInt("id"), rs.getString("username"), rs.getString("eName"),
                    rs.getInt("tMarks"), rs.getInt("obtMarks"), rs.getString("examTime"), rs.getString("date")));
            }
            pstm.close();
        } catch (SQLException ex) {
            System.out.println("getAllExamStudent Catch: "+ex);
        }
        return list;
    }

    public boolean addQuestion(String eName,String question,String opt1,String opt2,String opt3
                                ,String opt4,String correct){
        
        try {
            String sql="INSERT into question( question,eName, op1, op2, op3, op4, correct)"
                    + " VALUES (?,?,?,?,?,?,?)";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1, question);
            pstm.setString(2, eName);
            pstm.setString(3, opt1 );
            pstm.setString(4, opt2 );
            pstm.setString(5, opt3);
            pstm.setString(6, opt4 );
            pstm.setString(7, correct );
            pstm.executeUpdate();
            pstm.close();
            return true;
        } catch (SQLException ex) {
            System.out.println("addQuestion catch: "+ex);
            return false;
        }
    }

    public ArrayList<Questions> getQuestions(String eName){
        ArrayList<Questions> list=new ArrayList<>();
        try {
            
            String sql="Select * from question where eName=?";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setString(1,eName);
            ResultSet rs=pstm.executeQuery();
            Questions question;
            while(rs.next()){
               question = new Questions(rs.getInt("id"),rs.getString("question"),
                    rs.getString("eName"),rs.getString("op1"),rs.getString("op2")
                    ,rs.getString("op3"),rs.getString("op4"),rs.getString("correct")
                    ); 
               list.add(question);
            }
            pstm.close();
        } catch (SQLException ex) {
            System.out.println("getQuestion catch: "+ex);
        }
        return list;
    }

    public boolean delQuestion(int qId){
        try {
            String sql="DELETE from question where id=?";
            PreparedStatement pstm=conn.prepareStatement(sql);
            pstm.setInt(1,qId);
            pstm.executeUpdate();
            pstm.close();
            return true;
        } catch (SQLException ex) {
            System.out.println("delQuestion catch: "+ex);
            return false;
        }
    }
   
}