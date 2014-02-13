<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 
//For registered , unregistered
if(request.getAttribute("Registered") != null && (Boolean)request.getAttribute("Registered") == true )
	if((Boolean)request.getAttribute("Registered") == true)
		out.write("Registered");   //If this response is changed, update length in regunreg.js --> registerforevent()

		
if(request.getAttribute("RegFailure")!= null && (Boolean)request.getAttribute("RegFailure") == true )
	out.write("Registration Failure.Not enough vacancites");
		
		
if(request.getAttribute("Unregistered") != null  && (Boolean)request.getAttribute("Unregistered") == true)
	if((Boolean)request.getAttribute("Unregistered") == true)
		out.write("Unregistered");  //If this response is changed, update length in regunreg.js --> unregisterforevent()

%>

<% 

//For profile edits

if(request.getAttribute("Profile edited") != null && (Boolean)request.getAttribute("Profile edited") == true )
{
	out.write( request.getAttribute("Changed Attribute") + " has been updated! ");
}


if(request.getAttribute("Profile edited") != null && (Boolean)request.getAttribute("Profile edited") == false ) //For wrong email -ADMIN ONLY
{
	if(new String((String)request.getAttribute("Changed Attribute")).equals("Email"))
		out.write("Email already exists. Enter a new one");
	if(new String((String)request.getAttribute("Changed Attribute")).equals("Password"))
		out.write("Old password is wrong!");
}

/*
if(request.getAttribute("Profile edited") != null && (Boolean)request.getAttribute("Profile edited") == false ) //For wrong password
{
	out.write("Old" + request.getAttribute("Changed Attribute") + " is wrong! ");
}
*/
// For score updating

if(request.getAttribute("Scored") != null && (Boolean)request.getAttribute("Scored") == true)
{
	out.write("Score is updated");
}

if(request.getAttribute("Scored") != null && (Boolean)request.getAttribute("Scored") == false)
{
	out.write("Something went wrong. Check the scores you entered");
}

%>

<%

//For admin event status change

if(request.getAttribute("Status") != null)
{
	if(new String((String)request.getAttribute("Status")).equals("A"))
	{
		out.write("Approved");
	}
	
	if(new String((String)request.getAttribute("Status")).equals("R"))
	{
		out.write("Rejected");
	}
	
	if(new String((String)request.getAttribute("Status")).equals("P"))
	{
		out.write("Pending ");
	}
}

%>


