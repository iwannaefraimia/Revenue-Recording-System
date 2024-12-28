<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>



<%

// Getting the reference parameters from the form.
String aleNum = request.getParameter("aleNum");


// Delete the ALE.
ALEService aService = new ALEService();
aService.deleteALE(aleNum);


request.setAttribute("successMessage", "ALE no: " + aleNum + " deleted successfully!");


%>
<jsp:forward page="listALEs.jsp"/>
