<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>



<%

// Getting the reference parameters from the form.
int assetID = Integer.parseInt(request.getParameter("AssetID"));
String assetName = request.getParameter("AssetName");



// Delete Asset.
AssetService aService = new AssetService();
aService.deleteAsset(assetID);


request.setAttribute("successMessage", "Το Π/Σ " + assetName + " διαγράφηκε επιτυχώς!");
    
%>
<jsp:forward page="index.jsp"/>
