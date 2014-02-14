<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="MyPackage.*" import="java.util.*" %>
    
<%
    
if(request.getSession().getAttribute("User") == null)
	response.sendRedirect("index.jsp");

%>
    <% 
    
    Integer myUserId = ((User)session.getAttribute("User")).getUserId();
    
    Integer requestedUserId = (Integer)request.getAttribute("userid");
    
    boolean thisIsMyProfile = myUserId == requestedUserId;
    
    String name = (String)request.getAttribute("name");
    String emailid = (String)request.getAttribute("emailid");
    String contact_number = (String)request.getAttribute("contact_number");
    
    List<Integer> REL = (ArrayList<Integer>)session.getAttribute("RegisteredEventList");  //For sessioned user

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
	var url = new String("report.do?eventid="+eventID);
	window.location.href=url;
}

function deleteaccount(eventid)
{
	if(confirm("Are you sure you want to delete this account? "))
		{
		var ajax = new XMLHttpRequest();
		var url = new String("deleteevent.do?userid="+eventid);
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

</script>

<body>

<header id="all">

<jsp:include page="header.jsp"></jsp:include>

</header>

<div id="all">

<table id="maintable">

<caption> <h2> <%=name %> </h2> </caption>

<tr> 

<td colspan="2" align="right">

<% if(requestedUserId == myUserId)
{
%>

 <a href="editprofile.jsp?UserId=<%=requestedUserId%>"><button type="button"> Edit profile </button></a>

<% } %>
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

<table id="participated"> 

<% if(registeredevents.size() != 0)
{
		out.write("<caption> Events participated by "+ name +"</caption>");
	%>

<!-- <tr> -->
<!-- <th> Name </th> -->
<!-- <th> Status </th> -->
<!-- </tr> -->

<% } %>

<% int i = 0;
if(registeredevents.size()!= 0)
	{ 
	
	for(Event e : registeredevents) 
	{
	%>

<tr class="eventrow">

<td class="l">  <a href="showevent.do?eventid=<%=e.getEventId() %>" style="text-decoration:none;" class="eventname">  <%=e.getName() %></a>
</td>
<td align="center" class="r">   


<% 
 
 if(myUserId == e.getEvent_Owner())
 {
 
 %>

 <a href="editevent.do?eventid=<%=e.getEventId()%>"><button type="button"> Edit event </button> </a>

<%

 }
 
 else
 {
	 
	if(REL.contains(new Integer(e.getEventId())))
	{
		
		%>
		
	<button type="button" class="Unregister" onclick="unregisterforevent(<%=e.getEventId()%>,this);"> Unregister </button>
		
		<%
		
	}
	
	else if(e.getAvailable() == true)
	{
		
		%>
		<button type="button" class="Register"  onclick="registerforevent(<%=e.getEventId()%>,this);"> Register </button>
		
		<% 
		
	}
	
	else if(e.getAvailable() == false)
	{
		%>
		
		<span class="Reg_Closed" > Registration closed</span>
		
		<% 

	}

 }

%>

</td>

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

<table id="created">

<% if(createdevents.size() != 0)
{
		out.write("<caption> Events created by "+ name +"</caption>");
	%>

<!-- <tr> -->
<!-- <th> Name </th> -->
<!-- <th> Status </th> -->
<!-- </tr> -->

<% } %>

<%  i = 0;
if(createdevents.size()!= 0)
	{ 
	
	for(Event e : createdevents) 
	{
	%>

<tr class="eventrow">

<td class="l">  <a href="showevent.do?eventid=<%=e.getEventId() %>" style="text-decoration:none;" class="eventname">  <%=e.getName() %></a>
</td>
<td align="center" class="r">   


<% 
 
 if(thisIsMyProfile)
 {
 
 %>
 <!-- 

 <button type="button" class="Unregister" onclick="unregisterforevent(<%=e.getEventId()%>,this);reload();"> Unregister </button> 
 
  -->
 
 <button type="button" style="float:center;" id="<%=e.getEventId()%>" onclick="viewreport(this.id);"> View Report </button>
 
<%

 }
 
 else
 {
	 
	if(REL.contains(new Integer(e.getEventId())))
	{
		
		%>
		
	<button type="button" class="Unregister" onclick="unregisterforevent(<%=e.getEventId()%>,this);"> Unregister </button>
		
		<%
		
	}
	
	else if(e.getAvailable() == true)
	{
		
		%>
		<button type="button" class="Register"  onclick="registerforevent(<%=e.getEventId()%>,this);"> Register </button>
		
		<% 
		
	}
	
	else if(e.getAvailable() == false)
	{
		%>
		
		<span class="Reg_Closed" > Registration closed</span>
		
		<% 

	}

 }

%>


</td>

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