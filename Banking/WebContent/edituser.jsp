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

<form action="edituser.jsp" method="post">
Enter Account Number:&nbsp;&nbsp;<input type="number" min="0" name="acno">&nbsp;&nbsp;&nbsp;
<input type="submit" >
</form>

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
		ResultSet rs=stmt.executeQuery("SELECT * FROM acholder WHERE acno='"+uname+"' ");
		
		
		if(rs.next()){
			String acno=rs.getString(1);
			String bday=rs.getString(2);
			String name=rs.getString(3);
			String actype=rs.getString(4);
			String bal=rs.getString(5);
			String minbal=rs.getString(6);
			String idcardtype=rs.getString(7);
			String idcardno=rs.getString(8);
			String debno=rs.getString(9);
			String lid=rs.getString(10);
			String pass=rs.getString(11);
			out.println("<form action=\"handleedit\" method=\"post\">");
			out.println("<table>");
			out.println("<tr><td>A/C NO<td><input type=\"text\" value=\""+acno+"\" name=\"acno\" readonly></td>"
					+"<tr><td>Name<td><input type=\"text\" value=\""+name+"\" name=\"hname\"></td>"
					+"<tr><td>Bdate</td><td><input type=\"date\" value=\""+bday+"\" name=\"bdate\"></td>"
					+"<tr><td>Account Type</td><td> <select name=\"act\"><option value=\"SAVING\">SAVING</option><option value=\"CURRENT\">CURRENT</option><option value=\"TDR\">TDR</option></select></td>"
					+"	<tr><td>Balance</td><td><input type=\"number\" value=\""+bal+"\" min=\"1000\" name=\"bal\"></td>"
					+"<tr><td>Minimum Balance</td><td><input type=\"number\" value=\""+minbal+"\" min=\"0\" name=\"minbal\"></td>"
					+"<tr><td>ID Card Type</td><td><input type=\"text\" value=\""+idcardtype+"\" name=\"idtype\"></td>"
					+"<tr><td>ID Card Number</td><td><input type=\"text\" value=\""+idcardno+"\" name=\"idno\"></td>"
					+"<tr><td>Debit Card Number</td><td><input type=\"text\" value=\""+debno+"\" name=\"debno\"></td>"
					+"<tr><td>Login Id</td><td><input type=\"text\" value=\""+lid+"\" name=\"lid\"></td>"
					+"<tr><td>Login Password</td><td><input type=\"text\" value=\""+pass+"\" name=\"lpass\"></td>"
					+"<tr><td><input type=\"submit\" value=\"Edit User\"></td>");
			out.println("</table></form>");
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



</body>
</html>