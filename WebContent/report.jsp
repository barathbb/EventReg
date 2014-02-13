<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*" import="MyPackage.*" %>
    
    <%
    
    Connection conn = (Connection) session.getAttribute("Con");
    
    boolean isAssignScore = new Boolean((String)request.getParameter("AssignScore"));
    
    Integer EventId = (Integer)session.getAttribute("EventId");
    
    String eventname = (String) session.getAttribute("EventName");
    
    boolean hasScore =false;
    
    HashMap<Integer,Integer> scores = (HashMap<Integer,Integer>)session.getAttribute("Scores");
    
    if(scores != null)
    	hasScore = true;
    
    HashMap<Integer,String[]> allDetails = (HashMap<Integer,String[]>)session.getAttribute("UserList");
    
    %>
    
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=eventname %></title>
</head>

<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/report.css" />

<script type="text/javascript">

var count = <%=allDetails!=null ? allDetails.size() : 0%>



function removeentry(userid,eventid)
{
	//alert("Hi");
	if(confirm("Are you sure you want to remove this entry :"))
		{
		
		 url = "removeentry.do?userid="+userid+"&eventid="+eventid;
		var ajax = new XMLHttpRequest();
		ajax.open("GET", url, true)
		ajax.onreadystatechange = function()
		{
			if(ajax.readyState == 4)
				{
				document.getElementById(userid).innerHTML = "";
				count--;
				}
		}
		ajax.send(null);
		} 
}

var isAssignScore = true;

function assignscores(eventid)
{	
	window.location.href = "editreport.jsp?EventId="+eventid+"&AssignScore=true";
	 
	//var arr = document.getElementsByName("tscore");
	
	//for(i=0;i<arr.length;i++)
		//{
		//val = arr[i].innerHTML;
		//thisid = arr[i].id;
		//arr[i].innerHTML = "<input class=\""+thisid+"\" type=\"text\" size=\"8\"/ value=\""+val+"\"  id=\""+thisid+"\"/>";
		//}
	//var button = document.getElementById("toggle");
	//button.innerHTML = "Save all"; 	 
}
 
 </script>

<body>

<div id="all">

<a href="home.do#tab1"><button type="button"> Go Home!</button></a>

<h1> <%=eventname %> </h1> 

<% if(hasScore && allDetails!=null)
	{ %>
 
<button type="button" style="float:right;margin-right:100px;" id="toggle" onclick="assignscores(<%=EventId%>);"> Assign scores</button> <br/>
<br/> <br/>

<% } %>

<table border="2" style="margin:0 auto;">

<% if(allDetails != null && allDetails.size() > 0) { %>

<tr>
<th class ="tname"> Name
</th>
<th class="temail"> E-Mail
</th>
<th class="tcontact"> Contact Number
</th>

<% if(hasScore) { %>

<th class="tscore"> Score 
</th>

<% } %>
<th>
</th>
</tr>

<% } 
else { %>

<h4 align="center"> No one has registered yet! </h4>

<% } %>

<%

//while(r2.next())
	
if(allDetails!=null)
{
	

for(Integer i : allDetails.keySet())
{
  String[] details = allDetails.get(i);
	//User oneUser = Utils.getUserDetails(r2.getInt("UserId"), conn,session);
%>

<tr id=<%=i%> >

<td  class ="tname" align="center">  <%=details[0] %>
</td>
<td  class="temail" align="center"> <%=details[1] %>
</td>
<td class="tcontact" align="center"> <%=details[2] %>
</td> 
<% if(hasScore) { %>

<td class="tscore" name="tscore" id="<%=i %>" align="center"><%=scores.get(i)==null ? 0 : scores.get(i) %></td>

<% } %>
<td> <button onclick="removeentry(<%=i %>,<%=EventId %>);"> &#x2716; </button>  </td>

</tr>
<% 
}  //End of for loop

}

%>

</table>

</div>

</body>
</html>