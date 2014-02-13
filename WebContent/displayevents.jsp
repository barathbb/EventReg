<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
    pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*" import="MyPackage.*" %>
    
	<%
	List<Event> eventlist = (ArrayList<Event>) request.getAttribute("EventList");

	List<Integer> REL = (ArrayList<Integer>)session.getAttribute("RegisteredEventList");
	
	Connection conn = (Connection)session.getAttribute("Con");
	
	Integer UserId = ((User)session.getAttribute("User")).getUserId();
	
	Integer p = (Integer)request.getAttribute("param");
	
	if(p == 3)
	{
		%>
		<a href="requestevent.jsp" style="float:right;"> <button> Create a new event </button> </a>
		 <br/> <br/> 
		<% 
	}
	
	if(eventlist == null || eventlist.size() == 0)
		out.write("<h4> There are no events </h4>");
	
	for(Event e : eventlist)
	{
		
	%>

	<div class="oneevent" >

	<div class="eventdetails">

	<%
			
	//out.write(" <h4 class=\"Edit_event_details\" align=\"right\" > Edit event </h4> ");
		
	%>
	
	<div class="details">

	<h2> <a class="eventname" href="showevent.do?eventid=<%=e.getEventId() %>" > <% out.write(e.getName()); %>   </a> </h2> 
	 
	At <% out.write(e.getFullLocation(conn)); %>  <br/>

	</div>

	<div class="dates">

	From : <%=DateManip.toDisplayDate(e.getStart_Date()) %> 

	<br/> 
	To : &nbsp; &nbsp; <%=DateManip.toDisplayDate(e.getEnd_Date()) %>  <br/>

	</div>

	</div>

	<div class="eventcontrols">
	
	<% 
	 String status = e.getStatus();
	
	if(status.equals("A")) { %>
	
	 <% 
	 
	 if(e.getEvent_Owner() == UserId) 
	 {
	 
	 %>

	<button type="button" style="float:right;" id="<%=e.getEventId()%>" onclick="viewreport(this.id);"> View Report </button>
	<br/> <br/>
	<a href="editevent.do?eventid=<%=e.getEventId()%>"><button type="button" style="float:right;"> Edit event </button></a>
	
	<%

	 }
	 
	 else
	 {
		 
		if(REL.contains(new Integer(e.getEventId())))
		{
			
			%>
			
		<button type="button" class="Unregister" style="float:right;" onclick="unregisterforevent(<%=e.getEventId()%>,this);"> Unregister </button>
			
			<%
			
		}
		
		else if(e.getAvailable() == true)
		{
			
			%>
			<button type="button" class="Register" style="float:right;" onclick="registerforevent(<%=e.getEventId()%>,this);"> Register </button>
			
			<% 
			
		}
		
		else
		{
			%>
			
			<span class="Reg_Closed" style="float:right;"> Registration closed</span>

			<% 
		}

	 }

	%>

	<br/> <br/> <br/> 
	
	<% } %>
	
	<% if(status.equals("P")) { %>
	
	<a href="editevent.do?eventid=<%=e.getEventId()%>"><button type="button" style="float:right;"> Edit event </button></a> <br/> <br/>
	
	<h4 style="float:right; margin-right:10px;"> Pending </h4> <br/> <br/> <br/>
	
	<% } %>
	
	<% if(status.equals("R")) { %>
	
	<a href="editevent.do?eventid=<%=e.getEventId()%>"><button type="button" style="float:right;"> Edit event </button></a> <br/> <br/>
	
	<h4 style="float:right;"> Rejected </h4> <br/> <br/> <br/>

	<% } %>
	
	</div>
	
	</div>
	
	<% 

	}

	if(eventlist == null)
		out.write("<h4> There are no events");
	%>
