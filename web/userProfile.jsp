<%-- 
    Document   : userProfile
    Created on : 27-Apr-2021, 4:18:59 pm
    Author     : Dhruv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="srcPackage.User"%>
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
  <link rel="stylesheet" href="css/admin.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText"
        aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarText">

        <ul class="navbar-nav fs-5">
          <li class="nav-item px-2">
            <a class="nav-link" aria-current="page" href="stdHome.jsp">Home</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link" aria-current="page" href="attendedExam.jsp">Attended Exam</a>
          </li>
        </ul>
        <ul class="navbar-nav fs-5 ms-auto">
          <li class="nav-item px-2">
            <a class="nav-link active" aria-current="page" href="userProfile.jsp?userId=<%= session.getAttribute("userId").toString()%>">Profile</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link text-danger" aria-current="page" href="controller.jsp?page=logout">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <%! public User user; %>  
  <%
    if(request.getParameter("userId") != null){
      user = pDAO.getUserDetails(request.getParameter("userId").toString());
      System.out.println(user.getUserName());
    }
  %>
  <form class="my-5" name="myForm" method="POST" action='controller.jsp'>
    <div class="container">
      <h1>Update Student</h1>
      <hr>
      <input type="hidden" name="page" value="update">

      <label for="uname"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="uname" id="uname" required>
  
      <label for="name"><b>Name</b></label>
      <input type="text" placeholder="Enter Name" name="name" id="name" required>
  
      <label for="email"><b>Email</b></label>
      <input type="email" placeholder="Enter Email" name="email" id="email">
  
      <label for="pass"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="pass" id="pass" required>
      <hr>
  
      <button type="submit" formaction="controller.jsp?page=update&uname=<%= user.getUserName()%>" class="registerbtn mx-4 updatebtn bg-success">Update</button>
      <button type="submit" formaction="controller.jsp?page=delete&uName=<%= user.getUserName()%>"  
              class="registerbtn ms-5 updatebtn bg-danger">Delete</button>
    </div>
    <script>
        document.getElementById("uname").value = '<%= user.getUserName()%>';
        document.getElementById("uname").disabled = true;
        document.getElementById("uname").style.cursor = 'not-allowed';
        document.getElementById("name").value = '<%= user.getName()%>';
        document.getElementById("email").value = '<%= user.getEmail()%>';
        document.getElementById("pass").value = '<%= user.getPassword()%>';
    </script>  
  </form>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
    
</body>
</html>