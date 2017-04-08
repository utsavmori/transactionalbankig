<%@ page import="java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Home -Net Banking</title>
<h2><center>Net Banking Admin</center></h2>
<table align="center" border=1 style="border-collapse:collapse" cellpadding="10">
<td><a href="newuser.jsp">New User</a></td>
<td><a href="edituser.jsp">Edit User</a></td>
<td><a href="deleteuser.jsp">Delete User</a></td>
</table>
<hr><br>
</head>
<body>
<%
		
try{	
if(session == null || session.getAttribute("aname") == null){
	 out.println("<h2>Your Session Has timed out!!!</h2>");
	 request.getRequestDispatcher("/admin.jsp").forward(request, response);			 
	}
else{
String uname=request.getParameter("acno");


if(uname.equals(null) ){
	
}
else{
	Connection con=null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking","root","");
		Statement stmt=con.createStatement();
		int rs=stmt.executeUpdate("DELETE FROM acholder WHERE acno='"+uname+"' ");
		
		
		if(rs>0){
			out.println("<h2>Record Deleted<h2>");
			
		}
		else{
			out.println("<h2>Wrong Account Number<h2>");
		}
		
	}
	catch(Exception e){e.printStackTrace();}
}
}
}catch(Exception e){e.printStackTrace();}
%>

<div style="width:800px; margin:200px auto;">
<Fieldset><legend>Delete User</legend>

<form action="deleteuser.jsp" method="post">
Enter Account Number:&nbsp;&nbsp;<input type="number" min="0" name="acno"><br><br>
<input type="submit" value="Delete"/> 
</form>
</Fieldset>
</div>
</body>
</html>