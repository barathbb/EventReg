
function registerforevent(eventID,button)
	{
	
	//alert(eventID);
		var url = new String("register.do?eventid="+eventID+"&reg=true&unreg=false");
		a = new XMLHttpRequest();
		a.open("POST",url,true);
		a.onreadystatechange = function()
		{
			//alert(a.responseText);
			if(a.readyState == 4)
				{
				//alert(a.responseText + a.responseText.length); 
				//if(a.responseText.length == 14)   //Size depends on responseText. Update size if there's a change in responseText
				if(a.responseText > 40)
					{
					//alert(button.innerHTML);
					alert(a.responseText);
					}
				else
					{
					button.innerHTML = "Unregister";
					button.setAttribute("class","Unregister");
					button.setAttribute("onclick","unregisterforevent("+eventID+",this)");
					updateREL(eventID,"R");
					}
					
				}
		} 
		a.send(null);
	}
	
	function unregisterforevent(eventID,button)
	{
		//alert(eventID);
		
		if(confirm("Are you sure you want to unregister ? "))
			{
		var url = new String("unregister.do?eventid="+eventID+"&unreg=true&reg=false");
		a = new XMLHttpRequest();
		a.open("POST",url,true);
		a.onreadystatechange = function()
		{
			//alert(a.responseText);
			if(a.readyState == 4)
				{
				//alert(a.responseText + a.responseText.length); 
				//if(a.responseText.length ==16) //Size depends on responseText. Update size if there's a change in responseText
				if(a.responseText.length > 2)	
					{
					//alert(button.innerHTML);
					button.innerHTML = "Register";
					button.setAttribute("class","Register");
					button.setAttribute("onclick","registerforevent("+eventID+",this)");
					updateREL(eventID,"UR");
					}
				}
		}
		a.send(null);
			}
	}