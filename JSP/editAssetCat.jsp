<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<%
String assetcatID = request.getParameter("assetCatID");

AssetCatService acService = new AssetCatService();
AssetCat assetcatOnEdit = acService.findAssetCat(assetcatID);

// Null error check 
if (assetcatOnEdit == null) {
	request.setAttribute("errorMessage", "Asset category " + assetcatOnEdit + " not found!");
%>

<jsp:forward page="listAssetCat.jsp"/>

<%
return;
}else{
%>





<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Επεξεργασία κατηγορίας Π/Σ</title>

<%@include file="components\header.jsp" %>

	</head>

	
	<body class="d-flex flex-column">


<!-- login guard (at the end of the body, an extra bracket needed to close the include-file loop!) -->
<%@include file="components\loginGuard.jsp" %>



		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Επεξεργασία κατηγορίας Π/Σ</h1>
			</div>


			

<%
if (request.getAttribute("errorMessage") != null) {	
%>				
			<div class="row">
				<div class="col-xs-12">

					<div class="alert alert-danger">
						<%=(String)request.getAttribute("errorMessage") %>
					</div>

				</div>
			</div>
<%
}			
%>


			<div class="row">
				<div class="col-xs-12">

					<form class="form-horizontal" method="POST" action="editAssetCatController.jsp">
						
						<!-- assetcat ID (hidden from user, only for reference on editAssetCatController.JSP) -->
						<div class="form-group">
							<input type="hidden" value="<%= assetcatOnEdit.getAssetCatID() %>" type="text" name="AssetCatID" id="AssetCatID" class="form-control">
							</div>
						</div>

						<!-- asset category name -->
						<div class="form-group">
							<label for="AssetCatName" class="col-sm-3 control-label main-label">Όνομα κατηγορίας Π/Σ: </label>
							<div class="col-sm-7">
							<input value="<%= assetcatOnEdit.getAssetCatName() %>" type="text" name="AssetCatName" id="AssetCatName" class="form-control" title="Τροποποιήστε το όνομα της κατηγορίας Π/Σ">
							</div>
						</div>



						<!-- buttons -->
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Οριστικοποίηση</button> 
								<button type="button" class="btn btn-danger" onclick="closePopup()"><span class="glyphicon glyphicon-remove"></span> Ακύρωση & κλείσιμο</button>
							</div>
						</div>					

					</form>
				</div>
			</div>
		</div>


<!-- the last bracket } seems stand-alone, but it completes the one in loginGuard! -->
<% 
} 
}
%>

	</body>
</html>


<script>
	function closePopup() {
		window.close();
	}
</script>
