package bean;

import org.apache.struts.action.ActionForm;

public class CreateEventBean  extends ActionForm {
	
	private static final long serialVersionUID = 4L;
	
	private String name,description,location,event_type;
	
	private String start_day,start_month, start_year, start_minute ;
	
	private int start_hour;
	
	private String end_day,end_month, end_year, end_minute ;
	
	private int end_hour;
	
	private String start_AMPM, end_AMPM;
	
	private String limit;
	
	private Integer registration_limit=0;
	
	//Getters
	
	public String getName()
	{
		return name;
	}
	
	public String getDescription()
	{
		return description;
	}
	
	public String getLocation()
	{
		return location;
	}
	
	public String getEvent_type()
	{
		return event_type;
	}
	
	public String getStart_month()
	{
		return start_month;
	}
	
	public String getStart_day()
	{
		return start_day;
	}
	
	public String getStart_year()
	{
		return start_year;
	}
	
	public int getStart_hour()
	{
		return start_hour;
	}
	
	public String getStart_minute()
	{
		return start_minute;
	}
	
	public String getStart_AMPM()
	{
		return start_AMPM;
	}
	
	public String getEnd_month()
	{
		return end_month;
	}

	public String getEnd_day()
	{
		return end_day;
	}

	public String getEnd_year()
	{
		return end_year;
	}

	public int getEnd_hour()
	{
		return end_hour;
	}

	public String getEnd_minute()
	{
		return end_minute;
	}

	public String getEnd_AMPM()
	{
		return end_AMPM;
	}
	
	public String getLimit()
	{
		return limit;
	}
	
	public Integer getRegistration_limit()
	{
		if(limit.equals("N"))
			this.registration_limit = -1;
		
		return registration_limit;
	}
	
	// Setters
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	public void setDescription(String description) 
	{
		this.description = description;
	}
	
	public void setLocation(String location)
	{
		this.location = location;
	}
	
	public void setEvent_type(String event_type)
	{
		this. event_type = event_type;
	}
	
	public void setStart_month(String start_month)
	{
		this.start_month = start_month;
	}
	
	public void setStart_day(String start_day)
	{
		this. start_day = start_day;
	}
	
	public void setStart_year(String start_year)
	{
		this. start_year = start_year;
	}
	
	public void setStart_hour(int start_hour)
	{
		this. start_hour = start_hour;
	}
	
	public void setStart_minute(String start_minute)
	{
		this.start_minute= start_minute;
	}
	
	public void setStart_AMPM(String start_AMPM)
	{
		this. start_AMPM = start_AMPM;
	}
	
	public void setEnd_month(String end_month)
	{
		this.end_month  = end_month;
	}

	public void setEnd_day(String end_day)
	{
		this.end_day = end_day;
	}

	public void setEnd_year(String end_year)
	{
		this.end_year = end_year;
	}

	public void setEnd_hour(int end_hour)
	{
		this. end_hour = end_hour;
	}

	public void setEnd_minute(String end_minute)
	{
		this. end_minute = end_minute;
	}

	public void setEnd_AMPM(String end_AMPM)
	{
		this. end_AMPM = end_AMPM;
	}
	
	public void setLimit(String limit)
	{
		this.limit = limit;
	}
	
	public void setRegistration_limit(Integer registration_limit)
	{
		this. registration_limit = registration_limit;
	}
	
}
