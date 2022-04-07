<%-- 
    Document   : index
    Created on : 27-Apr-2021, 4:18:59 pm
    Author     : Dhruv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
    <title>Online Examination System</title>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
    <div class="container">
    <div style="margin-top: 50px;" class="row">
        <div class="col-md-6 mx-auto p-0">
            <div class="card">
                <div class="login-box">
                    <div class="login-snip"> <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1" class="tab">Login</label> <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">Sign Up</label>
                        <div class="login-space">
                            <div class="login">
                                <form method='post' action="controller.jsp">
                                    <input type="hidden" name="page" value="login"> 
                                    <div class="group"> <label for="user" class="label">Username</label> <input id="user" name="username" type="text" class="input" placeholder="Enter your username"> </div>
                                    <div class="group"> <label for="pass" class="label">Password</label> <input id="pass" name="password" type="password" class="input" data-type="password" placeholder="Enter your password"> </div>
                                    <% 
                                    if(request.getSession().getAttribute("userStatus")!=null){
                                        System.out.println("its called");
                                        if(request.getSession().getAttribute("userStatus").equals("-1")){  
                                            System.out.println("now inside");
                                    %>
                                    <p style="color: rgba(255, 255, 51, 1);font-size: 17px">username or password is incorrect</p>
                                    <br>
                                    <%
                                        }else if(request.getSession().getAttribute("userStatus").equals("-2")){ 
                                    %>
                                    <script>alert("User already exists");</script>
                                    <p style="color: rgba(255, 255, 51, 1);font-size: 17px">User already exists<br>Enter username and password to login</p>
                                    <br>
                                    <%
                                        }
                                    }
                                    %>
                                    <div class="group"> <input type="submit" class="button" value="Sign In"> </div>
                                    <div class="hr"></div>
                                </form>
                            </div>
                            <div class="sign-up-form">
                                <form name="signUp" onsubmit="return validateForm(event)" method='post' action="controller.jsp">
                                    <input type="hidden" name="page" value="register">
                                    <div class="group"> <label for="user" class="label">Username</label> <input id="user" name="uname" type="text" class="input" placeholder="Create your Username"> </div>
                                    <div class="group"> <label for="name" class="label">Name</label> <input id="name" name="name" type="text" class="input" placeholder="Enter your Name"> </div>
                                    <div class="group"> <label for="email" class="label">Email Address</label> <input id="email" name="email" type="text" class="input" placeholder="Enter your email address"> </div>
                                    <div class="group"> <label for="pass" class="label">Password</label> <input id="pass" name="pass" type="password" class="input" data-type="password" placeholder="Create your password"> </div>
                                    <div class="group"> <label for="rPass" class="label">Repeat Password</label> <input id="rPass" name="rPass" type="password" class="input" data-type="password" placeholder="Repeat your password"> </div>
                                    <span id="passloc" class="text-danger p-1"></span>
                                    <div class="group"> <input type="submit" class="button" value="Sign Up"> </div>
                                    <div class="hr"></div>
                                    <div class="foot"> <label for="tab-1">Already Member?</label> </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
    
    <script>
        function validateForm(e){
            var pass = document.signUp.pass.value;
            var rPass = document.signUp.rPass.value;
            console.log(pass + "->"+rPass);
            if(pass !== rPass){
                e.preventDefault();
                document.getElementById("passloc").innerHTML="Password doesn't match"; 
            console.log(pass + "->not"+rPass);
                return false;  
            }else{
                document.getElementById("passloc").innerHTML=""; 
                return true; 
            } 
        }
    </script>
  </body>
</html>