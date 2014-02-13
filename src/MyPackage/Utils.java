package MyPackage;
import java.sql.*;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

public class Utils {

	public static String getStatus(int EventId,Connection conn) throws Exception
	{
		String status="";
		PreparedStatement pt1 = conn.prepareStatement("select Status from Events where EventId = ? ");
		pt1.setInt(1, EventId);
		
		ResultSet rs = pt1.executeQuery();
		
		while(rs.next())
			status=rs.getString("Status");
		return status;
	}
	
	public static String getAllLocations(Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select * from LocationList");
		ResultSet rs = pt1.executeQuery();
		
		String list="";
		while(rs.next())
			list += "<option value=\""+rs.getString("Code")+"\"> "+ rs.getString("Name") + "</option>" ;
		return list;
		
	}
	
	public static String getLocationsWithSelected(String Code,Connection conn) throws Exception
	{
		
		PreparedStatement pt1 = conn.prepareStatement("select * from LocationList where Code = ?");
		pt1.setString(1, Code);
		ResultSet rs = pt1.executeQuery();
		
		String list="";
		while(rs.next())
			list += "<option value=\""+rs.getString("Code")+"\"> "+ rs.getString("Name") + "</option>" ;
		
		PreparedStatement pt2 = conn.prepareStatement("select * from LocationList where Code <> ?");
		pt2.setString(1, Code);
		rs = pt2.executeQuery();

		while(rs.next())
			list += "<option value=\""+rs.getString("Code")+"\"> "+ rs.getString("Name") + "</option>" ;
		
		return list;
		
	}
	
	public static String getLocationName(String Code,Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select Name from LocationList where Code = ?");
		pt1.setString(1, Code);
		
		ResultSet rs = pt1.executeQuery();
		String Name ="";
		while(rs.next())
			Name = rs.getString("Name");
		return Name;
	}
	
	public static String getAllEventTypes(Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select EventType,EventName from EventTypes");
		ResultSet rs = pt1.executeQuery();
		
		String list="";
		while(rs.next())
			list+= "<option value=\"" + rs.getString("EventType") + "\"> " + rs.getString("EventName") + "</option>";
		
		return list;
	}
	
	public static String getEventTypesWithSelected(String EventType,Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select EventType,EventName from EventTypes where EventType = ?");
		pt1.setString(1, EventType);
		ResultSet rs = pt1.executeQuery();
		
		String list="";
		while(rs.next())
			list+= "<option value=\"" + rs.getString("EventType") + "\"> " + rs.getString("EventName") + "</option>";
		
		PreparedStatement pt2 = conn.prepareStatement("select EventType,EventName from EventTypes where EventType <> ?");
		pt2.setString(1, EventType);
		rs = pt2.executeQuery();
	
		while(rs.next())
			list+= "<option value=\"" + rs.getString("EventType") + "\"> " + rs.getString("EventName") + "</option>";
		
		return list;
	}
	
	public static String getFullEventType(String Type,Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select EventName from EventTypes where EventType = ?");
		pt1.setString(1, Type);
		ResultSet rs = pt1.executeQuery();
		
		String fulltype="";
		while(rs.next())
			fulltype=rs.getString("EventName");
		return fulltype;
	}
	
	public static String getNameFromUserId(int UserId, Connection conn) throws Exception
	{
		String Name="";
		PreparedStatement pt1 = conn.prepareStatement("select Name from Users where UserId = ? ");
		pt1.setInt(1, UserId);
		
		ResultSet rs = pt1.executeQuery();
		while(rs.next())
			Name = rs.getString("Name");
		return Name;
	}
	
	public static  boolean isRegistered(int EventId, int UserId, Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select * from EventReg where EventId = ? and UserId = ?");
		pt1.setInt(1, EventId);
		pt1.setInt(2, UserId);
		
		ResultSet rs = pt1.executeQuery();
		
		if(rs == null)
			return false;
		else 
			return true;
	}
	
	public static boolean isAvailable(int EventId, int Registration_Limit, Connection conn) throws Exception
	{
		if(Registration_Limit == -1)
			return true;
		PreparedStatement pt1 = conn.prepareStatement("select count(*) from EventReg where EventId = ? ");
		pt1.setInt(1, EventId);
		
		ResultSet rs = pt1.executeQuery();
		
		int limit=0;
		
		while(rs.next())
		{
			limit=rs.getInt("count(*)");
		}
		if(limit < Registration_Limit)
			return true;
		else
			return false;
	}
	
	public static boolean isAvailable(int EventId,Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select Registration_Limit from Events where EventID = ?");
		pt1.setInt(1, EventId);
		
		int rl = 0;
		
		ResultSet rs = pt1.executeQuery();
		while(rs.next())
			rl = rs.getInt("Registration_Limit");
		
		return Utils.isAvailable(EventId, rl, conn);
	}
	
