
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html" %>

<%

if(request.getSession().getAttribute("User") != null)
	response.sendRedirect("home.do#tab1");

%>

<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Event Registration</title>

<link rel="stylesheet" type="text/css" href="css/index.css" />
<link rel="stylesheet" type="text/css" href="css/common.css" />

<script type="text/javascript">

function clearurl()
{
	m = document.URL.lastIndexOf("/",o);
	document.URL = document.URL.substring(0, m);
}

function verifysignin()
{
	var aj = new XMLHttpRequest();
	var email=document.getElementById("email").value;
	var pass = document.getElementById("pass").value;
	
	aj.open("POST","verifysignin.jsp?Email="+email+"&Password="+pass , true);
	
	aj.onreadystatechange = function()
	{
		if(aj.readyState ==4) 
			{
				document.getElementById("check_message").innerHTML = aj.responseText;
				if(aj.responseText.length == 13)
				{
					window.location.href="home.jsp#tab1";
				}; 
			}
	}
	aj.send(null);
} 
 
function gotosignup(type)
{
	window.location.href="signup.jsp?Account_Type="+new String(type);
}
	
</script>

</head>
<body onload="clearurl();">

<div id="index">
<h1>
Events 
</h1>

<table border="1" cellspacing="5">

<tr>
<td>
<div class="column" id="info">

</div>
</td>
<td>
<div class="column" id="signin">

<table id="form">

<form action="home.do#tab1" method="POST" >

<tr>
<td>

<input type="email" name="email" id="email" placeholder="Email" />

</td>
</tr>

<tr>
<td>

<input type="password" name="password" id="password" placeholder="Password" />

</td>
</tr>
 
<tr>
<td>
<div id="Signin_Message">


 </div> 
</td>
</tr>

<tr>
<td>

<button type="submit"> Sign In </button>
</td>
</tr>

</form>

<tr>
<td>

Don't have an account ? 

</td>
</tr>

<tr>
<td>

<a href="signup.jsp"> <button type="button"> Sign Up here! </button> </a>

</td>
</tr>

</table>

</div>
</td>
<td>
<div class="column" id="popular_events" >
<!--  
<table id="popular_events_table" border="1">

<tr>
<th>  <h4> Recent Events </h4> 
</th>
</tr>

</table>
-->
</div>
</td>
</tr>

</table>

</div>
</body>
</html>

