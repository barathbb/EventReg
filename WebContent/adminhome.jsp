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

function fetchapprovedevents()
{
	var ajax = new XMLHttpRequest();
	ajax.open("POST", "fetchevents.do?param=4", true);
	
	ajax.onreadystatechange = function()
	{
		if(ajax.readyState == 4)
			{
			document.getElementById("tab1").innerHTML=ajax.responseText;
			}
	}
	ajax.send(null);
}
	
function fetchpendingevents()
{
	var ajax = new XMLHttpRequest();
    ajax.open("POST", "fetchevents.do?param=5", true);
	ajax.onreadystatechange = function()
	{
		if(ajax.readyState == 4)
			{
			document.getElementById("tab2").innerHTML=ajax.responseText;
			}
	}
	ajax.send(null);
}
	
function fetchrejectedevents()
{
	
	var ajax = new XMLHttpRequest();
	ajax.open("POST", "fetchevents.do?param=6", true);
	
	ajax.onreadystatechange = function()
	{
		if(ajax.readyState == 4)
			{
			document.getElementById("tab3").innerHTML=ajax.responseText;
			}
	}
	ajax.send(null);
}

function fetchusers()
{
	
	var ajax = new XMLHttpRequest();
	ajax.open("POST", "fetchusers.do", true);
	
	ajax.onreadystatechange = function()
	{
		if(ajax.readyState == 4)
			{
			document.getElementById("tab4").innerHTML=ajax.responseText;
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
		
		if(tab == 1)
			{
			fetchapprovedevents();
			highlight(1);
			}
			
		if(tab == 2)
			{
			fetchpendingevents();
			highlight(2);
			}
		if(tab == 3)
			{
			fetchrejectedevents();
			highlight(3);
			}		
		if(tab == 4)
			{
			fetchusers();
			highlight(4);
			
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
					pagerefresh();
					}
			}
			ajax.send(null);
			}
	}

	function deleteaccount(eventid)
	{
		if(confirm("Are you sure you want to delete this account? "))
			{
			var ajax = new XMLHttpRequest();
			var url = new String("deleteaccount.do?userid="+eventid);
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
	
	function statuschange(eventid,status)
	{
		//alert(eventid + status);
		if(status=="A")
		{
			var dec = confirm("Are you sure you want to approve this event ? ");
			if(dec==true)
				{
				var aj = new XMLHttpRequest();
				aj.open("POST","changestatus.do?eventid="+eventid+"&status="+status);
				aj.onreadystatechange = function()
				{
					if(aj.readyState==4)
						{
						document.getElementById(eventid).innerHTML = "";
						document.getElementById(eventid).setAttribute("style", "height:0px;");
						pagerefresh();
						}
				}
				aj.send(null);
				}
		}
		
		if(status=="R")
		{
			var dec = confirm("Are you sure you want to reject this event ? ");
			if(dec==true)
				{
				var aj = new XMLHttpRequest();
				aj.open("POST","changestatus.do?eventid="+eventid+"&status="+status);
				aj.onreadystatechange = function()
				{
					if(aj.readyState==4)
					{	
						document.getElementById(eventid).innerHTML = "";
						pagerefresh();
					}
				}
				aj.send(null);
				}
		}
		
		if(status=="P")
		{
			var dec = confirm("Are you sure you want to put this event to Pending ? ");
			if(dec==true)
				{
				var aj = new XMLHttpRequest();
				aj.open("POST","changestatus.do?eventid="+eventid+"&status="+status);
				aj.onreadystatechange = function()
				{
					if(aj.readyState==4)
					{	
						document.getElementById(eventid).innerHTML = "";
						pagerefresh();
					}
				}
				aj.send(null);
				}
		}
	}
	
	function highlight(n)
	{
		if(n == 1)
		{
		document.getElementById("head1").setAttribute("style", "text-decoration:underline; font-weight:bold;");
		document.getElementById("head2").setAttribute("style", "text-decoration:none;");
		document.getElementById("head3").setAttribute("style", "text-decoration:none;");
		document.getElementById("head4").setAttribute("style", "text-decoration:none;");
		}
		if(n == 2)
		{
		document.getElementById("head1").setAttribute("style", "text-decoration:none;");
		document.getElementById("head2").setAttribute("style", "text-decoration:underline; font-weight:bold;");
		document.getElementById("head3").setAttribute("style", "text-decoration:none;");
		document.getElementById("head4").setAttribute("style", "text-decoration:none;");
		}
		if(n == 3)
		{
		document.getElementById("head1").setAttribute("style", "text-decoration:none;");
		document.getElementById("head2").setAttribute("style", "text-decoration:none;");
		document.getElementById("head3").setAttribute("style", "text-decoration:underline; font-weight:bold;");
		document.getElementById("head4").setAttribute("style", "text-decoration:none;");
		}
		if(n == 4)
		{
		document.getElementById("head1").setAttribute("style", "text-decoration:none;");
		document.getElementById("head2").setAttribute("style", "text-decoration:none;");
		document.getElementById("head3").setAttribute("style", "text-decoration:none;");
		document.getElementById("head4").setAttribute("style", "text-decoration:underline; font-weight:bold;");
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

<p class="menu"> <a href="#tab1" id="head1" class="tab" onclick="fetchapprovedevents();highlight(1);"> Approved events</a> <a href="#tab2" id="head2" class="tab" onclick="fetchpendingevents();highlight(2);">Pending events</a> <a href="#tab3" id="head3" class="tab" onclick="fetchrejectedevents();highlight(3);">Rejected Events</a> 
   <a href="#tab4" id="head4" class="tab" onclick="fetchusers();highlight(4);">All Users</a>  
   
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
    
    <p id="tab4">
    
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