<%-- 
    Document   : AddExam
    Created on : 27-Apr-2021, 4:18:59 pm
    Author     : Dhruv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="srcPackage.ExamDetail"%>
<%@page import="srcPackage.Questions"%>
<%@page import="java.util.ArrayList"%>

<% if(session.getAttribute("userStatus") == null || session.getAttribute("userStatus").toString().equals("0")) { 
        response.sendRedirect("index.jsp");
    }%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
  
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
  
  <title>Online Examination System</title>
  <link rel="stylesheet" href="css/admin.css">
  <style>
      .small-input input[type=text]{
      padding: 2px;
      margin: 2px;
      font-size: 14px;
  }
  </style>
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
            <a class="nav-link" aria-current="page" href="viewStudents.jsp">Home</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link" aria-current="page" href="AddStudent.jsp">Add Student</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link" aria-current="page" href="viewExam.jsp">Exams</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link active" aria-current="page" href="AddExam.jsp">Add Exam</a>
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
  <%
      if(request.getSession().getAttribute("redierctedFlag")!=null){
  %>    <div class="alert alert-<%= request.getSession().getAttribute("redierctedFlag")%>" role="alert">
            <%= request.getSession().getAttribute("redirectedMessage") %>
        </div>
  <%
        request.getSession().removeAttribute("redierctedFlag");
        request.getSession().removeAttribute("redirectedMessage");
      }
  %>
  
  <form class="my-5" name="myForm" method="POST" action='controller.jsp'>
    <div style="width: 85%; position: relative;" class="container row">
      <div style="height: 100vh; position: sticky; top: 100px;" class="col-md-3 pe-3">
        <h1>Add Exam</h1>
        <hr>
        <input type="hidden" name="page" value="addExam">

        <label for="name"><b>Title</b></label>
        <input type="text" placeholder="Enter title" name="name" id="name" required>

        <label for="marks"><b>Marks</b></label>
        <input type="number" placeholder="Enter Total Marks" name="marks" min="5" id="marks" required>

        <label for="time"><b>Time</b></label>
        <input type="number" placeholder="Enter Total Time" name="time" min="1" id="time" required>

        <label for="noQuest"><b>No. of Questions</b></label>
        <input type="number" oninput="return generateQuestion(this.value)" placeholder="Enter No. of Questions" min="1" name="noQuest" id="noQuest" required>

        <button type="submit" class="registerbtn bg-success">Add</button>
      </div>
      <div style="border-left: 1px solid grey;" id="quest_sect" class="col-md-9">
        
      </div>
    </div>
    
  </form>
  <script>
      function generateQuestion(number){
          var quest_sect = document.getElementById("quest_sect");
          quest_sect.innerHTML = "";
          for(i=1; i<=number; i++){
            quest_sect.innerHTML += `<div class="row mb-2 border-bottom">
                                        <div class="ms-2 col-md-1">
                                            <h3>\${i}</h3>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="quest\${i}"><b>Question</b></label>
                                            <textarea id="quest\${i}" rows="5" name="quest\${i}" required placeholder="Enter Question"></textarea>
                                        </div>
                                        <div class="ms-2 col-md-4 small-input">
                                            <label><strong>Answer</strong></label><br>
                                            <input class="mb-2" type="text" placeholder="Enter option A" name="ans\${i}1" required id="ans\${i}1">
                                            <input class="mb-2" type="text" placeholder="Enter option B" name="ans\${i}2" required id="ans\${i}2">
                                            <input class="mb-2" type="text" placeholder="Enter option C" name="ans\${i}3" required id="ans\${i}3">
                                            <input class="mb-2" type="text" placeholder="Enter option D" name="ans\${i}4" required id="ans\${i}4">

                                            <label class="mt-1" for="correct\${i}"><strong>Correct Answer: </strong></label>
                                            <select class="form-select mb-2" required
                                                aria-label="Default select example" name="correct\${i}" id="correct\${i}">
                                                <option value="A">A</option>
                                                <option value="B">B</option>
                                                <option value="C">C</option>
                                                <option value="D">D</option>
                                            </select>
                                        </div>
                                    </div>`;
          }
      }
  </script>
  
</body>
</html>