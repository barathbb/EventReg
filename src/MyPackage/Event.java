package MyPackage;

import MyPackage.Utils;
import MyPackage.DateManip;
import java.sql.Connection;
import java.sql.Timestamp;

public class Event {
	
	private String Name, Description,Event_Type,Location;
	
	private int EventId,Event_Owner,Registration_Limit;
	
	private Timestamp Start_Date, End_Date;
	
	private boolean isAvailable;
	
	private String status;
	
	public Event()
	{
		this.Name = "New Name";
	}
	
	public Event( int EventId, String Name, String Description, String Event_Type, Timestamp Start_Date, Timestamp End_Date, String Location, int Registration_Limit, int Event_Owner,boolean a)
	{
		this.Name = Name;
		this.Description= Description;
		this.Event_Type = Event_Type;
		this.Location = Location;
		this.EventId = EventId;
		this.Event_Owner=Event_Owner;
		this.Registration_Limit=Registration_Limit;
		this.Start_Date = Start_Date;
		this.End_Date = End_Date;
		this.isAvailable = a;
		//this.isRegistered = r;
	}
	
	public String getName()
	{
		return Name;
	}
	
	public String getDescription()
	{
		return Description;
	}
	
	public String getEvent_Type()
	{
		return Event_Type;
	}
	
	public String getEvent_Type(Connection conn) throws Exception
	{
		return Utils.getFullEventType(Event_Type, conn);
	}
	
	public String getLocation()
	{
		return Location;
	}
	
	public String getLocation(Connection conn) throws Exception
	{ 
		return Utils.getLocationName(Location, conn);
	}
	
	public String getFullLocation(Connection conn)  throws Exception
	{
		return Utils.getLocationName(Location, conn);
	}
	
	public int getEventId()
	{
		return EventId;
	}
	
	public int getEvent_Owner()
	{
		return Event_Owner;
	}
	
	public int getRegistration_Limit()
	{
		return Registration_Limit;
	}
	
	public Timestamp getStart_Date() 
	{
		return Start_Date;
	}
	
	public Timestamp getEnd_Date()
	{
		return End_Date;
	}
	
	public String getEnd_DateAsString() throws Exception
	{
		return DateManip.toDisplayDate(End_Date);
	}
	
	public String getStart_DateAsString() throws Exception
	{
		return DateManip.toDisplayDate(Start_Date);
	}
	
	public void setName(String Name)
	{
		this.Name = Name;
	}
	
	public void setDescription(String Description)
	{
		this.Description= Description;
	}
	
	public void setEvent_Type(String Event_Type)
	{
		this.Event_Type = Event_Type;
	}
	
	public void setLocation(String Location)
	{
		this.Location = Location;
	}
	
	public void setEventId(int EventId)
	{
		this.EventId = EventId;
	}
	
	public void setEvent_Owner(int Event_Owner)
	{
		this.Event_Owner=Event_Owner;
	}
	
	public void setRegistration_Limit(int Registration_Limit)
	{
		this.Registration_Limit=Registration_Limit;
	}
	
	public void setStart_Date(Timestamp t)
	{
		this.Start_Date = t;
	}
	
	public void setEnd_Date(Timestamp t)
	{
		this.End_Date= t;
	}
	
	public boolean getAvailable()
	{
		return isAvailable;
	}
	
	public void setAvailable(boolean b)
	{
		this.isAvailable = b;
	}
	
	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}
	
}

