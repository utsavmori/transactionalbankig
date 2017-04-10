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
String hname=request.getParameter("hname");
String bdate=request.getParameter("bdate");
String act=request.getParameter("act");
String bal=request.getParameter("bal");
String minbal=request.getParameter("minbal");
String idtype=request.getParameter("idtype");
String idno=request.getParameter("idno");
String debno=request.getParameter("debno");
String lid=request.getParameter("lid");
String lpass=request.getParameter("lpass");


if(hname.equals(null) && bdate.equals(null) && act.equals(null) && bal.equals(null) && minbal.equals(null) && idtype.equals(null) && idno.equals(null) && lid.equals(null) && lpass.equals(null)&& debno.equals(null) ){
	
}
else{
	Connection con=null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking","root","");
		Statement stmt=con.createStatement();
		int rs=stmt.executeUpdate("INSERT INTO acholder (bdate,name,actype,balance,minbal,idcardtype,idcardno,debitcardno,loginid,pass) VALUES ('"+bdate+"','"+hname+"','"+act+"','"+bal+"','"+minbal+"','"+idtype+"','"+idno+"','"+debno+"','"+lid+"','"+lpass+"')");
		if(rs>0){
			out.println("<h2>Records inserted<h2>");
			
		}
		else{
			out.println("<h2>Something is wrong<h2>");
		}
		
	}
	catch(Exception e){e.printStackTrace();}
}
}
}catch(Exception e){e.printStackTrace();}
%>
<form action="logout" method="post" style="float: right;">
<input type="submit" value="Logout" >
</form>
<fieldset><legend>New Account</legend>
<form action="newuser.jsp" method="post">
<table>
<tr><td>Name<td><input type="text" name="hname"></td>
<tr><td>Bdate</td><td><input type="date" name="bdate"></td>
<tr><td>Account Type</td><td> <select name="act"><option value="SAVING">SAVING</option><option value="CURRENT">CURRENT</option><option value="TDR">TDR</option></select></td>
<tr><td>Balance</td><td><input type="number" min="1000" name="bal"></td>
<tr><td>Minimum Balance</td><td><input type="number" min="0" name="minbal"></td>
<tr><td>ID Card Type</td><td><input type="text" name="idtype"></td>
<tr><td>ID Card Number</td><td><input type="text" name="idno"></td>
<tr><td>Debit Card Number</td><td><input type="text" name="debno"></td>
<tr><td>Login Id</td><td><input type="text" name="lid"></td>
<tr><td>Login Password</td><td><input type="text" name="lpass"></td>
<tr><td><input type="submit" value="Add User"></td>
</table>
</form>
</fieldset>
</body>
</html>