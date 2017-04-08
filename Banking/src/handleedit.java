
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class handleedit
 */
@WebServlet("/handleedit")
public class handleedit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public handleedit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
	
		String acno=request.getParameter("acno");
		String name=request.getParameter("hname");
		String bdate=request.getParameter("bdate");
		String bal=request.getParameter("bal");
		String minbal=request.getParameter("minbal");
		String act=request.getParameter("act");
		String idtype=request.getParameter("idtype");
		String idno=request.getParameter("idno");
		String debno=request.getParameter("debno");
		String lid=request.getParameter("lid");
		String lpass=request.getParameter("lpass");
		
		
		
		 try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Connection con=null;
			try {
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/banking","root","");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				
				e.printStackTrace();
			}
			Statement stmt = null;
			try {
				stmt = con.createStatement();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			try {
				
				int rs=stmt.executeUpdate("UPDATE acholder SET name='"+name+"',bdate='"+bdate+"',balance='"+bal+"',minbal='"+minbal+"',actype='"+act+"',idcardtype='"+idtype+"',idcardno='"+idno+"',debitcardno='"+debno+"',loginid='"+lid+"',pass='"+lpass+"'  WHERE acno='"+acno+"' ");
				if(rs>0){
					PrintWriter p=response.getWriter();
					p.println("Successfully Edited ");
					request.getRequestDispatcher("edituser.jsp").include(request, response);
				}
				else{PrintWriter p=response.getWriter();
				p.println("Failed Edition ");
				request.getRequestDispatcher("edituser.jsp").include(request, response);}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			
			

		
		
		
	}

}
