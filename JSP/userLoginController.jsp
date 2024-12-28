<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page errorPage="errorpage.jsp" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");

UserDAO userd = new UserDAO();

try {

    User user = userd.authenticate(username, password);

    session.setAttribute("authenticated_user", user);

%>    
    <jsp:forward page="index.jsp" />
<%
} catch(Exception e) {

    request.setAttribute("error_message", e.getMessage());

%>
    <jsp:forward page="userLogin.jsp" />

<%
}
%>