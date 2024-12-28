<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<% User authenticatedUser = (User)session.getAttribute("authenticated_user"); 
if (authenticatedUser == null) { 
	request.setAttribute("session", "Η σύνδεσή σας έληξε. Παρακαλώ συνδεθείτε ξανά."); 
	response.sendRedirect("userLogin.jsp");
	return;
}else{
%>

<!-- CAREFUL omadiki5! It ends with an extra stand-alone bracket {... it does need an extra } in the original file calling it!!! -->