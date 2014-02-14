<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="MyPackage.*" %>
    
<%
    
if(request.getSession().getAttribute("User") == null)
	response.sendRedirect("index.jsp");

%>
    
    <%
      Connection conn = (Connection)session.getAttribute("Con");
      User thisUser = (User)session.getAttribute("User");
      Integer UserId = thisUser.getUserId();
      
     // String name = (String)request.getAttribute("name");
      //String emailid = (String)request.getAttribute("emailid");
      //String contact_number = (String)request.getAttribute("contact_number");
      
      //Integer requestedUserId = (Integer)request.getAttribute("userid");
      
    %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit profile</title>

<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/signup.css" />

<script type="text/javascript">

var initial_name ="<%=thisUser.getName()%>";
var initial_contact_number = "<%=thisUser.getContact_Number()%>";  
var userid = <%=UserId%>;

function updateprofile(way)
{
	var contact_number = document.getElementById("Contact_Number").value;
	var name = document.getElementById("Name").value;
	if(way == 1)
		{
		
		//var contact_number = document.getElementById("Contact_Number");	
		url = "editprofile.do?way="+way+"&userid="+userid+"&name="+name;
		doedit(url);
		}
	if(way == 2)
	{
	//var name = document.getElementById("Name").value;
	url = "editprofile.do?way="+way+"&userid="+userid+"&contact_number="+contact_number;
	doedit(url);
	}
	
	if(way== 3)
	{
		var password = document.getElementById("Password").value;
		var confirm_password = document.getElementById("Confirm_Password").value;
		var old_password = document.getElementById("Old_Password").value;
		
		if(password===confirm_password)
		{
			url="editprofile.do?way="+way+"&userid="+userid+"&password="+password+"&old_password="+old_password;
		doedit(url);
		}
		else 
			alert("Passwords dont't match");
	}
	
}

function doedit(url)
{
	var ajax = new XMLHttpRequest();
	ajax.open("POST",url,true);
	ajax.onreadystatechange = function()
	{
		if(ajax.readyState == 4)
			{
			alert(ajax.responseText);
			initial_name = name;
			initial_contact_number = contact_number; 
			}
	}
	ajax.send(null);
	
}

function checkchanges()
{
	var new_name = document.getElementById("Name").value;
	var new_contact_number = document.getElementById("Contact_Number").value;
	if(!(new_name===initial_name))
		updateprofile(1);
	if(!(new_contact_number===initial_contact_number))
		updateprofile(2);
}

function deleteaccount(eventid)
{
	if(confirm("Are you sure you want to delete this account? "))
		{
		//var ajax = new XMLHttpRequest();
		window.location.href="deleteaccount.do?userid="+eventid;
		//ajax.open("POST",url,true);		
		//ajax.onreadystatechange = function()
		//{
		//	if(ajax.readyState == 4)
		//		{
		//		alert("The account has been deleted");
		//		pagerefresh();
		//		}
		//}
		//ajax.send(null);
		}
}

</script>

</head>
<body>

<div id="all">

<a href="home.do#tab1"><button type="button"> Go Home!</button></a>

<h1>
Edit Profile
</h1>

<div id="form">
<form action="javascript:updateprofile();" method="post" id="form">

<table border="0">

<tr>
<td>
Name :
</td>
<td>
<input type="text" name="name" id="Name" autocomplete="off" value="<%=thisUser.getName()%>" autocomplete="off"/>
</td>
</tr>

<tr>
<td>
Contact Number:
</td>
<td>
<input type="tel" name="contact_number" id="Contact_Number" autocomplete="off" value="<%=thisUser.getContact_Number()%>" autocomplete="off"/>
</td>
</tr>

<tr>
<td align="center" colwidth="2">

<button type="button" name="Update" value="Update" onclick="checkchanges();"> Update </button>

</td>
</tr>

<tr>

<td colspan="2">
<br/>
 <h1>Change Password </h1>
</td>
</tr>

<tr>
<td>
Old Password : 
</td>
<td>
<input type="password" name="old_password" id="Old_Password" />
</td>
</tr>

<tr>
<td>
Password : 
</td>
<td>
<input type="password" name="password" id="Password" />
</td>
</tr>

<tr>
<td>
Confirm Password : 
</td>
<td>
<input type="password" name="confirm_password" id="Confirm_Password" />
</td>
</tr>

<tr>
<td align="center" colwidth="2">

<button type="button" name="Change" value="Change" onclick="updateprofile(3);"> Change! </button>

</td>
</tr>

<tr colspan="2">
<td align="center">
<h1> Delete your account! </h1>
</td>
</tr>
<tr colspan="2">
<td align="center" > <button onclick="deleteaccount(<%=UserId%>);" > Delete account!  </button>
</td>
</tr>


</table>

</form>

</div>

</div>

</body>
</html>

