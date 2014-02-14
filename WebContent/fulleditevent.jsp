<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="MyPackage.*" %>

<%

Connection conn = (Connection)session.getAttribute("Con");

Integer UserId = ((User)session.getAttribute("User")).getUserId();

Event event= (Event)request.getAttribute("Event");

Timestamp startDate,endDate;

startDate = event.getStart_Date();
endDate = event.getEnd_Date();

String[] values = startDate.toString().split(" ");

String startDateValues = values[0];

String startTimeValues = values[1];

values = endDate.toString().split(" ");

String endDateValues = values[0];

String endTimeValues = values[1];

startTimeValues = startTimeValues.substring(0, startTimeValues.lastIndexOf("."));

endTimeValues = endTimeValues.substring(0, endTimeValues.lastIndexOf("."));

//System.out.print(startDateValues + "\t" + startTimeValues);

String[] startDateArr, endDateArr, startTimeArr, endTimeArr;

startDateArr = startDateValues.split("-");
endDateArr = endDateValues.split("-");

startTimeArr = startTimeValues.split(":");
endTimeArr = endTimeValues.split(":");

boolean start_AMPM=false,end_AMPM=false;

if(Integer.parseInt(endTimeArr[0]) > 12)
{
	end_AMPM = true;
	endTimeArr[0] = new Integer(Integer.parseInt(endTimeArr[0]) - 12).toString();
}

if(Integer.parseInt(startTimeArr[0]) > 12)
{
	start_AMPM = true;
	startTimeArr[0] = new Integer(Integer.parseInt(startTimeArr[0]) - 12).toString();
}

if(startTimeArr[0].length() == 1)
	startTimeArr[0] = "0" + startTimeArr[0];

if(endTimeArr[0].length() == 1)
	endTimeArr[0] = "0" + endTimeArr[0];

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
				window.location.href = "home.jsp#tab3";
				}
		}
		ajax.send(null);
		}
}


function checkDateOrder()
{
	var smonth = document.getElementById("Start_Month").value;
	var sday = document.getElementById("Start_Day").value;
	var syear = document.getElementById("Start_Year").value;
	var emonth = document.getElementById("End_Month").value;
	var eday = document.getElementById("End_Day").value;
	var eyear = document.getElementById("End_Year").value;
	
	var shour = document.getElementById("Start_Hour").value;
	var sminute = document.getElementById("Start_Minute").value;
	var sampm = new String(document.getElementById("Start_AMPM").value);
	var ehour = document.getElementById("End_Hour").value;
	var eminute = document.getElementById("End_Minute").value;
	var eampm = new String(document.getElementById("End_AMPM").value);
	
	var pm = new String("PM");
	
	if(sampm===pm)
		shour +=12;
	if(eampm===pm)
		ehour +=12;
	
	var startDate = new Date(syear,smonth,sday,shour,smin,0,0);
	
	var endDate = new Date(eyear,emonth,eday,ehour,emin,0,0);
	
	if(startDate.getTime() > endDate.getTime())
		{
		//alert("Start date is after End date");
		return false;
		}
	else
		return true;

	}
	
function validate()
{
	var isName=false,isDescription=false,isDate=false,isLimit=false;
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
	
	isDate = checkDateOrder();
	
	if(isDate == false)
	{
	alert("Start date is after end date");
	return false;
	}
	
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
	
	
	if(isName && isDescription && isDate && isLimit)
		return true;
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

<form onsubmit = "return validate();"  action="finalisefulleditevent.do" method="post" >
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
<textarea name="description" id="Description" cols="30" rows="5"  autocomplete="off" ><%=event.getDescription() %></textarea>
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


<tr>
<td>
Start date*:
</td>
<td>


<input type="number" size="5" id="Start_Month" name="start_month" placeholder="MM" width="20" onchange="checkStartDate();" value="<%=startDateArr[1] %>" autocomplete="off" /> 

<input type="number" size="5" name="start_day" width="15" placeholder="dd" onchange="checkStartDate();" value="<%=startDateArr[2] %>" autocomplete="off" />

<input type="number" name="start_year" id="Start_Year" placeholder="yyyy" size="5" onchange="checkStartDate();" value="<%=startDateArr[0] %>" autocomplete="off" /> 

MM / dd / yyy

</td>
</tr>

<tr>
<td>
Start time*:
</td>
<td>

<input type="number" size="5" placeholder="hh" name="start_hour" id="Start_Hour" value="<%=startTimeArr[0] %>"  autocomplete="off" />


<input type="number" size="5" placeholder="mm" name="start_minute" id="Start_Minute"  value="<%=startTimeArr[1] %>"  autocomplete="off" />



<select name="start_AMPM" id="Start_AMPM">

<% if(start_AMPM) { %>

<option value="PM"> PM </option>
<option value="AM"> AM </option>

<% }
 else { %>
 
 <option value="AM"> AM </option>
<option value="PM"> PM </option>
 
 <% } %>
 
</select>

</td>
</tr>

<tr>
<td>
End date*:
</td>
<td>

<input type="number" size="5" id="End_Month" placeholder="MM" name="end_month" width="20"  onchange="checkEndDate();" value="<%=endDateArr[1] %>" autocomplete="off" />

<input type="number" size="5" id="End_Day" placeholder="dd" name="end_day" width="15"  onchange="checkEndDate();" value="<%=endDateArr[2] %>" autocomplete="off" />

<input type="number" name="end_year" id="End_Year" placeholder="yyyy" size="5"  onchange="checkEndDate();" value="<%=endDateArr[0] %>" autocomplete="off" />

MM / dd / yyy

</td>
</tr>

<tr>
<td>
End time*:
</td>
<td>

<input type="number" size="5" placeholder="hh" id="End_Hour" name="end_hour" value="<%=endTimeArr[0] %>" autocomplete="off" />

<input type="number" size="5" placeholder="mm" name="end_minute" id="End_Minute" value="<%=endTimeArr[1] %>"  autocomplete="off" />

<select name="end_AMPM" id="End_AMPM">

<% if(end_AMPM) { %>

<option value="PM"> PM </option>
<option value="AM"> AM </option>

<% }
 else { %>
 
 <option value="AM"> AM </option>
<option value="PM"> PM </option>
 
 <% } %>
 
</select>

</td>
</tr>



<tr>
<td>
Event location*:
</td>
<td>

<select name="location" id="Location"> 

<optgroup>

 <%=Utils.getLocationsWithSelected(event.getLocation(), conn) %>

</optgroup>

</select>

</td>
</tr>

<% //} %>

<tr>

<td> Do you want limited registration* ? 
</td>
<td>

<% 

 if(event.getRegistration_Limit() == -1)
 {
	 

%>


<input type="radio" name="limit" id="Limit_No" value="N" onclick="hidelimit();" checked="true" /> No

<input type="radio" name="limit" id="Limit_Yes" value="Y" onclick="showlimit();" /> Yes

<%
 }
 else
 {
%>

<input type="radio" name="limit" id="Limit_Yes" value="Y" onclick="showlimit();" checked="true" /> Yes

<input type="radio" name="limit" id="Limit_No" value="N" onclick="hidelimit();"  /> No
<% } %>

</td>
</tr>

<% if(event.getRegistration_Limit() == -1) 
	{ %>


<tr id="reg_limit" style="display:none;">
<td> Enter the registration limit : 
</td>
<td> <input type="text" name="registration_limit" id="Registration_Limit" cols="30" autocomplete="off"/>
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

<script type="text/javascript">
<%

if(request.getAttribute("DateFailure") != null)
	out.write("alert(\""+request.getAttribute("DateFailure")+"\")");

%>
</script>

</body>
</html>