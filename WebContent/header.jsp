<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="MyPackage.User" %>



<img src="img/logo.png" height="50" width="200" style="margin-top:10px;margin-left:10px;" align="left" />
<br/> <br/> <br/>

<a href="about.jsp" style="text-decoration:none;">
<h1 align="center" >
Event Registration
</h1>
</a>

<br/>

<a href="signout.do"> <b> <span style="float:right; margin-left:10px;"> Sign Out!  </span> </b> </a>

<!-- 

<a href="showuser.do?userid=<%=((User)request.getSession().getAttribute("User")).getUserId() %>" > <button type="button" style="float:right;">View my profile </button> </a>

 -->

<span style="float:right;"> <b> <a href="about.jsp" style="text-decoration:none;"> About Us &nbsp; | &nbsp; </a> </b> </span>

<span style="float:right;"> Welcome <b> <a href="showuser.do?userid=<%=((User)session.getAttribute("User")).getUserId()%>"> <% out.write(((User)session.getAttribute("User")).getName()); %>  &nbsp;| </b> &nbsp;  </a></span>