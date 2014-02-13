package bean;

import org.apache.struts.action.ActionForm;

public class EditEventBean extends ActionForm {
	
	private String name, description,event_type,limit;
	
	private int eventid,registration_limit;
	
	public String getName()
	{
		return name;
	}
	
	public String getDescription()
	{
		return description;
	}
	
	public String getEvent_type()
	{
		return event_type;
	}
	
	public String getLimit()
	{
		return limit;
	}
	
	public int getRegistration_limit()
	{
		return registration_limit;
	}
	
	public int getEventid()
	{
		return eventid;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public void setDescription(String description)
	{
		this.description = description;
	}
	
	public void setEvent_type(String event_type)
	{
		this.event_type = event_type;
	}
	
	public void setLimit(String limit)
	{
		this.limit = limit;
	}
	
	public void setRegistration_limit(int registration_limit)
	{
		this.registration_limit = registration_limit;
	}
	
	public void setEventid(int eventid)
	{
		this.eventid = eventid;
		
	}

}
