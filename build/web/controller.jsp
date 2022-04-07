<%-- 
    Document   : controller
    Created on : 27-Apr-2021, 4:18:59 pm
    Author     : Dhruv
--%>

<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.util.*"%>
<%@page import="srcPackage.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! private DatabaseClass pDAO = new DatabaseClass();%>


<%! private  String getFormatedDate(String date){
        LocalDate localDate=LocalDate.parse(date);
        return localDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
    }%> 
<%
if(request.getParameter("page").toString().equals("login")){
    if(pDAO.loginValidate(request.getParameter("username").toString(), request.getParameter("password").toString())){
        session.setAttribute("userStatus", "1");
        session.setAttribute("userId",request.getParameter("username"));
        response.sendRedirect("dashboard.jsp");
    }else{
        request.getSession().setAttribute("userStatus", "-1");
        response.sendRedirect("index.jsp");
    }
}else if(request.getParameter("page").toString().equals("register")){
        
    String name =request.getParameter("name");
    String uName=request.getParameter("uname");
    String pass=request.getParameter("pass");
    String email =request.getParameter("email");
    
    if(pDAO.addNewStudent(name,uName,pass,email,"student")){
        session.setAttribute("userStatus", "1");
        session.setAttribute("userId",request.getParameter("uname"));
        response.sendRedirect("dashboard.jsp");
    }else{
        request.getSession().setAttribute("userStatus", "-2");
        response.sendRedirect("index.jsp");
    }
}else if(request.getParameter("page").toString().equals("addUser")){
        
    String name =request.getParameter("name");
    String uName=request.getParameter("uname");
    String pass=request.getParameter("pass");
    String email =request.getParameter("email");
    String type =request.getParameter("type");
    
    if(pDAO.addNewStudent(name, uName, pass, email, type)){
        session.setAttribute("redierctedFlag","success");
        session.setAttribute("redirectedMessage","User successfully added");
    }else{
        session.setAttribute("redierctedFlag","danger");
        session.setAttribute("redirectedMessage","User already exists");
    }
    response.sendRedirect("AddStudent.jsp");
    
}else if(request.getParameter("page").toString().equals("update")){
        
    String name =request.getParameter("name");
    String uName=request.getParameter("uname");
    String pass=request.getParameter("pass");
    String email =request.getParameter("email");
    String type =request.getParameter("type");
    if(type == null ){
        type = "student";
    }
    
    pDAO.updateStudent(name, uName, pass, email, type);
    response.sendRedirect("dashboard.jsp");
    
}else if(request.getParameter("page").toString().equals("delete")){
    String uName=request.getParameter("uName");
    String userId = request.getSession().getAttribute("userId").toString();
    
    pDAO.delUser(uName);
    if(uName.equals(userId)){
        System.out.println("Delete");
        session.removeAttribute("userId");
        session.removeAttribute("userStatus");
        response.sendRedirect("index.jsp");
    }else{
        response.sendRedirect("viewStudents.jsp");
    }
}else if(request.getParameter("page").toString().equals("addExam")){
        
    String name =request.getParameter("name");
    int marks=Integer.parseInt(request.getParameter("marks"));
    String time=request.getParameter("time");
    int qNo = Integer.parseInt(request.getParameter("noQuest"));
    
    if(pDAO.addNewExam(name, marks, time)){
        for(int i = 1; i <= qNo; i++){
            String quest = request.getParameter("quest"+i);
            String ans1 = request.getParameter("ans"+i+"1");
            String ans2 = request.getParameter("ans"+i+"2");
            String ans3 = request.getParameter("ans"+i+"3");
            String ans4 = request.getParameter("ans"+i+"4");
            String correct = request.getParameter("correct"+i);
            pDAO.addQuestion(name,quest,ans1,ans2,ans3,ans4,correct);
        }
        session.setAttribute("redierctedFlag","success");
        session.setAttribute("redirectedMessage","Exam successfully added");
    }
    else{
        session.setAttribute("redierctedFlag","danger");
        session.setAttribute("redirectedMessage","Exam with same name exists");
    }
    response.sendRedirect("AddExam.jsp");
    
}else if(request.getParameter("page").toString().equals("deleteExam")){
    String eName = request.getParameter("eName");
    pDAO.delExam(eName);
    response.sendRedirect("viewExam.jsp");
    
}else if(request.getParameter("page").toString().equals("deleteQuestion")){
    int qId = Integer.parseInt(request.getParameter("qId"));
    String eName = request.getParameter("eName");
    if(pDAO.delQuestion(qId)){
        session.setAttribute("redierctedFlag","success");
        session.setAttribute("redirectedMessage","Question deleted successfully");
    }
    else{
        session.setAttribute("redierctedFlag","danger");
        session.setAttribute("redirectedMessage","Error occur at the server. Try Again");
    }
    response.sendRedirect("viewQuestion.jsp?eName="+eName);
}else if(request.getParameter("page").toString().equals("submitExam")){
    String eName = request.getParameter("eName");
    String username = session.getAttribute("userId").toString();
    String date = getFormatedDate(LocalDate.now().toString());
    String time = request.getParameter("time");
    int tMarks = Integer.parseInt(request.getParameter("tMarks"));
    int totalQuest = Integer.parseInt(request.getParameter("totalQuest"));
    int obtMarks = 0;
    
    for(int i=0; i<totalQuest; i++){
        String ans = request.getParameter("ans"+i);
        ans = ans== null ? "": ans;
        String correct = request.getParameter("correct"+i);
        obtMarks += (ans.equalsIgnoreCase(correct)) ? 1 : 0;
    }
    obtMarks = obtMarks*tMarks/totalQuest;
    pDAO.addNewExamRecord(username,eName,tMarks,obtMarks,time,date);
    response.sendRedirect("attendedExam.jsp");
    
}else if(request.getParameter("page").toString().equals("addQuestion")){
    String eName = request.getParameter("eName");
    String quest = request.getParameter("quest");
    String ans1 = request.getParameter("ans1");
    String ans2 = request.getParameter("ans2");
    String ans3 = request.getParameter("ans3");
    String ans4 = request.getParameter("ans4");
    String correct = request.getParameter("correct");
    
    if(pDAO.addQuestion(eName,quest,ans1,ans2,ans3,ans4,correct)){
        session.setAttribute("redierctedFlag","success");
        session.setAttribute("redirectedMessage","Question added successfully");
    }
    else{
        session.setAttribute("redierctedFlag","danger");
        session.setAttribute("redirectedMessage","Error occur at the server. Try Again");
    }
    response.sendRedirect("viewQuestion.jsp?eName="+eName);
    
}else if(request.getParameter("page").toString().equals("logout")){
    session.setAttribute("userStatus","0");
    response.sendRedirect("index.jsp");
}
%>