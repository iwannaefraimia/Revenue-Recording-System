<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>



<%

// Getting the reference parameters from the form.
int assetcatID = Integer.parseInt(request.getParameter("assetCatID"));
String assetcatName = request.getParameter("AssetCatName");



// Delete the Asset Category.
AssetCatService acService = new AssetCatService();
acService.deleteAssetCat(assetcatID);


request.setAttribute("successMessage", "Η κατηγορία " + assetcatName + " διαγράφηκε επιτυχώς!");
    
%>
<jsp:forward page="listAssetCats.jsp"/>
