<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>



<%

// Getting the reference parameters from the form.
int incometypeID = Integer.parseInt(request.getParameter("incometypeID"));
String incometypeName = request.getParameter("incometypeName");



// Delete income type / category.
IncomeTypeService itService = new IncomeTypeService();
itService.deleteIncomeType(incometypeID);


request.setAttribute("successMessage", "Ο τύπος / κατηγορία εσόδου " + incometypeName + " διαγράφηκε επιτυχώς!");
    
%>
<jsp:forward page="listAssetCats.jsp"/>
