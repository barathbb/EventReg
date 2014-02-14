<%@ page language="java" contentType="text/html; charset=ISO-8859-1" 
    pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*" import="MyPackage.*" %>
    
	<%
	List<Event> eventlist = (ArrayList<Event>) request.getAttribute("EventList");

	//List<Integer> REL = (ArrayList<Integer>)session.getAttribute("RegisteredEventList");
	
	Connection conn = (Connection)session.getAttribute("Con");
	
	Integer UserId = ((User)session.getAttribute("User")).getUserId();
	
	Integer p = (Integer)request.getAttribute("param");
	
	if(eventlist == null || eventlist.size() == 0)
		out.write("<h4> There are no events </h4>");
	
	for(Event e : eventlist)
	{
		
	%>

	<div class="oneevent" id="<%=e.getEventId() %>" >

	<div class="eventdetails">
	
	<div class="details">

	<h2> <a class="eventname" href="showevent.do?eventid=<%=e.getEventId() %>" > <% out.write(e.getName()); %>   </a> </h2> 
	 
	At <% out.write(e.getFullLocation(conn)); %>  <br/>

	</div>

	<div class="dates">

	From : <%=DateManip.toDisplayDate(e.getStart_Date()) %> 

	<br/> <br/>
	To : &nbsp; &nbsp; <%=DateManip.toDisplayDate(e.getEnd_Date()) %>  <br/>

	</div>

	</div>

	<div class="eventcontrols">
	 <% 
	
	 if(p == 5)
	 { 
		 %>
		 
		 <select class="statuslist" onchange="statuschange(<%=e.getEventId()%>,this.value);">
				<option value="P"> Pending </option>
				<option value="A"> Approved </option>
				<option value="R"> Rejected </option>
			</select>
		 
		 <% 
	 }
	
	 if(p == 6)
	 { 
		 %>
		 
		 <select class="statuslist" onchange="statuschange(<%=e.getEventId()%>,this.value);">
		 		<option value="R"> Rejected </option>
				<option value="P"> Pending </option>
				<option value="A"> Approved </option>
				
			</select>
		 
		 <% 
	 }
	 
	 if(p == 4)

	 {
		 %>
		 
	<!-- 
	<button type="button" style="float:right;" id="<%=e.getEventId()%>" onclick="viewreport(this.id);"> View Report </button>
	
	<br/> <br/>
	
	 -->
	 
	<a href="editevent.do?eventid=<%=e.getEventId()%>"><button type="button" style="float:right;"> Edit event </button></a>
	
	<%
	
	 }

	%>
	
	<br/> <br/> <br/> 
	
	</div>

	</div>
	<% 

	}
	if(eventlist == null)
		out.write("<h4 align=\"center\"> There are no events</h4>");
	%>
	