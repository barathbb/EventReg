<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="MyPackage.User" %>

<html>

<head> 
<link rel="stylesheet" type="text/css" href="css/header.css" />
</head>

<body>

<a href="home.do">
<img src="img/logo.png" height="50" width="200" style="margin-top:10px;margin-left:10px;" align="left" alt="Go home" />
</a>

<br/> <br/> <br/>

<!-- 

<a href="home.do#tab1" style="text-decoration:none;">
<h2 align="center" >
Event Registration
</h2>
</a>

-->

<br/>

<a href="signout.do"> <b> <span style="float:right; margin-left:10px; margin-right:10px;" > Sign Out!  </span> </b> </a>

<span style="float:right;"> <b> <a href="about.jsp" style="text-decoration:none;"> About Us &nbsp; | &nbsp; </a> </b> </span>

<span style="float:right;" id="profile_name"> <b> <a href="showuser.do?userid=<%=((User)session.getAttribute("User")).getUserId()%>"> <% out.write(((User)session.getAttribute("User")).getName()); %>  &nbsp;| </b> &nbsp;  </a></span>

</body>

</html>