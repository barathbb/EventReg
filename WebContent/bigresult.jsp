<html>
<head>  

<link rel="stylesheet" type="text/css" href="css/common.css" />

</head>

<body>
<div id="all">
<p align="Center">
<% 

//For new user creation(Signup)

if(request.getAttribute("Signup") != null && (Boolean)request.getAttribute("Signup") == true)
{

out.write("Successfully signed in"); %>
</p>
<form action="home.do#tab1" method="post">

<input type="hidden" name="email" value="<%=request.getAttribute("email") %>" />

<input type="hidden" name="password" value="<%=request.getAttribute("password") %>" />

<button type="submit" align="Center"> Click to go to home page! </button>

</form>

<% } %>


<%

//For new event creation

if(request.getAttribute("Event Created") != null && (Boolean)request.getAttribute("Event Created") == true) 

{ 

	out.write("<h4> Event is waiting for Admin approval. The event will be published as soon as the admin approves it </h4>");

%>

<a href="home.do#tab3"><button type="submit" align="center"> Go home!  </button></a>

<% } %>


<%

//For new event creation

if(request.getAttribute("FullEdit") != null && (Boolean)request.getAttribute("FullEdit") == true) 

{ 

	out.write("<h4> Event is edited succssfully, and waiting for Admin approval. The event will be published as soon as the admin approves it </h4>");

%>

<a href="home.do#tab3"><button type="submit" align="center"> Go home!  </button></a>

<% } %>

</div>
</body>

</html>