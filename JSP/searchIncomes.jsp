<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>




<%
AccountService accountService = new AccountService();
List<Account> accounts = accountService.getAccounts();

	// Sort the list based on AccountNumber
	accounts.sort(new Comparator<Account>() {
    public int compare(Account acc1, Account acc2) {
    return acc1.getAccNum().compareTo(acc2.getAccNum());
    }
	});



AssetCatService assetCatService = new AssetCatService();
List<AssetCat> assetCats = assetCatService.getAssetCats();

	// Sort the list based on AssetCatName
	assetCats.sort(new Comparator<AssetCat>() {
    public int compare(AssetCat cat1, AssetCat cat2) {
    return cat1.getAssetCatName().compareTo(cat2.getAssetCatName());
    }
	});



AssetService assetService = new AssetService();
List<Asset> assets = assetService.getAssets();

	// Sort the list based on AssetName
	assets.sort(new Comparator<Asset>() {
	public int compare(Asset asset1, Asset asset2) {
	return asset1.getAssetName().compareTo(asset2.getAssetName());
	}
	});
	


IncomeTypeService incomeTypeService = new IncomeTypeService();
List<IncomeType> incomeTypes = incomeTypeService.getIncomeTypes();

	// Sort the list based on IncomeTypeName
	incomeTypes.sort(new Comparator<IncomeType>() {
	public int compare(IncomeType it1, IncomeType it2) {
	return it1.getIncomeTypeName().compareTo(it2.getIncomeTypeName());
	}
	});
	
%>






<!DOCTYPE html>
<html lang="en">
	<head>        
		<title>Omadiki5 - Αναζήτηση & reports εσόδων</title>

<%@include file="components\header.jsp" %>



	</head>

	
	<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px;">


<%@include file="components\navbar.jsp" %>


<!-- login guard (needs an extra bracket } at the end to close the loop) -->
<%@include file="components\loginGuard.jsp" %>


		<div class="container theme-showcase" role="main">

			<!-- Page Title -->
			<div class="page-header">
				<h1>Αναζήτηση & reports εσόδων</h1>
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
<%   }   %>


			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" method="POST" action="searchIncomesController.jsp">
					
						<!-- date of deposit - START -->
						<div class="form-group">
							<label for="DateFrom" class="col-sm-3 control-label main-label">Ημ/νία κατάθεσης ΑΠΟ: </label>
							<div class="col-sm-4">
								<input type="date" name="DateFrom" id="DateFrom" class="form-control" title="Επιλέξτε ημερομηνία κατάθεσης ΑΠΟ (αφήστε κενό για όλες)">
							</div>
						</div>

						<!-- date of deposit - END -->
						<div class="form-group">
							<label for="DateTo" class="col-sm-3 control-label main-label">Ημ/νία κατάθεσης ΕΩΣ:</label>
							<div class="col-sm-4">
							<input type="date" name="DateTo" id="DateTo" class="form-control" title="Επιλέξτε ημερομηνία κατάθεσης ΕΩΣ (αφήστε κενό για όλες)">
							</div>
						</div>

						<!-- deposit amount - MIN -->
						<div class="form-group">
							<label for="AmountMin" class="col-sm-3 control-label main-label">Minimum ποσό (σε €): </label>
							<div class="col-sm-4">
							<input type="number" name="AmountMin" id="AmountMin" class="form-control" placeholder="Εισάγετε το ελάχιστο ποσό των εσόδων της αναζήτησης (σε μορφή: xxx.xx EUR)" title="To ελάχιστο ποσό των εσόδων της αναζήτησης, που κατατέθηκε σε λογαριασμό του Δημοσίου (σε EUR, σε μορφή: xxx.xx)" min="0" step="0.01">
							</div>
						</div>

						<!-- account -->
						<div class="form-group">
							<label for="Account" class="col-sm-3 control-label main-label">Λογαριασμός: </label>
							<div class="col-sm-6">
								<select id="Account" name="Account" class="form-control" title="Επιλέξτε λογαριασμό του Δημοσίου, στον οποίο κατατέθηκαν τα έσοδα που αναζητάτε (αφήστε κενό για όλους)">
									<option value="">--- Επιλέξτε λογαριασμό κατάθεσης ---</option>
