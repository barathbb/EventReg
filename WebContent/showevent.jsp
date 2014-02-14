<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="MyPackage.*" import="java.sql.*" import="java.util.*" %>

  <%
   Event event = (Event)request.getAttribute("Event");
  
  Integer UserId = ((User)session.getAttribute("User")).getUserId();
  
  Connection conn = (Connection)session.getAttribute("Con");
  
  boolean thisIsMyEvent = event.getEvent_Owner() == UserId;
  
  //System.out.println(UserId + "\t" + event.getEvent_Owner() + new Boolean(thisIsMyEvent));
  
  String Name = Utils.getNameFromUserId(event.getEvent_Owner(), conn) ;
  
  List<Integer> REL = (ArrayList<Integer>)session.getAttribute("RegisteredEventList");
  
  //PreparedStatement pt2 = conn.prepareStatement("select EventId,Name,Registration_Limit from Events where Event_Owner = ? and Status = ?");
  
  //pt2.setInt(1, event.getEvent_Owner());
  //pt2.setString(2, "A");
  
  List<Event> otherevents = (ArrayList<Event>)request.getAttribute("OtherEvents"); 
  //r2= pt2.executeQuery();
  
  %>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	var url = new String("report.do?eventid="+eventID);
	window.location.href=url;
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

<div id="all">

<a href="home.do#tab1"><button type="button"> Go Home!</button></a>

<h1>
<%=event.getName() %>
</h1>

<table>

<tr>
<td>

A  <%=event.getEvent_Type(conn) %> <br/> <br/>

conducted by &nbsp;


<a href="showuser.do?userid=<%=event.getEvent_Owner() %>" >  <%=Name %> </a>

</td>

<td  id="usercontrols" align="Center">

<%

if(thisIsMyEvent == true)
{
	
	//out.write(new Boolean(thisIsMyEvent).toString());
	%>
	
	<a href="editevent.do?eventid=<%=event.getEventId()%>"><button type="button"> Edit event </button> </a> <br/> <br/>
	
	<button onclick="deleteevent(<%=event.getEventId()%>);" >  Delete event!</button> <br/> <br/>
	
	<button style="padding-right:10px;" type="button" style="float:right;" id="<%=event.getEventId()%>" onclick="viewreport(this.id);"> View Report </button>
	
	<%
	
}

else
{
	if(REL.contains(new Integer(event.getEventId())))
	{
		
		%>
		<button type="button" class="Unregister" onclick="unregisterforevent(<%=event.getEventId()%>,this);"> Unregister </button>
	
		<% 	
	}
	
	else if(event.getAvailable())
	{
		%>
		<button type="button" class="Register" onclick="registerforevent(<%=event.getEventId()%>,this);"> Register </button>
		
		<% 	
	}
	
	else 
	{
		%>
		<span > Registration closed </span>
		
		<% 	
	}		
}

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

<% if(request.getAttribute("Available Entries") != null && event.getRegistration_Limit() != -1 && event.getAvailable()) 
{

%>

<tr colspan="2">
<td><b> Registration Limit : </b>  <%=event.getRegistration_Limit() %> 
</td>
</tr>


<tr colspan="2">
<td> <b> Available Entries : </b> &nbsp;&nbsp; <%=request.getAttribute("Available Entries")%>
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

<table id="otherevents" cellspacing="2" border="1">

<%

for(Event e : otherevents)
{

%>

<tr>
<td> 

<a href="showevent.do?eventid=<%=e.getEventId()%>"> <%=e.getName() %> </a>

</td>
<td>

<%

if(!(thisIsMyEvent))
{
	if(REL.contains(e.getEventId()))
	{
		%>
		<button type="button" class="Unregister" onclick="unregisterforevent(<%=e.getEventId() %>,this);"> Unregister </button>
		<% 	
	}
	
	else if(e.getAvailable())
	{
		%>
		<button type="button" class="Register" onclick="registerforevent(<%=e.getEventId() %>,this);"> Register </button>
		<% 	
	}
	
	else if(!e.getAvailable())
	{
		%>
		
		<span > Registration closed </span>
		
		<% 	
	}
}
else 
{
	%>
	
	<a href="editevent.do?eventid=<%=e.getEventId()%>"  align="Center"><button type="button" > Edit event </button> </a> <br/> <br/>
	
	<%
}
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