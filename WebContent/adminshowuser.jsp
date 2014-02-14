<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="MyPackage.*" import="java.util.*" %>
    
    <% 
    
    Integer myUserId = ((User)session.getAttribute("User")).getUserId();
    
    Integer UserId = (Integer)request.getAttribute("userid");
    
    Integer requestedUserId = UserId;
    
    boolean thisIsMyProfile = myUserId == UserId;
    
    String name = (String)request.getAttribute("name");
    String emailid = (String)request.getAttribute("emailid");
    String contact_number = (String)request.getAttribute("contact_number");

    List<Event> createdevents = (ArrayList<Event>)request.getAttribute("CreatedEvents");
    
    List<Event> registeredevents = (ArrayList<Event>)request.getAttribute("RegisteredEvents");
    
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> <%=name %> </title>
</head>
<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/showuser.css" />

<script type="text/javascript" src="js/regunreg.js"> </script>

<script type="text/javascript">

function viewreport(eventID)
{
	var url = new String("report.jsp?eventid="+eventID);
	window.location.href=url;
}

function deleteaccount(eventid)
{
	if(confirm("Are you sure you want to delete this account? "))
		{
		window.location.href="deleteaccount.do?userid="+eventid;
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

</script>

<body>

<header id="all">

<jsp:include page="header.jsp"></jsp:include>

</header>

<div id="all">

<!-- <a href="home.do#tab1"><button type="button"> Go Home!</button></a> -->

<table id="maintable">

<caption> <h2> <%=name %> </h2> </caption>

<tr> 

<td colspan="2" align="right">

 <a href="fulleditprofile.do?userid=<%=requestedUserId%>"><button type="button"> Edit profile </button></a> <br/> <br/>
 
 <button onclick="deleteaccount(<%=UserId%>);" > Delete profile!  </button>

</td>

</tr>

<tr>
<td class="onevalue"> E-Mail : 
</td>
<td class="onevalue"> <%=emailid%>
</td>
</tr>

<tr>
<td class="onevalue"> Contact Number : 
</td>
<td class="onevalue"> <%=contact_number %>
</td>
</tr>

<tr>
<td colspan="2">

</td>

</tr>

<tr>

<td colspan="2"> <!--  For participated events -->

<table border="1" id="participated"> 

<% if(registeredevents.size() != 0)
{
		out.write("<caption> Events participated by "+ name +"</caption>");
	%>

<tr>
<th> Name </th>
</tr>

<% } %>

<% int i = 0;
if(registeredevents.size()!= 0)
	{ 
	
	for(Event e : registeredevents) 
	{
	%>

<tr>

<td>  <a href="showevent.do?eventid=<%=e.getEventId() %>" style="text-decoration:none;" class="eventname">  <%=e.getName() %></a>
</td>

<!--  
<td align="center">   

<a href="editevent.do?eventid=<%=e.getEventId()%>"><button type="button"> Edit event </button> </a> <br/> <br/>
	
	<button onclick="deleteevent(<%=e.getEventId()%>);" >  Delete event!</button>

</td>

 -->
</tr>

<%  
i++;
} 

} %>
</table>
</td>

</tr>


<tr>

<td colspan="2"> <!--  For created events -->

<table border="1" id="created" >

<% if(createdevents.size() != 0)
{
		out.write("<caption> Events created by "+ name +"</caption>");
	%>

<tr>
<th colspan="2"> Name </th>
<!-- <th> Status </th> -->
</tr>

<% } %>

<%  i = 0;
if(createdevents.size()!= 0)
	{ 
	
	for(Event e : createdevents) 
	{
	%>

<tr>

<td colspan="2">  <a href="showevent.do?eventid=<%=e.getEventId() %>" style="text-decoration:none;" class="eventname">  <%=e.getName() %></a>
</td>

<!-- 

<td align="center">   

<a href="editevent.do?eventid=<%=e.getEventId()%>"><button type="button"> Edit event </button> </a>  
	
<button onclick="deleteevent(<%=e.getEventId()%>);" >  Delete event!</button>

</td>

 -->

</tr>

<%  
i++;
} 

} %>
</table>
</td>

</tr>

</table>

</div>

</body>
</html>