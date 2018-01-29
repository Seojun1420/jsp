<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	System.out.println(id + "<-- id");
	System.out.println(pw + "<-- pw");
	String dbid = "id001";
	String dbpw = "pw001";
	String dbname = "홍길동";
	String dblevel = "관리자";	//관리자 , 판매자, 구매자 권한 변경해서 테스트
	if(id.equals(dbid)){
		System.out.println("01 아이디 일치");
		if(pw.equals(dbpw)){
			System.out.println("03 로그인 성공");
			session.setAttribute("S_NAME", dbname);
			session.setAttribute("S_LEVEL", dblevel);
			//response.sendRedirect(request.getContextPath() +"/index.jsp");
%>
<script type="text/javascript">
	alert('로그인성공');
	location.href="<%= request.getContextPath()%>/index.jsp";
</script>
<%			
		}else{
			System.out.println("04 비번 불일치");
			//response.sendRedirect(request.getContextPath() +"/index.jsp");
%>
<script type="text/javascript">
	alert('비번불일치');
	location.href="<%= request.getContextPath()%>/index.jsp";
</script>
<%			
		}
	}else{
		System.out.println("02 아이디 불일치");
		//response.sendRedirect(request.getContextPath() +"/index.jsp");
%>
<script type="text/javascript">
	alert('아이디 불일치');
	location.href="<%= request.getContextPath()%>/index.jsp";
</script> 
<%		
	}
%>





