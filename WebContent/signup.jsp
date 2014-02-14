<%@page import="MyPackage.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
    
    
    
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Up</title>


<link rel="stylesheet" type="text/css" href="css/common.css" />
<link rel="stylesheet" type="text/css" href="css/signup.css" />

<script type="text/javascript" >
 
function signup()
{
	
	var isName=false,isPassword=false,isContact = false,isEmail=false;
	var password= new String(document.getElementById("Password").value).valueOf();
	var confirm_password= new String(document.getElementById("Confirm_Password").value).valueOf();
	var name = new String(document.getElementById("Name").value);
	var email=new String(document.getElementById("Email").value);
	var contact=new String(document.getElementById("Contact_Number").value);
	
	if(password.length == 0)
	{
		alert("Please enter a Password");
		return false;
	}
	else if(password.length<3)
	{
		alert("Password is too short");
		return false;
	}
	else if(password.length>32)
		{
		alert("Password is too long");
		return false;
		}
	else if(!(password===confirm_password))
		{
		alert("Passwords don't match");
		return false;
		}
	else
		isPassword = true;
	
	if(name.length == 0)
		{
		alert("Please enter a name");
		return false;
		}
	else 
		isName= true;
	
	if(email.length==0)
		{
		alert("Please enter an email");
		return false;
		}
	else
		isEmail=true;
	
	if(contact.length == 0)
		{
		alert("Please enter contact number");
		return false;
		}
	else
		isContact = true;
	
	if(isName==true && isPassword==true && isContact==true && isEmail==true) 
	{ 
		return true;
	}
	else
	{
		alert("Check the entries again");
		return false;
	}
}

</script>

</head>
<body>

<div id="all">

<a href="index.jsp"><button type="button"> Go to Login Page!</button></a>

<h1>
Sign up
</h1>


<div id="form">
<form onsubmit="return signup();" action="signup.do" method="post" id="signupform">

<table border="0">

<%

%>


<tr>
<td>
Name :
</td>
<td>
<input type="text" name="name" id="Name" autocomplete="off" value="<%=request.getAttribute("Name")!= null ? request.getAttribute("Name") : "" %>" />
</td>
</tr>

<tr>
<td>
E-Mail :
</td>
<td>
<input type="email" name="email" id="Email" autocomplete="off" value="<%=request.getAttribute("EmailId")!= null ? request.getAttribute("EmailId") : "" %>"/>
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
<input type="password" name="Confirm_Password" id="Confirm_Password" />
</td>
</tr>

<tr>
<td>
Contact Number:
</td>
<td>
<input type="tel" name="contact_number" id="Contact_Number" autocomplete="off" value="<%=request.getAttribute("Contact_Number")!= null ? request.getAttribute("Contact_Number") : "" %>"/>
</td>
</tr>

<tr>
<td colspan="2" align="center">


</td>
</tr>

<tr>
<td align="center" colwidth="2">

<button type="submit" name="Sign Up" value="Sign Up"> Sign Up</button>

</td>
</tr>

<script type="text/javascript">

<%
if(request.getAttribute("Wrong contact number")!= null && (Boolean)request.getAttribute("Wrong contact number")==true)
	out.write("alert(\"Contact Number is invalid\")");
%>

</script>


</table>

</form>

</div>

</div>

</body>
</html>