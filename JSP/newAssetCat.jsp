<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>


<%

AssetCatService assetCatService = new AssetCatService();
List<AssetCat> assetCats = assetCatService.getAssetCats();

%>






<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Εγγραφή νέας κατηγορίας Π/Σ</title>

<%@include file="components\header.jsp" %>

	</head>

	
	<body class="d-flex flex-column">


<!-- login guard (it needs an extra bracket at the end to close the loop) -->
<%@include file="components\loginGuard.jsp" %>


		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Εγγραφή νέας κατηγορίας Π/Σ</h1>
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

					<form class="form-horizontal" method="POST" action="newAssetCatController.jsp">
						
						<!-- asset category name -->
						<div class="form-group">
							<label for="AssetCatName" class="col-sm-3 control-label main-label">Όνομα κατηγορίας Π/Σ: </label>
							<div class="col-sm-7">
							<input type="text" name="AssetCatName" id="AssetCatName" class="form-control" placeholder="Εισάγετε το όνομα νέας κατηγορίας Π/Σ (περιγραφικό)" title="Εισάγετε το όνομα της νέας κατηγορίας Π/Σ (περιγραφικό)">
							</div>
						</div>



						<!-- buttons -->
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Δημιουργία</button> 
								<button type="reset" class="btn btn-warning"><span class="glyphicon glyphicon-flash"></span> Αρχικοποίηση (reset form)</button>
								<button type="button" class="btn btn-danger" onclick="closePopup()"><span class="glyphicon glyphicon-floppy-remove"></span> Ακύρωση & κλείσιμο</button>
							</div>
						</div>					

					</form>
				</div>
			</div>
		</div>


<!-- this last } seems stand-alone, but it completes the one in loginGuard! -->
<% } %>


	</body>
</html>



<!-- JS script for deletion confirmation process on 2 steps -->
<script>


    function closePopup() {
      window.close();
    }


</script>
