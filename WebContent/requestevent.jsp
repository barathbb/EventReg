<%@page import="MyPackage.Utils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.HashMap" %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a new event</title>

<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/newevent.css" />

<script type="Text/javascript">

function checkStartDate()
{
	var month = document.getElementById("Start_Month").value;
	var day = document.getElementById("Start_Day").value;
	var year = document.getElementById("Start_Year").value;
	
if (month == 4 || month == 6 || month == 9 || month == 11 && day <= 30) {
      // alert("Date is valid")
   }
   else if (year/4!=0 && month == 2 && day <= 28 ) {
      // alert("Date is valid")
   }
   else if(year/4==0 && month == 2 && day <= 29 ){
	   //alert("Date is valid");
   }
   else if (year/400==0 && month == 2 && day <= 29 ) {
       //alert("Date is valid")
   }
   else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 && day <= 31) {
      // alert("Date is valid")
   }
   else {
       alert("Start date is invalid");
   }
	
}


function checkEndDate()
{
	var month = document.getElementById("End_Month").value;
	var day = document.getElementById("End_Day").value;
	var year = document.getElementById("End_Year").value;
	//alert(month+" "+day+" "+year);
	
if (month == 4 || month == 6 || month == 9 || month == 11 && day <= 30) {
      // alert("Date is valid")
   }
   else if (year/4!=0 && month == 2 && day <= 28 ) {
      // alert("Date is valid")
   }
   else if(year/4==0 && month == 2 && day <= 29 ){
	   //alert("Date is valid");
   }
   else if (year/400==0 && month == 2 && day <= 29 ) {
       //alert("Date is valid")
   }
   else if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 && day <= 31) {
      // alert("Date is valid")
   }
   else {
       alert("End date is invalid");
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
		return false;
		}
	else
		return true;
	}
		
function setYears()
{
	var d = new Date();
	document.getElementById("Start_Year").value = d.getFullYear();
	document.getElementById("End_Year").value = d.getFullYear();
}

var months = ["January","February","March","April","May","June","July","August","September","October","November","December"];

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
	//Update list whenever a new event type is added 
	if(et == "C")  
	{
		sen.innerHTML = "Competition allows you to put scores for the participants";
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
		sen.innerHTML = "Hackathon allows you to put scores for the participants";
	}
	if(et == "T")
	{
		sen.innerHTML = "Tournament allows you to put scores for the participants";
	}
	if(et == "L")
	{
		sen.innerHTML = "Lecture doesn't allow you to put scores for the participants";
	}
	
	document.getElementById("Message_Row").style.display="table-row";
}

function removeMessage()
{
	var sen = document.getElementById("Event_Type_Message");
	sen.innerHTML = "";
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
		{
	
		return true;
		}
	else
		return false;
	
}

</script>

</head>

<body onload="setYears();">

<header id="all">

<jsp:include page="header.jsp"></jsp:include>

</header>

<div id="all">

<h1>
Create A New Event
</h1>
<form onsubmit = "return validate();" action="finaliseeventrequest.do" method="post" id="Form">
<table border="0" style="margin:0 auto;">

<tr>
<td>
Event name*:
</td>
<td>
<input type="text" name="name" id="Name" size="30" autocomplete="off" />
</td>
</tr>

<tr>
<td>
Description*:
</td>
<td>
<textarea name="description" id="Description" cols="30" rows="5" ></textarea>
</td>
</tr>

<tr>
<td> Event Type* : 
</td>
<td>

<select onchange="showeventtypemessage();" name="event_type" id="Event_Type" width="30" onblur="removeMessage();">

<optgroup>

<%=Utils.getAllEventTypes((Connection)session.getAttribute("Con")) %>

</optgroup>

</select>

</td>
</tr>

<tr style="display:none;" id="Message_Row">
<td colspan="2" align="Center"> <span id="Event_Type_Message"> </span>
</td>
</tr>

<tr>
<td>
Start date*:
</td>
<td>


<select id="Start_Month" name="start_month" width="20" onchange="checkStartDate();"> 

<option value="01">January </option>
<option value="02"> February</option>
<option value="03"> March </option>
<option value="04"> April </option>
<option value="05"> May </option>
<option value="06"> June</option>
<option value="07">July </option>
<option value="08"> August</option>
<option value="09"> September</option>
<option value="10">October </option>
<option value="11"> November </option>
<option value="12">December </option>

</select>

<select id="Start_Day" name="start_day" width="15" onchange="checkStartDate();">
<option value="01"> 01 </option>
<option value="02"> 02 </option>
<option value="03"> 03 </option>
<option value="04"> 04 </option>
<option value="05"> 05 </option>
<option value="06"> 06 </option>
<option value="07"> 07 </option>
<option value="08"> 08 </option>
<option value="09"> 09 </option>
<option value="10"> 10 </option>
<option value="11"> 11 </option>
<option value="12"> 12 </option>
<option value="13"> 13 </option>
<option value="14"> 14 </option>
<option value="15"> 15 </option>
<option value="16"> 16 </option>
<option value="17"> 17 </option>
<option value="18"> 18 </option>
<option value="19"> 19 </option>
<option value="20"> 20 </option>
<option value="21"> 21 </option>
<option value="22"> 22 </option>
<option value="23"> 23 </option>
<option value="24"> 24 </option>
<option value="25"> 25 </option>
<option value="26"> 26 </option>
<option value="27"> 27 </option>
<option value="28"> 28 </option>
<option value="29"> 29 </option>
<option value="30"> 30 </option>
<option value="31"> 31 </option>

