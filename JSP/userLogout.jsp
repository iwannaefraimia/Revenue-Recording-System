<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>


<%
// Invalidate user's session, all objects (ex: user) bound to the session are removed.
session.invalidate();

// Add "successful logout message" to request via attribute and forward to the login page.
request.setAttribute("success_message", "Έχετε αποσυνδεθεί από την υπηρεσία");
%>

<jsp:forward page="userLogin.jsp" />
