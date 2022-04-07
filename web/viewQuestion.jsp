<%-- 
    Document   : viewQuestion
    Created on : 27-Apr-2021, 4:18:59 pm
    Author     : Dhruv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="srcPackage.Questions"%>
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
  <link href="css/viewQuestion.css" rel="stylesheet">
</head>
<body style="background-color: #F1F1F1;">
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
          </li>s
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
    <div id="table-container" style="position: relative;" class="container my-5">
    <h2><strong><%= request.getParameter("eName")%></strong></h2>
    <div style="position: absolute; right: 0; top: 0px;">
        <a href="controller.jsp?page=deleteExam&eName=<%= request.getParameter("eName")%>" class="btn btn-danger">Delete Exam</a>
        <a id="addQuestion" onclick="return addQuestion()" class="btn btn-primary">Add Question</a>
    </div>
    <form name="myForm" method="POST" action="controller.jsp">
        <input type="hidden" name="page" value="addQuestion">
        <input type="hidden" name="eName" value="<%= request.getParameter("eName")%>">
        <div class="table-responsive">
          <table id="myTable" class="table table-hover table-striped">
            <thead class="bg-warning">
              <tr>
                <th>Question</th>
                <th>Option A</th>
                <th>Option B</th>
                <th>Option C</th>
                <th>Option D</th>
                <th>Correct Answer</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr style="display: none;" id="addRow">
                                <td><input name="quest" placeholder="Enter Question" required></td>
                                <td><input class="mb-2" type="text" placeholder="Enter option A" name="ans1" required></td>
                                <td><input class="mb-2" type="text" placeholder="Enter option B" name="ans2" required></td>
                                <td><input class="mb-2" type="text" placeholder="Enter option C" name="ans3" required></td>
                                <td><input class="mb-2" type="text" placeholder="Enter option D" name="ans4" required></td>
                                <td>
                                    <select class="form-select mt-3" aria-label="Default select example" name="correct" required>
                                        <option value="A">A</option>
                                        <option value="B">B</option>
                                        <option value="C">C</option>
                                        <option value="D">D</option>
                                    </select>
                                </td>
                                <td>
                                    <button type="submit" onclick="return add()" class="registerbtn bg-success">Add</button>
                                </td>
                           </tr>
              <%
                ArrayList<Questions> list=pDAO.getQuestions(request.getParameter("eName"));
                Questions question;
                for(int i=0;i<list.size();i++){
                    question= list.get(i);
              %>
              <tr>
                <td><%=question.getQuestion() %></td>
                <td><%=question.getOpt1() %></td>
                <td><%=question.getOpt2() %></td>
                <td><%=question.getOpt3() %></td>
                <td><%=question.getOpt4() %></td>
                <td><%=question.getCorrect() %></td>
                <td><a href="controller.jsp?page=deleteQuestion&eName=<%= question.getEName()%>&qId=<%= question.getQuestionId()%>" 
                       class="btn btn-danger">Delete</a></td>
              </tr>
              <%
                } 
              %>
            </tbody>
          </table>
        </div>
    </form>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
  <script>
      var visible = false;
      function addQuestion(){
        var addRow = document.getElementById('addRow');
        if(!visible){
            addRow.style.display = "table-row";
            visible = true;
        }else{
            addRow.style.display = "none";
            visible = false;
        }
      } 
  </script>
</body>
</html>