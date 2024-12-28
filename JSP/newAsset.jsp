<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>



<%
AssetCatService assetCatService = new AssetCatService();
List<AssetCat> assetCats = assetCatService.getAssetCats();

// Sort the list based on AssetCatName
assetCats.sort(new Comparator<AssetCat>() {
    public int compare(AssetCat cat1, AssetCat cat2) {
        return cat1.getAssetCatName().compareTo(cat2.getAssetCatName());
    }
});
%>






<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Εγγραφή νέου Π/Σ</title>

<%@include file="components\header.jsp" %>



	</head>

	
	<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px;">


<%@include file="components\navbar.jsp" %>


<!-- login guard, needs extra bracket at the end to close loop -->
<%@include file="components\loginGuard.jsp" %>


		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Εγγραφή νέου Π/Σ</h1>
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
<%
}			
%>


			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" method="POST" action="newAssetController.jsp">
					
					
						<!-- asset name -->
						<div class="form-group">
							<label for="AssetName" class="col-sm-3 control-label main-label">Ονομασία Π/Σ: </label>
							<div class="col-sm-8">
							<input type="text" name="AssetName" id="AssetName" class="form-control" placeholder="Εισάγετε ονομασία Π/Σ" title="Εισάγετε την διακριτική ονομασία / επωνυμία του Π/Σ">
							</div>
						</div>
					
					
						<!-- asset category -->
						<div class="form-group">
							<label for="AssetCat" class="col-sm-3 control-label main-label">Κατηγορία Π/Σ: </label>
							<div class="col-sm-8">
								<select id="AssetCat" name="AssetCat" class="form-control" title="Επιλέξτε κατηγορία, στην οποία ανήκει το Π/Σ, το οποίο εισάγετε τώρα">
									<option value="">--- Επιλέξτε κατηγορία Περιουσιακού στοιχείου ---</option>
<%
for (AssetCat assetCat: assetCats) {
%>
									<option value="<%=assetCat.getAssetCatID() %>"><%=assetCat.getAssetCatName() %></option>
<%
}
%>
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
							<input type="number" name="AssetTotalTimima" id="AssetTotalTimima" class="form-control" placeholder="Εισάγετε συνολική αξία σε EUR (μορφή: xxx.xx)" title="Η συνολική αξία / τίμημα του Π/Σ, όπως αυτο αποτιμήθηκε από το ΤΑΙΠΕΔ (σε EUR, σε μορφή: xxx.xx)" min="0" step="0.01">
							</div>
						</div>


						<!-- asset description -->
						<div class="form-group">
							<label for="Descr" class="col-sm-3 control-label main-label">Αναλυτική περιγραφή Π/Σ: </label>
							<div class="col-sm-8">
							<textarea name="AssetDescr" id="AssetDescr" class="form-control" rows="5" placeholder="Εισάγετε αναλυτική περιγραφή για το συγκεκριμένο Π/Σ" title="Εισάγετε αναλυτική περιγραφή για το συγκεκριμένο περιουσιακό στοιχείο, δηλαδή στοιχεία που το περιγράφουν αλλά δεν έχουν δηλωθεί στα υπόλοιπα πεδία της φόρμας (free-form)"></textarea>
							</div>
						</div>

						
						<!-- buttons -->
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Καταχώρηση</button> 
								<button type="reset" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Ακύρωση</button>
							</div>
						</div>					

					</form>
				</div>
			</div>
		</div><!-- /.container -->


<%@include file="components\footer.jsp" %>


<!-- Extra bracket } to close the loginGuard loop -->
<%
}
%>

	</body>
</html>
