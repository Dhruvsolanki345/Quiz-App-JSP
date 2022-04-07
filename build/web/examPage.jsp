<%-- 
    Document   : examPage
    Created on : 27-Apr-2021, 4:18:59 pm
    Author     : Dhruv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="srcPackage.ExamDetail"%>
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
  
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
  
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
            <a class="nav-link" aria-current="page" href="userProfile.jsp?userId=<%= session.getAttribute("userId").toString()%>">Profile</a>
          </li>
          <li class="nav-item px-2">
            <a class="nav-link text-danger" aria-current="page" href="controller.jsp?page=logout">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  
    <form class="my-3" id="myForm" name="myForm" method="POST" action='controller.jsp'>
    <div style="width: 85%; position: relative;" class="container row">
      <div style="height: 100vh; position: sticky; top: 100px;" class="col-md-3 p-3">
        <% ExamDetail exam = pDAO.getSelectedExam(request.getParameter("eName"));%>
        <h2><%= exam.getEName()%></h2>
        <hr>
        <h5>Time limit: <%= exam.getTime()%> minutes</h5>
        <h5 class="my-4">Total Marks: <%= exam.getTMarks()%></h5>
        <h5>Remaining Time: 
            <span  style="font-size: 20px;background: rgba(255,0,77,0.38);border-radius: 5px;
                  padding: 10px;box-shadow: 2px -2px 6px 0px;" id="remainingTime"></span>
        </h5> 
       
        <input type="hidden" name="page" value="submitExam">
        <input type="hidden" name="eName" value="<%= exam.getEName()%>">
        <input type="hidden" name="tMarks" value="<%= exam.getTMarks()%>">
        <input type="hidden" name="time" value="<%= exam.getTime()%>">
        
        <button type="submit" class="mt-5 registerbtn bg-success">Submit</button>
      </div>
      <div style="border-left: 1px solid grey;" id="quest_sect" class="col-md-9">
        <%
          ArrayList<Questions> list = pDAO.getQuestions(request.getParameter("eName"));
          Questions question;
        %><input type="hidden" name="totalQuest" value="<%= list.size()%>"><%
          for(int i=0; i<list.size(); i++){
          question = list.get(i);
        %>
            <div class="row mb-3 border-bottom">
                <div class="ms-2 col-md-1">
                  <h3><%= i+1%></h3>
                </div>
                <div style='position: relative;' class="col-md-10 mb-2">
                    <input type="hidden" name="correct<%= i%>" value="<%= question.getCorrect()%>">
                    <h5 class="mb-2"><%= question.getQuestion()%></h5>
                    <span>
                    <input class="m-2" type="radio" name="ans<%= i%>" value="A" id="ans<%= i%>1">
                    <label class="me-5" for="ans<%= i%>1">A. <%= question.getOpt1()%></label>
                    </span>
                    <span style='position: absolute; left: 500px;'>
                    <input class="m-2 ms-5" type="radio" name="ans<%= i%>" value="B" id="ans<%= i%>2">
                    <label for="ans<%= i%>2">B. <%= question.getOpt2()%></label>
                    </span><br>
                    <span>
                    <input class="m-2" type="radio" name="ans<%= i%>" value="C" id="ans<%= i%>3">
                    <label class="me-5" for="ans<%= i%>3">C. <%= question.getOpt3()%></label>
                    </span>
                    <span style='position: absolute; left: 500px;'>
                    <input class="m-2 ms-5" type="radio" name="ans<%= i%>" value="D" id="ans<%= i%>4">
                    <label for="ans<%= i%>4">D. <%= question.getOpt4()%></label><br>
                    </span>
                </div>
              </div>
        <%
          }
        %>
      </div>
    </div>
    
  </form>
  <script>
        document.getElementsByTagName("nav")[0].style.display = "none";
        var time = <%= Integer.parseInt(exam.getTime())%>;
        var x;
        document.getElementById("remainingTime").innerHTML =  time+" : 00";
        time--;
        sec=59; 
        x= window.setInterval(timer, 1000);    
        function timer(){

            if (time < 0) {
                clearInterval(x);
                console.log("Finish");
                document.getElementById("remainingTime").innerHTML = "00 : 00";
                document.getElementById("myForm").submit();
                
            }else{
                document.getElementById("remainingTime").innerHTML =  time+" : "+sec;
                if(sec===0){
                    sec=60;
                    time--;
                }
            }
            sec--;
        }
//        window.addEventListener("beforeunload", (e) =>{
//            e.preventDefault();
//            document.getElementById("myForm").submit();
//            e.return_value = "Don't return";
//        });
  </script>
  
</body>
</html>