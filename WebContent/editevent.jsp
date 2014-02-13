<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="MyPackage.*" %>

<%
    
if(request.getSession().getAttribute("User") == null)
	response.sendRedirect("index.jsp");

%>

<%

Connection conn = (Connection)session.getAttribute("Con");

//Integer UserId = ((User)session.getAttribute("User")).getUserId();

Event event= (Event)request.getAttribute("Event");
 
%>

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/newevent.css" />

<script type="text/javascript">


function showlimit()
{
	var regrow = document.getElementById("reg_limit");
	regrow.style.display = "table-row";
}

function hidelimit()
{
	var regrow = document.getElementById("reg_limit");
	regrow.style.display= "none";
}

function showeventtypemessage()
{
	var et = document.getElementById("Event_Type").value;
	var sen = document.getElementById("Event_Type_Message");
	//alert(et);
	if(et == "C")
	{
		sen.innerHTML = "Competition allow you to put scores for the participants";
	}
	if(et == "M")
	{
		sen.innerHTML = "Meetup doesn't allow scoring for your participants";
	}
	if(et == "W")
	{
		sen.innerHTML = "Workshop doesn't allow you to put scores for the participants";
	}
	if(et == "H")
	{
		sen.innerHTML = "Hackathon allow you to put scores for the participants";
	}
	
	document.getElementById("Message_Row").style.display="table-row";
}

function removeMessage()
{
	var sen = document.getElementById("Event_Type_Message");
	sen.innerHTML = "";
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

function validate()
{
	var isName=false,isDescription=false,isLimit=false;
	var name = new String(document.getElementById("Name").value);
	var description = new String(document.getElementById("Description").value);
	var limit_no = document.getElementById("Limit_No");
	var limit_yes = document.getElementById("Limit_Yes");
	
	
	if(name.length==0)
	{
		alert("Please enter Name");
		return false;
	}
	else
		isName=true;
	
	if(description.length == 0)
		{
		alert("Please enter Description");
		return false;
		}
	else
		isDescription = true;
	
	if(limit_no.checked)
		isLimit=true;
	else if(limit_yes.checked)
		{
		var reg_limit = new String(document.getElementById("Registration_Limit").value);
		
		if(reg_limit.length == 0 || new Number(reg_limit) == 0)
			{
			alert("Please enter registration limit");
			return false;
			}
		else if(isNan(reg_limit))
			{
			alert("Enter a valid registration limit");
			return false;
			}
		else
			isLimit=true;
		}
	
	
	if(isName && isDescription && isLimit)
		{
		return true;
		}
	else
		return false;
	
}


</script>

</head>

<body>

<div id="all">

<a href="home.do#tab1"><button type="button"> Go Home!</button></a>

<h1>
Edit Event - <%=event.getName() %>
</h1>

<button onclick="deleteevent(<%=event.getEventId()%>);" style="float:right;margin-right:80px;">  Delete event!</button> <br/> <br/>

<form onsubmit="return validate();" action="finaliseeditevent.do" method="post" >
<table border="0" style="margin:0 auto;">

<input type="hidden" name="eventid" value="<%=event.getEventId() %>" />

<tr>
<td>
Event name*:
</td>
<td>
<input type="text" name="name" id="Name" size="30" autofill="off" value="<%=event.getName()%>"/>
</td>
</tr>

<tr>
<td>
Description*:
</td>
<td>
<textarea name="description" id="Description" cols="30" rows="5"  autofill="off"><%=event.getDescription() %></textarea>
</td>
</tr>

<tr>
<td> Event Type* : 
</td>
<td>

<select onchange="showeventtypemessage();" name="event_type" id="Event_Type" width="30" onblur="removeMessage();">

<optgroup>

<%=Utils.getEventTypesWithSelected(event.getEvent_Type(), conn) %>

</optgroup>

</select>

</td>
</tr>

<tr style="display:none;" id="Message_Row">
<td colspan="2" align="Center"> <span id="Event_Type_Message"> </span>
</td>
</tr>


<% 
//String temp = Utils.getStatus(event.getEventId(), conn);

//if(temp.equals("R")) { %>

<!--  

<tr>
<td>
Event location*:
</td>
<td>

<select name="Location" id="Location"> 

<optgroup>

 <% //Utils.getLocationsWithSelected(event.getLocation(), conn) %>

</optgroup>

</select>

</td>
</tr>

<% //} %>

<tr>

-->

<td> Do you want limited registration* ? 
</td>
<td>

<% 

 if(event.getRegistration_Limit() == -1)
 {
	 

%>


<input type="radio" id="Limit_No" name="limit" value="N" onclick="hidelimit();" checked="true" /> No

<input type="radio" id="Limit_Yes" name="limit" value="Y" onclick="showlimit();" /> Yes

<%
 }
 else
 {
%>

<input type="radio" id="Limit_Yes" name="limit" value="Y" onclick="showlimit();" checked="true" /> Yes

<input type="radio" id="Limit_No" name="limit" value="N" onclick="hidelimit();"  /> No
<% } %>

</td>
</tr>

<% if(event.getRegistration_Limit() == -1) 
	{ %>


<tr id="reg_limit" style="display:none;">
<td> Enter the registration limit : 
</td>
<td> <input type="text" name="registration_limit" id="Registration_Limit" cols="30" />
</td>
</tr>

<% } else  { %>

<tr id="reg_limit" style="">
<td> Enter the registration limit : 
</td>
<td> <input type="text" name="registration_limit" id="Registration_Limit" cols="30" value="<%=event.getRegistration_Limit()%>" autocomplete="off" />
</td>
</tr>

<% } %>

<tr>
<td colspan="2"  align="center">

<button type="submit"> Update! </button> 

</td>
</tr>

</table>

</form>

</div>

</body>
</html>