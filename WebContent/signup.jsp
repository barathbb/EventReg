<%@page import="MyPackage.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
    
    <% boolean has=false;
    User u = null;
    if(request.getAttribute("UserData") != null){
    	u = (User)request.getAttribute("UserData"); has = true;}
    	%>
    
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
	
	if(password.length<3)
		alert("Password is too short");
	else if(password.length>32)
		alert("Password is too long");
	else if(!(password===confirm_password))
		alert("Passwords don't match");
	else
		isPassword = true;
	
	if(name.length == 0)
		alert("Please enter a name");
	else 
		isName= true;
	
	if(email.length==0)
		alert("Please enter an email");
	else
		isEmail=true;
	
	if(contact.length == 0)
		alert("Please enter contact number");
	else
		isContact = true;
	
	if(isName==true && isPassword==true && isContact==true && isEmail==true) 
	{ 
		window.location.href="signup.do?name="+name+"&email="+email+"&password="+password+"&contact_number="+contact;
		//document.getElementById("signupform").submit();
	}
	else
		alert("Check the entries again");
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
<form action="javascript:signup();" method="post" id="signupform">

<table border="0">

<tr>
<td>
Name :
</td>
<td>
<input type="text" name="Name" id="Name" autocomplete="off" value="<%  out.write(has ? u.getName() : ""); %>" />
</td>
</tr>

<tr>
<td>
E-Mail :
</td>
<td>
<input type="email" name="Email" id="Email" autocomplete="off" value="<%  out.write(has ? u.getEmailId() : ""); %>"/>
</td>
</tr>

<tr>
<td>
Password :
</td>
<td>
<input type="password" name="Password" id="Password" />
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
<input type="tel" name="Contact_Number" id="Contact_Number" autocomplete="off" value="<%  out.write(has ? u.getContact_Number() : ""); %>"/>
</td>
</tr>

<tr>
<td colspan="2" align="center">
<% if(request.getAttribute("Message") != null)
	 out.write(request.getAttribute("Message").toString());
	%>

</td>
</tr>

<tr>
<td align="center" colwidth="2">

<button type="submit" name="Sign Up" value="Sign Up"> Sign Up</button>

<!--  

<input type="submit" name="sign_up" value="Sign Up" />

 -->

</td>
</tr>

</table>

</form>

</div>

</div>

</body>
</html>