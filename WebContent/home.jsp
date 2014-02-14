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
			}
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
		window.location.href=url;
	}
	
	function pagerefresh()
	{
		var url = new String(document.URL);
		var tab = url.substring(url.length - 1, url.length);
		
		if(url.lastIndexOf("#")<0)
		{
		tab = 1;
		document.getElementById("head1").click();
		return;
		}
		
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

<header id="all">

<jsp:include page="header.jsp"></jsp:include>

</header>

<div id="all">

<div class="example">

<div class="menu" style="margin-top:15px;"> <a href="#tab1" id="head1" class="tab" onclick="fetchallevents();highlight(1);">All events</a> <a href="#tab2" id="head2" class="tab" onclick="fetchregisteredevents();highlight(2);">Registered events</a> <a href="#tab3" id="head3" class="tab" onclick="fetchmyevents();highlight(3);">My Events</a> 
   </div>

    <div class="items">
    
     <p id="default"> <!-- by default, show no text --> </p>
     
     <p id="tab1" autofocus="on">  <!-- To view all events -->
     
     </p>
     
     <p id="tab2">

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