<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="MyPackage.*" import="java.sql.*" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%
    
if(request.getSession().getAttribute("User") == null)
	response.sendRedirect("index.jsp");

%>
    
    
    <% try {  %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Home </title>

<link rel="stylesheet" type="text/css" href="css/home.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />

<script type="text/javascript" src="js/regunreg.js"></script>

<script type="text/javascript">

function signout()
{
	window.location.href="signout.do"; 
}

function fetchallevents()
{
	var ajax = new XMLHttpRequest();
	ajax.open("POST", "fetchevents.do?param=1", true);
	
	ajax.onreadystatechange = function()
	{
		if(ajax.readyState == 4)
			{
			document.getElementById("tab1").innerHTML=ajax.responseText;
			//alert(ajax.responseText);
			}
		//alert(ajax.responseText);
	}
	ajax.send(null);
}
	
function fetchregisteredevents()
{
	var ajax = new XMLHttpRequest();
    ajax.open("POST", "fetchevents.do?param=2", true);
	ajax.onreadystatechange = function()
	{
		if(ajax.readyState == 4)
			{
			document.getElementById("tab2").innerHTML=ajax.responseText;
			}
		//alert(ajax.responseText);
	}
	ajax.send(null);
}
	
function fetchmyevents()
{
	
	var ajax = new XMLHttpRequest();
	ajax.open("POST", "fetchevents.do?param=3", true);
	
	ajax.onreadystatechange = function()
	{
		if(ajax.readyState == 4)
			{
			document.getElementById("tab3").innerHTML=ajax.responseText;
			}
			//alert(ajax.responseText);
	}
	ajax.send(null);
}
	
	function remove(element)
	{
		element.innerHTML="Registered";		
	}
	
	function viewreport(eventID)
	{
		var url = new String("report.do?eventid="+eventID);
		//var newtab = window.open(url);
		//newtab.focus();	
		window.location.href=url;
	}
	
	function pagerefresh()
	{
		var url = new String(document.URL);
		var tab = url.substring(url.length - 1, url.length);
		if(tab ==1)
			{
			fetchallevents();
			highlight(1);
			hide23();
			}
			
		if(tab == 2)
			{
			fetchregisteredevents();
			highlight(2);
			hide31();
			}
		if(tab == 3)
			{
			fetchmyevents();
			highlight(3);
			hide12();
			}		
	}
	
	function deleteevent(eventid)
	{

		if(confirm("Are you sure you want to delete this event? "))
			{
			var ajax = new XMLHttpRequest();
			var url = new String("deleteevent.do?eventid="+eventid);
			ajax.open("POST",url,true);		
			ajax.onreadystatechange = function()
			{
				if(ajax.readyState == 4)
					{
					alert("The event has been deleted");
					window.location.href = "home.do#tab3";
					}
			}
			ajax.send(null);
			}
	}

	function deleteaccount(userid)
	{
		if(confirm("Are you sure you want to delete this account? "))
			{
			var ajax = new XMLHttpRequest();
			var url = new String("deleteaccount.do?userid="+userid);
			ajax.open("POST",url,true);		
			ajax.onreadystatechange = function()
			{
				if(ajax.readyState == 4)
					{
					alert("The account has been deleted");
					pagerefresh();
					}
			}
			ajax.send(null);
			}
	}
	
	
	
	function highlight(n)
	{
		if(n == 1)
		{
		document.getElementById("head1").setAttribute("style", "text-decoration:underline; font-weight:bold;");			
		document.getElementById("head2").setAttribute("style", "text-decoration:none;");
		document.getElementById("head3").setAttribute("style", "text-decoration:none;");
		}
		if(n == 2)
		{
		document.getElementById("head1").setAttribute("style", "text-decoration:none;");
		document.getElementById("head2").setAttribute("style", "text-decoration:underline; font-weight:bold;");
		document.getElementById("head3").setAttribute("style", "text-decoration:none;");
		}
		if(n == 3)
		{
		document.getElementById("head1").setAttribute("style", "text-decoration:none;");
		document.getElementById("head2").setAttribute("style", "text-decoration:none;");
		document.getElementById("head3").setAttribute("style", "text-decoration:underline; font-weight:bold;");
		}
	}
	
</script>

</head>
<body onload="pagerefresh();">

<div id="all">

<a href="About.jsp" style="text-decoration:none;">
<h1 align="center" >
Event registration
</h1>
</a>

<br/>

<a href="signout.do"> <button style="float:right; margin-left:10px;"> Sign Out!  </button> </a>

<a href="showuser.do?userid=<%=((User)request.getSession().getAttribute("User")).getUserId() %>" > <button type="button" style="float:right;">View my profile </button> </a>



<h3>  Welcome <a href="showuser.do?userid=<%=((User)session.getAttribute("User")).getUserId()%>"> <% out.write(((User)session.getAttribute("User")).getName()); %> </a></h3>

<div class="example">

<p class="menu"> <a href="#tab1" id="head1" class="tab" onclick="fetchallevents();highlight(1);">All events</a> <a href="#tab2" id="head2" class="tab" onclick="fetchregisteredevents();highlight(2);">Registered events</a> <a href="#tab3" id="head3" class="tab" onclick="fetchmyevents();highlight(3);">My Events</a> 
   </p>

    <div class="items">
    
     <p id="default"><!-- by default, show no text --></p>
     
     <p id="tab1" autofocus="on">
     <!-- To view all events -->

     </p>
     
     <p id="tab2">
     
     <p id="tab21"> </p>

     </p>
     
     <p id="tab3">
    </p>
    
    </div>
    
   </div>

</div>

</body>

</html>

<% } catch(Exception e) 
{
	out.write(e.getMessage());
}%>