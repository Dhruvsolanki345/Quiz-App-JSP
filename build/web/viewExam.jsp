<%-- 
    Document   : viewExam
    Created on : 27-Apr-2021, 4:18:59 pm
    Author     : Dhruv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="srcPackage.ExamDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page import="srcPackage.DatabaseClass"%>
<%! private DatabaseClass pDAO = new DatabaseClass();%>

<% if(session.getAttribute("userStatus") == null || session.getAttribute("userStatus").toString().equals("0")) { 
        response.sendRedirect("index.jsp");
    }%>
    

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
  <title>Online Examination System</title>
</head>
<body class="bg-light">
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText"
        aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarText">

        <ul class="navbar-nav fs-5">
          <li class="nav-item px-2">
            <a class="nav-link" aria-current="page" href="viewStudents.jsp">Home</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link" aria-current="page" href="AddStudent.jsp">Add Student</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link active" aria-current="page" href="viewExam.jsp">Exams</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link" aria-current="page" href="AddExam.jsp">Add Exam</a>
          </li>
        </ul>
        <ul class="navbar-nav fs-5 ms-auto">
          <li class="nav-item px-2">
            <a class="nav-link" aria-current="page" href="AddStudent.jsp?userId=<%= session.getAttribute("userId").toString()%>">Profile</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link text-danger" aria-current="page" href="controller.jsp?page=logout">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
    <div style="position: relative;" class="container my-5">
    <h2><strong>Currently Active Exams</strong></h2>
    <a href="AddExam.jsp" style="position: absolute; right: 0; top: 0px;" class="btn btn-primary">Add Exam</a>
    <div class="table-responsive">
      <table class="table table-hover table-striped">
        <thead class="bg-warning">
          <tr>
            <th>Title</th>
            <th>Total Marks</th>
            <th>Time Available</th>
            <th colspan="2"></th>
          </tr>
        </thead>
        <tbody>
          <%
            ArrayList<ExamDetail> list=pDAO.getAllExam();
            ExamDetail exam;
            for(int i=0;i<list.size();i++){
                exam= list.get(i);
          %>
          <tr>
            <td><%=exam.getEName() %></td>
            <td><%=exam.getTMarks() %></td>
            <td><%=exam.getTime() %> minutes</td>
            <td><a href="examHistory.jsp?eName=<%= exam.getEName()%>" 
                   class="btn btn-secondary">History</a></td>
                   <td><a href="viewQuestion.jsp?eName=<%= exam.getEName()%>" class="btn btn-info">View</a></td>
          </tr>
          <%
            } 
          %>
        </tbody>
      </table>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
  
</body>
</html>