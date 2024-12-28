<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>



<%

// Getting the reference parameters from the form.
String accNum = request.getParameter("accNum");

// Delete the Account.
AccountService aService = new AccountService();
aService.deleteAccount(accNum);


request.setAttribute("successMessage", "Account no: " + accNum + " deleted successfully!");


%>
<jsp:forward page="listAccounts.jsp"/>
