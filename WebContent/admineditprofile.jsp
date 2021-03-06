<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" import="MyPackage.*" %>
    
    <%
      Connection conn = (Connection)session.getAttribute("Con");
      Integer UserId = ((Integer)request.getAttribute("userid"));
      String name = (String)request.getAttribute("name");
      String emailid = (String)request.getAttribute("emailid");
      String contact_number = (String)request.getAttribute("contact_number");

    %>
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit profile</title>

<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/signup.css" />

<script type="text/javascript">

var initial_name ="<%=name%>";
var initial_contact_number = "<%=contact_number%>";  
var userid = <%=UserId%>;
var initial_emailid = "<%=emailid%>";

function updateprofile(way)
{
	
	var emailid = document.getElementById("EmailId").value;
	var name = document.getElementById("Name").value;
	var contact_number = document.getElementById("Contact_Number").value;
	
	if(way == 1)
	{	
			url = "editprofile.do?way="+way+"&userid="+userid+"&name="+name;
	}
	if(way == 2)
	{
		url = "editprofile.do?way="+way+"&userid="+userid+"&contact_number="+contact_number;
	}
	if(way== 3)
	{
		var password = document.getElementById("Password").value;
		var confirm_password = document.getElementById("Confirm_Password").value;
		
		if(password===confirm_password)
			url="editprofile.do?way="+way+"&userid="+userid+"&password="+password;
		else 
			alert("Passwords dont't match");
	}
	
	if(way == 4)
	{
		url = "editprofile.do?way="+way+"&userid="+userid+"&emailid="+emailid;
	}
	
	var ajax = new XMLHttpRequest();
	ajax.open("POST",url,true);
	ajax.onreadystatechange = function()
	{
		if(ajax.readyState == 4)
			{
			alert(ajax.responseText);
			initial_name = name;
			initial_contact_number = contact_number; 
			initial_emailid= emailid;
			location.reload(true);
			}
	}
	ajax.send(null);
}

function checkchanges()
{
	var new_name = document.getElementById("Name").value;
	var new_contact_number = document.getElementById("Contact_Number").value;
	var new_emailid = document.getElementById("EmailId").value;	
	if(!(new_name===initial_name))
		updateprofile(1);
	if(!(new_contact_number===initial_contact_number))
		updateprofile(2);
	if(!(new_emailid===initial_emailid))
		updateprofile(4);
}

function deleteaccount(eventid)
{
	if(confirm("Are you sure you want to delete this account? "))
		{
		window.location.href="deleteaccount.do?userid="+eventid;
		}
}

</script>

</head>
<body>

<header id="all">

<jsp:include page="header.jsp"></jsp:include>

</header>

<div id="all">

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
<input type="text" name="name" id="Name" autocomplete="off" value="<%=name%>"/>
</td>
</tr>

<tr>
<td>
Email :
</td>
<td>
<input type="text" name="emailid" id="EmailId" autocomplete="off" value="<%=emailid%>"/>
</td>
</tr>

<tr>
<td>
Contact Number:
</td>
<td>
<input type="tel" name="contact_number" id="Contact_Number" autocomplete="off" value="<%=contact_number%>"/>
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
<!-- 
<tr>
<td>
Old Password : 
</td>
<td>
<input type="password" name="old_password" id="Old_Password" />
</td>
</tr>

 -->
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

