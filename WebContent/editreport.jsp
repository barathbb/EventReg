<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*" import="MyPackage.*" %>
    
    <%
    
    Connection conn = (Connection) session.getAttribute("Con");
    
    //boolean isAssignScore = new Boolean((String)request.getParameter("AssignScore"));
    
    Integer EventId = (Integer)session.getAttribute("EventId");
    
    String eventname = (String) session.getAttribute("EventName");
    
    boolean hasScore =false;
    
    HashMap<Integer,Integer> scores = (HashMap<Integer,Integer>)session.getAttribute("Scores");
    
    if(scores != null)
    	hasScore = true;
    
    HashMap<Integer,String[]> allDetails = (HashMap<Integer,String[]>)session.getAttribute("UserList");
    
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=eventname %></title>
</head>

<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/report.css" />

<script type="text/javascript">

var count = <%=allDetails.size()%>

function removeentry(userid,eventid)
{
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

function savescores(eventid)
{
	var ips = document.getElementsByName("score");
	
	var ids =new Array();
	
	var scores  = new Array();
	
	sample = true;
	
	for(var m = 0; m< ips.length ; m++ )
		{
		ids.push(ips[m].id);
		
		scores.push(ips[m].value);
		}	
	saveall(ids,scores,eventid);
}

function saveall(ids,scores,eventid)
{
	var scoresCorrect = true;
	
	var m = new String(scores);
	
	var arr = m.split(",");
	
	for(i=0;i<arr.length;i++) 
	{
		
	}
	
	var url = "savescore.do?ids="+ids+"&scores="+scores+"&eventid="+eventid;
	var ajax = new XMLHttpRequest();
	ajax.open("POST",url,true);
	ajax.onreadystatechange = function(){
		if(ajax.readyState == 4)
			{
			alert(ajax.responseText);
			if(ajax.responseText.length < 54)  //Change length if response text is changed
			   window.location.href="report.do?eventid="+eventid;
			}
	}
	ajax.send(null);	
	
}

</script>

<body>

<header id="all">

<jsp:include page="header.jsp"></jsp:include>

</header>

<div id="all">

<!-- <a href="home.do#tab1"><button type="button"> Go Home!</button></a> -->

<h1> <%=eventname %> </h1> 

<% if(hasScore)
	{ %>

<button type="button" style="float:right;margin-right:100px;" onclick="savescores(<%=EventId%>);"> Save scores</button>

 <br/>
<br/> <br/>

<% } %>
 

<table border="2" style="margin:0 auto;">

<% if(allDetails.size() != 0) { %>

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
	for(Integer i : allDetails.keySet())
{
  String[] details = allDetails.get(i);
%>

<tr id=<%=i%> >

<td  class ="tname" align="center">  <%=details[0] %>
</td>
<td  class="temail" align="center"> <%=details[1] %>
</td>
<td class="tcontact" align="center"> <%=details[2] %>
</td> 
 

<td class="tscore" name="tscore" id="<%=i %>" align="center"><%

  %>
  
  <input class="score" type="text" name="score" size="8" value="<%=scores.get(i)==null ? 0 : scores.get(i) %>"  id="<%=i %>"  autocomplete="off" />
  
  </td>
  
  
<td> <button onclick="removeentry(<%=i %>,<%=EventId %>);"> &#x2716; </button>  </td>

</tr>
<% 
} 

%>

</table>

</div>

</body>
</html>