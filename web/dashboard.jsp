<%-- 
    Document   : dashboard
    Created on : 27-Apr-2021, 4:18:59 pm
    Author     : Dhruv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="pDAO" class="srcPackage.DatabaseClass" scope="page"/>

<% 
   if(session.getAttribute("userStatus")!=null){
        String loginConfirm=session.getAttribute("userStatus").toString();
        if(loginConfirm.equals("1")){
            
            if(pDAO.getUserType(session.getAttribute("userId").toString()).equals("admin")){
                response.sendRedirect("viewStudents.jsp"); 

            }else if(pDAO.getUserType(session.getAttribute("userId").toString()).equals("student")){
                response.sendRedirect("stdHome.jsp");
            }

        }else if(!loginConfirm.equals("1")){
            response.sendRedirect("index.jsp");
        }
    }else response.sendRedirect("index.jsp");
%>