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
		System.out.println("01 ���̵���ġ ����");
		dbid = rs.getString("m_id");
		dbpw = rs.getString("m_pw");
		dblevel = rs.getString("m_level");
		dbname = rs.getString("m_name");
		if(pw.equals(dbpw)){
			System.out.println("03 �α��� ���� ����");
			session.setAttribute("S_ID", dbid);
			session.setAttribute("S_NAME", dbname);
			session.setAttribute("S_LEVEL", dblevel);
%>
<script type="text/javascript">
	alert('�α��μ���');
	location.href="<%= request.getContextPath()%>/index.jsp";
</script>
<%			
		}else{
			System.out.println("04 ��� ����ġ ����");
%>
<script type="text/javascript">
	alert('�������ġ');
	location.href="<%= request.getContextPath()%>/index.jsp";
</script>
<%			
		}
		
	}else{
		System.out.println("02 ���̵� ����ġ ����");
%>
<script type="text/javascript">
	alert('���̵����ġ');
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


