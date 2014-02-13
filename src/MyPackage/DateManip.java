package MyPackage;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat;


@SuppressWarnings("deprecation")
public class DateManip {
	
	static SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

	static String[] months = new String[]{"Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"}; 
	
	static String[] days = new String[]{"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"};
	
	public static Timestamp toTimestamp(String dateValues,String timeValues) throws Exception
	{
		
		//String dateString = dateValues + " " + timeValues;
		//Date d=  sdf.parse(dateString);
		Timestamp t = Timestamp.valueOf(dateValues+" "+timeValues+".0");
		return t;
	}
	
	public static String toDisplayDate(String ts) throws Exception
	{
		String dateString = ts.toString();
		Date d = sdf.parse(dateString);
		String displayDate = "";
		
		Calendar c = Calendar.getInstance();
		c.setTime(d);
		
		/*
		displayDate += days[d.getDay()]+" ";
		displayDate += months[d.getMonth()]+" , ";
		displayDate += c.get(Calendar.DATE)+" ";
		displayDate += new Integer(d.getYear()+1900).toString() +" ";
		
		if(d.getHours()>12)
		{
			if(d.getHours()-12 < 10)
				 displayDate+="0";
		displayDate += new Integer(d.getHours()-12).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
		displayDate += d.getMinutes()+" ";
		displayDate += " PM";
		}
		else
		{
			if(d.getHours()< 10)
				 displayDate+="0";
			displayDate += new Integer(d.getHours()).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
			displayDate += d.getMinutes()+" ";
			displayDate += " AM";
		}
		*/
		
		displayDate += d.getDate() + "-";
		displayDate += new Integer(d.getMonth()+1).toString() + "-" ;
		displayDate += new Integer(d.getYear()+1900).toString() + "  ";
		
		if(d.getHours()>12)
		{
			if(d.getHours()-12 < 10)
				 displayDate+="0";
		displayDate += new Integer(d.getHours()-12).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
		displayDate += d.getMinutes()+" ";
		displayDate += " pm  ";
		}
		else
		{
			if(d.getHours()< 10)
				 displayDate+="0";
			displayDate += new Integer(d.getHours()).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
			displayDate += d.getMinutes()+" ";
			displayDate += " am  ";
		}
		
		//displayDate += days[d.getDay()];
		
		return displayDate;
	}
	
	public static String toDisplayDate(Timestamp ts) throws Exception
	{
		String dateString = ts.toString();
		Date d = sdf.parse(dateString);
		String displayDate = "";
		
		Calendar c = Calendar.getInstance();
		c.setTime(d);
		
		/*
		displayDate += days[d.getDay()]+" ";
		displayDate += months[d.getMonth()]+" , ";
		displayDate += c.get(Calendar.DATE)+" ";
		displayDate += new Integer(d.getYear()+1900).toString() +" ";
		
		if(d.getHours()>12)
		{
			if(d.getHours()-12 < 10)
				 displayDate+="0";
		displayDate += new Integer(d.getHours()-12).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
		displayDate += d.getMinutes()+" ";
		displayDate += " PM";
		}
		else
		{
			if(d.getHours()< 10)
				 displayDate+="0";
			displayDate += new Integer(d.getHours()).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
			displayDate += d.getMinutes()+" ";
			displayDate += " AM";
		}
		*/
		
		displayDate += d.getDate() + "-";
		displayDate += new Integer(d.getMonth()+1).toString() + "-" ;
		displayDate += new Integer(d.getYear()+1900).toString() + "  ";
		
		if(d.getHours()>12)
		{
			if(d.getHours()-12 < 10)
				 displayDate+="0";
		displayDate += new Integer(d.getHours()-12).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
		displayDate += d.getMinutes()+" ";
		displayDate += " pm  ";
		}
		else
		{
			if(d.getHours()< 10)
				 displayDate+="0";
			displayDate += new Integer(d.getHours()).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
			displayDate += d.getMinutes()+" ";
			displayDate += " am  ";
		}
		
		//displayDate += days[d.getDay()];
		
		return displayDate;
		
	}
	
	public static String dateToDisplayDate(Date d) throws Exception
	{
		Calendar c = Calendar.getInstance();
		c.setTime(d);
		
		String displayDate="";	
		
		displayDate += days[d.getDay()]+" ";
		displayDate += months[d.getMonth()]+",";
		displayDate += c.get(Calendar.DATE)+" ";
		displayDate += new Integer(d.getYear()+1900).toString() +" ";
		
		if(d.getHours()>12)
		{
			if(d.getHours()-12 < 10)
				 displayDate+="0";
		displayDate += new Integer(d.getHours()-12).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
		displayDate += d.getMinutes()+"";
		displayDate += " PM";
		}
		else
		{
			if(d.getHours()< 10)
				 displayDate+="0";
			displayDate += new Integer(d.getHours()).toString()+":";
			if(d.getMinutes()<10)
				displayDate += "0";
			displayDate += d.getMinutes()+"";
			displayDate += " AM";
		}
		return displayDate;	
	}
	
	public static Date createDate(String dateValues, String timeValues) throws Exception
	{
		String dateString = dateValues + " " + timeValues;
		return sdf.parse(dateString);
	}

}