<%   for (Account account: accounts) {   %>
									<option value="<%=account.getAccNum() %>"><%=account.getAccName() %></option>
<%   }   %>                                        
								</select>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-info btn-xs" 
								onclick="openPopup('listAccounts.jsp')" 
								data-toggle="tooltip" data-placement="top" title="Λίστα Λογαριασμών">
									<span class="glyphicon glyphicon-search"></span></button>
							</div>
						</div>

						<!-- asset category -->
						<div class="form-group">
							<label for="AssetCat" class="col-sm-3 control-label main-label">Κατηγορία Π/Σ: </label>
							<div class="col-sm-6">
								<select id="AssetCat" name="AssetCat" class="form-control" onchange="filterAssets()" title="Επιλέξτε κατηγορία, στην οποία ανήκει το περιουσιασκό στοιχείο, του οποίου τα έσοδα αναζητάτε (αφήστε κενό για όλες)">
									<option value="">--- Επιλέξτε κατηγορία Περιουσιακού στοιχείου ---</option>
<%   for (AssetCat assetCat: assetCats) {   %>
									<option value="<%=assetCat.getAssetCatID() %>"><%=assetCat.getAssetCatName() %></option>
<%   }   %>                                        
								</select>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-info btn-xs" 
									onclick="openPopup('listAssetCats.jsp')" 
									data-toggle="tooltip" data-placement="top" title="Λίστα Κατηγοριών Π/Σ">
									<span class="glyphicon glyphicon-search"></span></button>
							</div>
						</div>

						<!-- asset -->
						<!-- η επιλογη εξαρταται απο το τι θα επιλεξει ο χρηστης στο προηγουμενο πεδιο (asset category) -->
						<div class="form-group">
							<label for="Asset" class="col-sm-3 control-label main-label">Περιουσιακό<br>στοιχείο: </label>
							<div class="col-sm-6">
								<select id="Asset" name="Asset" class="form-control" title="Επιλέξτε περιουσιασκό στοιχείο, στο οποίο ανήκουν τα έσοδα που αναζητάτε (αφήστε κενό για όλα)">
									<option value="">--- Επιλέξτε Περιουσιακό στοιχείο ---</option>
<%   for (Asset asset: assets) {   %>
									<option value="<%=asset.getAssetID() %>"><%=asset.getAssetName() %></option>
<%  }  %>                                        
								</select>
							</div>
						</div>


						<!-- income type -->
						<div class="form-group">
							<label for="IncomeType" class="col-sm-3 control-label main-label">Είδος εσόδου: </label>
							<div class="col-sm-6">
								<select id="IncomeType" name="IncomeType" class="form-control" title="Επιλέξτε κατηγορία εσόδου, στην οποία κατατάσονται τα έσοδα που αναζητάτε (αφήστε κενό για όλες)">
									<option value="">--- Επιλέξτε είδος εσόδου ---</option>
<%  for (IncomeType incomeType: incomeTypes) {  %>
									<option value="<%=incomeType.getIncomeTypeID() %>"><%=incomeType.getIncomeTypeName() %></option>
<%  }  %>                                        
								</select>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-info btn-xs" 
									onclick="openPopup('listIncomeTypes.jsp')" 
									data-toggle="tooltip" data-placement="top" title="Λίστα ειδών εσόδων">
									<span class="glyphicon glyphicon-search"></span></button>
							</div>
						</div>


						<!-- SAP code -->
						<div class="form-group">
							<label for="SAP" class="col-sm-3 control-label main-label">Κωδ. SAP: </label>
							<div class="col-sm-4">
							<input type="text" name="SAP" id="SAP" class="form-control" placeholder="Εισάγετε κωδικό SAP" title="Εισάγετε τον κωδικό αναγνώρισης στο σύστημα SAP του ΓΛΚ για το εσόδου που αναζητάτε (αφήστε κενό για όλα)">
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
		</div>




<%@include file="components\footer.jsp" %>



<!-- this extra bracket } closes the loop of loginGuard -->
<% } %>


		<!-- script to show filtered assets, based on the assetCat selection -->
		<script>

			function filterAssets() {
				var assetCatSelect = document.getElementById("AssetCat");
				var assetSelect = document.getElementById("Asset");
				var selectedAssetCatID = assetCatSelect.value;

				assetSelect.innerHTML = '<option value="">--- Επιλέξτε Περιουσιακό στοιχείο ---</option>';

<% for (Asset asset: assets) { %>

				if ("<%=asset.getAssetCatID() %>" === selectedAssetCatID) {
					var option = document.createElement("option");
					option.value = "<%=asset.getAssetID() %>";
					option.text = "<%=asset.getAssetName() %>";
					assetSelect.add(option);
				}
<% } %>
			}
		
		</script>

	</body>
</html>
