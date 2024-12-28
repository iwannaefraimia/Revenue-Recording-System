<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>




<%


// Getting the reference parameters from the form.
String assetIDStr = request.getParameter("AssetID");
	int assetID = -1; 
	if (assetIDStr != null && assetIDStr.matches("\\d+")) {
    assetID = Integer.parseInt(assetIDStr);
}

AssetService assetService = new AssetService();
Asset assetOnEdit = assetService.findAsset(assetID);


AssetCatService assetCatService = new AssetCatService();
List<AssetCat> assetCats = assetCatService.getAssetCats();

%>






<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Επεξεργασία Π/Σ</title>

<%@include file="components\header.jsp" %>



	</head>

	
	<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px;">


<%@include file="components\navbar.jsp" %>


<!-- login guard (needs an extra bracket on the end, to close the loop) -->
<%@include file="components\loginGuard.jsp" %>



		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Επεξεργασία Π/Σ</h1>
			</div>


			

<%
if (request.getAttribute("errorMessage") != null) {
%>				
			<div class="row">
				<div class="col-xs-12">

					<div class="alert alert-danger">
						<%= (String)request.getAttribute("errorMessage") %>
					</div>

				</div>
			</div>
<%   }    %>

			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" method="POST" action="editAssetController.jsp">

						
						<!-- asset ID (hidden from user, only for reference on editAssetController.JSP) -->
						<div class="form-group">
							<input type="hidden" value="<%= assetOnEdit.getAssetID() %>" type="text" name="AssetID" id="AssetID" class="form-control">
							</div>
						</div>


						<!-- asset name -->
						<div class="form-group">
							<label for="AssetName" class="col-sm-3 control-label main-label">Ονομασία Π/Σ: </label>
							<div class="col-sm-8">
							<input value="<%= assetOnEdit.getAssetName() %>" type="text" name="AssetName" id="AssetName" class="form-control" 
							placeholder="Αλλάξτε την ονομασία του Π/Σ" title="Τροποποιήστε τη διακριτική ονομασία / επωνυμία του Π/Σ">
							</div>
						</div>
					
					
						<!-- asset category -->
						<div class="form-group">
							<label for="AssetCat" class="col-sm-3 control-label main-label">Κατηγορία Π/Σ: </label>
							<div class="col-sm-8">
								<select id="AssetCat" name="AssetCat" class="form-control" 
								title="Επιλέξτε κατηγορία, στην οποία ανήκει το Π/Σ">
<% for (AssetCat assetCat: assetCats) { %>
								<option value="<%= assetCat.getAssetCatID() %>"<%= (assetOnEdit.getAssetCatID() == assetCat.getAssetCatID()) ? "selected" : "" %>><%= assetCat.getAssetCatName() %>
								</option>
<% } %>
								</select>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-warning btn-xs" 
									onclick="openPopup('newAssetCat.jsp')" 
									data-toggle="tooltip" data-placement="top" title="Προσθήκη νέας Κατηγορίας Π/Σ">
									<span class="glyphicon glyphicon-plus"></span></button>
							</div>
						</div>
					
					
						<!-- asset total value -->
						<div class="form-group">
							<label for="AssetTotalTimima" class="col-sm-3 control-label main-label">Συνολική αξία σε €: </label>
							<div class="col-sm-8">
							<input value="<%= assetOnEdit.getAssetTotalTimima() %>" type="number" name="AssetTotalTimima" id="AssetTotalTimima" class="form-control" placeholder="Αλλάξτε τη συνολική αξία του Π/Σ (σε EUR, μορφή: xxx.xx )" title="Η συνολική αξία / τίμημα του Π/Σ, όπως αυτο αποτιμήθηκε από το ΤΑΙΠΕΔ (σε EUR, σε μορφή: xxx.xx)" min="0" step="0.01">
							</div>
						</div>


						<!-- asset description -->
						<div class="form-group">
							<label for="Descr" class="col-sm-3 control-label main-label">Αναλυτική περιγραφή Π/Σ: </label>
							<div class="col-sm-8">
								<textarea name="AssetDescr" id="AssetDescr" class="form-control" rows="5" 
								placeholder="Επεξεργαστείτε την αναλυτική περιγραφή για το συγκεκριμένο Π/Σ" 
								title="Τροποποιήστε την αναλυτική περιγραφή για το συγκεκριμένο περιουσιακό στοιχείο, δηλαδή τα στοιχεία που το περιγράφουν αλλά δεν έχουν δηλωθεί στα υπόλοιπα πεδία της φόρμας (free-form)"><%= assetOnEdit.getAssetDescr() == null ? "" : assetOnEdit.getAssetDescr() %></textarea>
							</div>
						</div>

						<!-- buttons -->
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Ενημέρωση</button> 
								<button type="button" class="btn btn-danger" onclick="goBack()"><span class="glyphicon glyphicon-remove"></span> Ακύρωση & επιστροφή</button>
							</div>
						</div>					

					</form>
				</div>
			</div>
		</div>


<%@include file="components\footer.jsp" %>



<!-- This extra bracket } completes the loginGuard.jsp loop!!! Do not delete it! -->
<%  }   %>


	</body>
</html>
