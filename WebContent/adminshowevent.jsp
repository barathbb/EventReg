<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="MyPackage.*" import="java.sql.*" import="java.util.*" %>

  <%
  Event event = (Event)request.getAttribute("Event");
  
  Integer UserId = ((User)session.getAttribute("User")).getUserId();
  
  Connection conn = (Connection)session.getAttribute("Con");
  
  boolean thisIsMyEvent = event.getEvent_Owner() == UserId;
  
  //System.out.println(UserId + "\t" + event.getEvent_Owner() + new Boolean(thisIsMyEvent));
  
  String Name = Utils.getNameFromUserId(event.getEvent_Owner(), conn) ;
  
  //List<Integer> REL = (ArrayList<Integer>)session.getAttribute("RegisteredEventList");
  
  //PreparedStatement pt2 = conn.prepareStatement("select EventId,Name,Registration_Limit from Events where Event_Owner = ? and Status = ?");
  
  //pt2.setInt(1, event.getEvent_Owner());
  //pt2.setString(2, "A");
  
  List<Event> otherevents = (ArrayList<Event>)request.getAttribute("OtherEvents"); 
  //r2= pt2.executeQuery();
  
  %>  
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> </title>

<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/showevent.css" />
<script type="text/javascript" src="js/regunreg.js"></script>

<script type="text/javascript">

function viewreport(eventID)
{
	var url = new String("report.jsp?EventId="+eventID);
	window.location.href=url;
}

function editevent()
{
	
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

</script>

</head>
<body>

<header id="all">

<jsp:include page="header.jsp"></jsp:include>

</header>

<div id="all">

<!-- <a href="home.do#tab1"><button type="button"> Go Home!</button></a> -->

<h1>
<%=event.getName() %>
</h1>

<table>

<tr>
<td>

A  <%=event.getEvent_Type(conn) %> <br/> <br/>

conducted by &nbsp;

<a href="showuser.do?userid=<%=event.getEvent_Owner() %>" class="username">  <%=Name %> </a>

</td>

<td  id="usercontrols" align="Center">

<%
	//out.write(new Boolean(thisIsMyEvent).toString());
	%>
	
	<a href="editevent.do?eventid=<%=event.getEventId()%>"><button type="button"> Edit event </button> </a> <br/> <br/>
	
	<button onclick="deleteevent(<%=event.getEventId()%>);" >  Delete event!</button>
	
	<%
	
%>

</td>

</tr>

<tr>
<td>

<b> Venue :</b> <br/> <br/> <%=event.getFullLocation(conn) %> <br/>

</td>
<td>
</td>

</tr>

<tr>
<td>

 <b>From : </b> <%=DateManip.toDisplayDate(event.getStart_Date()) %> <br/> <br/>

<b>To </b>  &nbsp;&nbsp;&nbsp;&nbsp; : <%=DateManip.toDisplayDate(event.getEnd_Date()) %>

</td>
<td> </td>
</tr>

<tr>
<td colspan="2">

<%=event.getDescription() %>

</td>
</tr>

<% if(request.getAttribute("Available Entries") != null && event.getRegistration_Limit() != -1 ) 
{

%>

<tr colspan="2">
<td> Registration Limit :  <%=event.getRegistration_Limit() %>
</td>
</tr>

<tr colspan="2">
<td> Available Entries : &nbsp; &nbsp; <%=request.getAttribute("Available Entries")%>
</td>
</tr>

<% } %>

<tr><td><br/></td></tr>  

<tr>
<td>

<% 

event = null;

if(otherevents.size() != 0) 
 { %>

<h4>  Other events coordinated by <%=Name %> </h4>

<%
 }
%>

</td>
</tr>

<tr>
<td colspan="2">


<table id="otherevents">

<%

for(Event e : otherevents)
{

	
%>

<tr class="eventrow">
<td class="l"> 

<a href="showevent.do?eventid=<%=e.getEventId()%>" class="eventname"> <%=e.getName() %> </a>

</td>
<td class="r">

<%

%>

</td>
</tr>

<%
	

}

%>

</table>

</td>
</tr>

</table>

</div>


</body>
</html>