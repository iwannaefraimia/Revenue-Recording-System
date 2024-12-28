<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>



<%

// Getting the reference parameters from the form.
int incomeID = Integer.parseInt(request.getParameter("incomeID"));


// Delete income record.
IncomeService iService = new IncomeService();
iService.deleteIncome(incomeID);


request.setAttribute("successMessage", "Η εγγραφή εσόδου διαγράφηκε επιτυχώς!");
    
%>
<jsp:forward page="index.jsp"/>

