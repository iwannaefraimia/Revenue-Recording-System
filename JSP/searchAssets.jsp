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
		<title>Omadiki5 - Αναζήτηση & reports Π/Σ</title>

<%@include file="components\header.jsp" %>



	</head>

	
	<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px;">


<%@include file="components\navbar.jsp" %>


<!-- login guard (needs an extra bracket } at the end to close the loop) -->
<%@include file="components\loginGuard.jsp" %>


		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Αναζήτηση & reports Π/Σ</h1>
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
					<form class="form-horizontal" method="POST" action="searchAssetsController.jsp">

						<!-- asset category -->
						<div class="form-group">
							<label for="AssetCat" class="col-sm-3 control-label main-label">Κατηγορία Π/Σ: </label>
							<div class="col-sm-6">
								<select id="AssetCat" name="AssetCat" class="form-control" title="Επιλέξτε κατηγορία, στην οποία ανήκουν τα Π/Σ, τα οποία αναζητάτε">
									<option value="">ΟΛΕΣ οι κατηγορίες Π/Σ</option>
<%
for (AssetCat assetCat: assetCats) {
%>
									<option value="<%=assetCat.getAssetCatID() %>"><%=assetCat.getAssetCatName() %></option>
<%
}
%>
								</select>
							</div>
						</div>


						<!-- asset total value Min -->
						<div class="form-group">
							<label for="AssetTotalTimimaMin" class="col-sm-3 control-label main-label">Αξία ΑΠΟ (σε €): </label>
							<div class="col-sm-3">
							<input type="number" name="AssetTotalTimimaMin" id="AssetTotalTimimaMin" class="form-control" 
								placeholder="Εισάγετε αξία Π/Σ ΑΠΟ" 
								title="Αναζήτηση σε συνολική αξία / τίμημα κάθε Π/Σ (σε μορφή: xxx.xx σε EUR) - Κάτω άκρο αναζήτησης / ΑΠΟ" 
								min="0" step="0.01">
							</div>
						</div>


						<!-- asset total value Max -->
						<div class="form-group">
							<label for="AssetTotalTimimaMax" class="col-sm-3 control-label main-label">Αξία ΕΩΣ (σε €): </label>
							<div class="col-sm-3">
							<input type="number" name="AssetTotalTimimaMax" id="AssetTotalTimimaMax" class="form-control" 
								placeholder="Εισάγετε αξία Π/Σ ΕΩΣ" 
								title="Αναζήτηση σε συνολική αξία / τίμημα κάθε Π/Σ (σε μορφή: xxx.xx σε EUR) - Άνω άκρο αναζήτησης / ΕΩΣ" 
								min="0" step="0.01">
							</div>
						</div>




						<!-- buttons -->
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<button type="submit" class="btn btn-info"><span class="glyphicon glyphicon-search"></span> Αναζήτηση</button> 
								<button type="reset" class="btn btn-warning"><span class="glyphicon glyphicon-flash"></span> Αρχικοποίηση (reset form)</button>
							</div>
						</div>					

					</form>
				</div>
			</div>
		</div><!-- /.container -->




<%@include file="components\footer.jsp" %>


<!-- this extra bracket } closes the loop of loginGuard -->
<%
}
%>

	</body>
</html>
