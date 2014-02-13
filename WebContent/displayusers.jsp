<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
    pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*" import="MyPackage.*" %>
    
	<%
	HashMap<Integer,String> userdetails = (HashMap<Integer,String>)request.getAttribute("UserDetails");
	
	for(Integer i : userdetails.keySet())
	{
		
	%>

	<div class="oneevent" style="border-bottom-style:none;border-bottom-width:0px; height:50px;">

	<div class="eventdetails">
	
	<div class="details">

	<h2> <a class="eventname" href="showuser.do?userid=<%=i %>" > <% out.write(userdetails.get(i)); %>   </a> </h2> 
	 
	</div>

	</div>

	<div class="eventcontrols">
	
	<a href="fulleditprofile.do?userid=<%=i%>"><button type="button"> Edit profile </button></a>
	
	</div>
	
	</div>
	
	<% 

	}

	%>