	public static String[][] getEventsForDisplay(List<Integer> EventIdList,Connection conn) throws Exception
	{
		String[][] EventDetails = new String[EventIdList.size()][3]; 
		int i=0;
		ResultSet rs = null;
		
		for(Integer Id : EventIdList)
		{
			PreparedStatement pt1 = conn.prepareStatement("select EventId,Name,Registration_Limit from Events where EventId = ?");
			pt1.setInt(1, Id);
			
			rs = pt1.executeQuery();
			
			while(rs.next())
			{
				EventDetails[i][0] = new Integer(rs.getInt("EventId")).toString();
				EventDetails[i][1] = rs.getString("Name");
				EventDetails[i][2] = new Integer(rs.getInt("Registration_Limit")).toString();
			}
			i++;
		}
		return EventDetails;
	}
	
	
	public static String[] getUserDetails(Integer UserId,Connection conn) throws Exception
	{
		
		String[] userDetails = new String[4];
		PreparedStatement pt1 = conn.prepareStatement("select Name,EmailId,Contact_Number from Users where UserId = ?");
		pt1.setInt(1, UserId);
		ResultSet rs = pt1.executeQuery();
		
		//User thisUser=null;
		while(rs.next())
		{
			userDetails[0] = rs.getString("Name");
			userDetails[1] = rs.getString("EmailId");
			userDetails[2] = rs.getString("Contact_Number");
			//userDetails[3] = rs.getString("Account_Type");
		}
		
		return userDetails;
		//return thisUser;
	}
	
	public static List<Event> getEventDetails(List<Integer> REL, Connection conn) throws Exception
	{
		List<Event> eventlist = new ArrayList<Event>();
		
		ResultSet rs; boolean a;
		for(Integer EventId : REL)
		{
		PreparedStatement pt1 = conn.prepareStatement("select * from Events where EventId = ? and Status = ?");
		pt1.setInt(1, EventId);
		pt1.setString(2, "A");
		rs = pt1.executeQuery();
		while(rs.next())
			{
				a = Utils.isAvailable(rs.getInt("EventId"),rs.getInt("Registration_Limit"),conn);
				//r = Utils.isRegistered(rs.getInt("EventId"),rs.getInt("UserId"),conn);
				eventlist.add(new Event(rs.getInt("EventId"),rs.getString("Name"),rs.getString("Description"),rs.getString("Event_Type"),rs.getTimestamp("Start_Date"),rs.getTimestamp("End_Date"),rs.getString("Location"),rs.getInt("Registration_Limit"),rs.getInt("Event_Owner"),a));
			}
		}
		return eventlist;
	}
	
	public static boolean hasScore(int EventId,Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select Event_Type from Events where EventId = ? ");
		pt1.setInt(1,EventId);
		
		String Event_Type="";
		
		ResultSet rs = pt1.executeQuery();
		while(rs.next())
			Event_Type = rs.getString("Event_Type");
		
		PreparedStatement pt2 = conn.prepareStatement("select Scoring from EventTypes where EventType=?");
		pt2.setString(1, Event_Type);
		
		rs = pt2.executeQuery();
		int scoring=0;
		
		while(rs.next())
			scoring = rs.getInt("Scoring");
		
		if(scoring == 0)
			return false;
		else
			return true;
	}
	
	public static int getScore(int UserId,int EventId, Connection conn ) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select Points from Points where UserId = ? and EventId = ? ");
		pt1.setInt(1, UserId);
		pt1.setInt(2, EventId);
		
		int point=0;
		
		ResultSet rs = pt1.executeQuery();
		
		if(rs == null)
			return 0;
		
		while(rs.next())
		{
			point = rs.getInt("Points");
		}
		return point;
	}
	
	public static void updateName(String Name,Integer UserId, Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("update Users set Name = ? where UserId = ?");
		pt1.setString(1, Name);
		pt1.setInt(2, UserId);
		pt1.execute();
	}
	
	public static void updateContact_Number(String Contact_Number,Integer UserId, Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("update Users set Name = ? where UserId = ?");
		pt1.setString(1, Contact_Number);
		pt1.setInt(2, UserId);
		pt1.execute();
	}
	
	public static void updatePassword(Integer UserId, String Password,Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("update Users set Password = ? where UserId = ?");
		pt1.setString(1,Password);
		pt1.setInt(2, UserId);
		pt1.execute();
	}
	
	public static boolean Register(Integer UserId, Integer EventId,Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select * from EventReg where EventId = ? and UserId = ?");
		pt1.setInt(1, EventId);
		pt1.setInt(2, UserId);
		
		ResultSet rs = pt1.executeQuery();
		
		if(rs.last())
			return true;
		else
			return false;
	}
	
	public static boolean isMyEvent(Integer UserId , Integer EventId, Connection conn) throws Exception
	{
		PreparedStatement pt1 = conn.prepareStatement("select Event_Owner from Events where EventId = ?");
		pt1.setInt(1, EventId);
		
		ResultSet rs = pt1.executeQuery();
		Integer i = 0;
		while(rs.next())
			i = rs.getInt("Event_Owner");
		
		if(i == UserId)
			return true;
		else 
			return false;
	}
}
