<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
Class.forName("com.mysql.jdbc.Driver");
String id = request.getParameter("id");
String pw = request.getParameter("pw");
System.out.println(id + "<-- id");
System.out.println(pw + "<-- pw");
String dbid = null;
String dbpw = null;
String dbname = null;
String dblevel = null;
try{
	String jdbcDriver = "jdbc:mysql://localhost:3306/dev27db?" +
			"useUnicode=true&characterEncoding=euckr";
	String dbUser = "dev27id";
	String dbPass = "dev27pw";
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	System.out.println(conn + "<-- conn");
	pstmt = conn.prepareStatement("select * from tb_member WHERE m_id=?");
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	if(rs.next()){
		System.out.println("01 아이디일치 조건");
		dbid = rs.getString("m_id");
		dbpw = rs.getString("m_pw");
		dblevel = rs.getString("m_level");
		dbname = rs.getString("m_name");
		if(pw.equals(dbpw)){
			System.out.println("03 로그인 성공 조건");
			session.setAttribute("S_ID", dbid);
			session.setAttribute("S_NAME", dbname);
			session.setAttribute("S_LEVEL", dblevel);
%>
<script type="text/javascript">
	alert('로그인성공');
	location.href="<%= request.getContextPath()%>/index.jsp";
</script>
<%			
		}else{
			System.out.println("04 비번 불일치 조건");
%>
<script type="text/javascript">
	alert('비번불일치');
	location.href="<%= request.getContextPath()%>/index.jsp";
</script>
<%			
		}
		
	}else{
		System.out.println("02 아이디 불일치 조건");
%>
<script type="text/javascript">
	alert('아이디불일치');
	location.href="<%= request.getContextPath()%>/index.jsp";
</script>
<%		
	}
	
	
} catch(SQLException ex) {
	out.println(ex.getMessage());
	ex.printStackTrace();
} finally {
	if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	if (conn != null) try { conn.close(); } catch(SQLException ex) {}
}


%>