</select>


<input type="text" name="start_year" id="Start_Year" placeholder="yyyy" size="5" onchange="checkStartDate();"/> 


</td>
</tr>

<tr>
<td>
Start time*:
</td>
<td>

<select name="start_hour" id="Start_Hour">

<option value="01"> 01 </option>
<option value="02"> 02 </option>
<option value="03"> 03 </option>
<option value="04"> 04 </option>
<option value="05"> 05 </option>
<option value="06"> 06 </option>
<option value="07"> 07 </option>
<option value="08"> 08 </option>
<option value="09"> 09 </option>
<option value="10"> 10 </option>
<option value="11"> 11 </option>
<option value="12"> 12 </option>

</select>

<select name="start_minute" id="Start_Minute">

<option value="00">00</option>
<option value="15">15</option>
<option value="30">30</option>
<option value="45">45</option>

</select>

<select name="start_AMPM" id="Start_AMPM">
<option value="AM"> AM </option>
<option value="PM"> PM </option>


</select>

</td>
</tr>

<tr>
<td>
End date*:
</td>
<td>

<select id="End_Month" name="end_month" width="20"  onchange="checkEndDate();">

<option value="01">January </option>
<option value="02"> February</option>
<option value="03"> March </option>
<option value="04"> April </option>
<option value="05"> May </option>
<option value="06"> June</option>
<option value="07">July </option>
<option value="08"> August</option>
<option value="09"> September</option>
<option value="10">October </option>
<option value="11"> November </option>
<option value="12">December </option>

</select>

<select id="End_Day" name="end_day" width="15"  onchange="checkEndDate();">
<option value="01"> 01 </option>
<option value="02"> 02 </option>
<option value="03"> 03 </option>
<option value="04"> 04 </option>
<option value="05"> 05 </option>
<option value="06"> 06 </option>
<option value="07"> 07 </option>
<option value="08"> 08 </option>
<option value="09"> 09 </option>
<option value="10"> 10 </option>
<option value="11"> 11 </option>
<option value="12"> 12 </option>
<option value="13"> 13 </option>
<option value="14"> 14 </option>
<option value="15"> 15 </option>
<option value="16"> 16 </option>
<option value="17"> 17 </option>
<option value="18"> 18 </option>
<option value="19"> 19 </option>
<option value="20"> 20 </option>
<option value="21"> 21 </option>
<option value="22"> 22 </option>
<option value="23"> 23 </option>
<option value="24"> 24 </option>
<option value="25"> 25 </option>
<option value="26"> 26 </option>
<option value="27"> 27 </option>
<option value="28"> 28 </option>
<option value="29"> 29 </option>
<option value="30"> 30 </option>
<option value="31"> 31 </option>

</select>

<!-- 
<select id="End_Year" name="End_Year width="15">

</select>  -->

<input type="number" name="end_year" id="End_Year" placeholder="yyyy" size="5"  onchange="checkEndDate();" />


</td>
</tr>

<tr>
<td>
End time*:
</td>
<td>


<select id="End_Hour" name="end_hour">

<option value="01"> 01 </option>
<option value="02"> 02 </option>
<option value="03"> 03 </option>
<option value="04"> 04 </option>
<option value="05"> 05 </option>
<option value="06"> 06 </option>
<option value="07"> 07 </option>
<option value="08"> 08 </option>
<option value="09"> 09 </option>
<option value="10"> 10 </option>
<option value="11"> 11 </option>
<option value="12"> 12 </option>

</select>

<select name="end_minute" id="End_Minute">

<option value="00">00</option>
<option value="15">15</option>
<option value="30">30</option>
<option value="45">45</option>

</select>

<select name="end_AMPM" id="End_AMPM">
<option value="AM"> AM </option>
<option value="PM"> PM </option>


</select>

</td>
</tr>

<tr>
<td>
Event location*:
</td>
<td>

<select name="location" id="Location" onchange="checkDateOrder();" onfocus="checkDateOrder();"> 

<optgroup>


<%=Utils.getAllLocations((java.sql.Connection)session.getAttribute("Con")) %>

</optgroup>

</select>

</td>
</tr>

<tr>
<td> Do you want limited registration* ? 
</td>
<td>

<input type="radio" name="limit" id="Limit_No" value="N" onclick="hidelimit();" checked="true" /> No

<input type="radio" name="limit" id="Limit_Yes" value="Y" onclick="showlimit();" /> Yes

</td>
</tr>

<tr id="reg_limit" style="display:none;">
<td> Enter the registration limit : 
</td>
<td> <input type="text" name="registration_limit" id="Registration_Limit" cols="30" />
</td>
</tr>

<tr>
<td colspan="2"  align="center">

<button type="submit"> Request for time slot! </button> 

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