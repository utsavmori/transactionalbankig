<%@ page import="java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Page -NetBanking</title>
<h1><center>Net Banking</center></h1>
</head>
<body>
<%
try{	
	
if(session == null || session.getAttribute("uname") == null){
	 out.println("<h2>Your Session Has timed out!!!</h2>");
	 request.getRequestDispatcher("/index.jsp").include(request, response);	
	
	}
else{
	String unamew=session.getAttribute("uname").toString();
	
	if(unamew.equals(null) ){
		
	}
	else{
		
		Connection con=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking","root","");
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("SELECT 	* FROM acholder WHERE loginid='"+unamew+"'  ");
			if(rs.next()){				
				 String acno=rs.getString(1);
				 String name=rs.getString(2);
				 String actype=rs.getString(3);
				 double bal=rs.getDouble(4);	
				 out.println("<center>Welcome "+name);
					out.println("<br> Your Account No. "+acno);
					out.println("<br>Account Type: "+actype);
					out.println("<br>Balance: "+bal+"</center>");
			}			
		}
		catch(Exception e){e.printStackTrace();}		
}
}
}catch(Exception e){e.printStackTrace();}
%>
<hr><br>
<form action="logout" method="post" style="float: right;">
<input type="submit" value="Logout" >
</form>
<table border=1 align="center" cellpadding="10" style="border-collapse:collapse;">
<tr><td><a href="userpage.jsp">Home</a></td>
<tr><td><a href="statement.jsp">View Statement</a></td>
<td><a href="onlinetransfer.jsp">Online Transfer</a></td>
<td><a href="changepass.jsp">Change Password</a></td>
</table>

</body>
</html>