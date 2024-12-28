<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>




<%


// Getting the reference parameters from the form.


	String incomeIDStr = request.getParameter("incomeID");
	int incomeID = -1; 
	if (incomeIDStr != null && incomeIDStr.matches("\\d+")) {
incomeID = Integer.parseInt(incomeIDStr);
	}


IncomeService iService = new IncomeService();
Income incomeOnEdit = iService.findIncome(incomeID);
	

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
		<title>Omadiki5 - Επεξεργασία εσόδου</title>

<%@include file="components\header.jsp" %>

	</head>

	
	<body class="d-flex flex-column" style="padding-bottom: 77px; padding-top: 110px;">


<%@include file="components\navbar.jsp" %>


<!-- login guard (needs an extra bracket on the end, to close the loop) -->
<%@include file="components\loginGuard.jsp" %>


		<div class="container theme-showcase" role="main">

			<div class="page-header">
				<h1>Επεξεργασία εσόδου</h1>
			</div>


			

<%
if (request.getAttribute("errorMessage") != null) {	
%>
			<div class="row">
				<div class="col-xs-12">
					<div class="alert alert-danger">
						<%= (String) request.getAttribute("errorMessage") %>
					</div>
				</div>
			</div>
<%   }   %>

			<div class="row">
				<div class="col-xs-12">
					<form class="form-horizontal" method="POST" action="editIncomeController.jsp">

						<!-- income ID (hidden from user, only for reference on editIncomeController.JSP) -->
						<div class="form-group">
							<input type="hidden" value="<%= incomeOnEdit.getIncomeID() %>" type="text" name="incomeID" id="incomeID" class="form-control">
						</div>

						<!-- date of deposit in TAIPED (katathesi) -->
						<div class="form-group">
							<label for="DateTaiped" class="col-sm-3 control-label main-label">Ημ/νία κατάθεσης<br>σε Λογ. του ΤΑΙΠΕΔ: </label>
							<div class="col-sm-8">
								<input value="<%= incomeOnEdit.getIncomeDateTaiped() %>" type="date" name="DateTaiped" id="DateTaiped" class="form-control" title="Επιλέξτε ημερομηνία κατάθεσης του εσόδου σε Λογ. του ΤΑΙΠΕΔ (αν τη γνωρίζετε)">
							</div>
						</div>

						<!-- date of deposit (katathesi) -->
						<div class="form-group">
							<label for="DateKatath" class="col-sm-3 control-label main-label">Ημ/νία κατάθεσης<br>σε Λογ. του Δημοσίου:</label>
							<div class="col-sm-8">
								<input value="<%= incomeOnEdit.getIncomeDateKatath() %>" type="date" name="DateKatath" id="DateKatath" class="form-control" title="Επιλέξτε ημερομηνία κατάθεσης του εσόδου σε Λογ. του Δημοσίου">
							</div>
						</div>

						<!-- Difference in days -->
						<div class="form-group">
							<label for="DateDiff" class="col-sm-3 control-label main-label">Διαφορά Ημερών: </label>
							<div class="col-sm-1">
								<input readonly type="text" name="DateDiff" id="DateDiff" class="form-control" title="Διαφορά (σε ημέρες) από την ημέρα που κατατέθηκε το έσοδο σε λογαριασμό του ΤΑΙΠΕΔ, μέχρι την ημέρα που τα κατέθεσε το ΤΑΙΠΕΔ σε λογαριασμό του Δημοσίου">
							</div>
						</div>

						<!-- deposit amount -->
						<div class="form-group">
							<label for="AmountDeposit" class="col-sm-3 control-label main-label">Ποσό σε €: </label>
							<div class="col-sm-8">
							<input value="<%= incomeOnEdit.getIncomeAmount() %>" type="number" name="Amount" id="Amount" class="form-control" title="To ποσό του εσόδου που κατατέθηκε σε λογαριασμό του Δημοσίου (σε EUR, σε μορφή: xxx.xx)" min="0" step="0.01">
							</div>
						</div>

						<!-- account -->
						<div class="form-group">
							<label for="Account" class="col-sm-3 control-label main-label">Λογαριασμός: </label>
							<div class="col-sm-8">
								<select id="Account" name="Account" class="form-control" title="Επιλέξτε λογαριασμό του Δημοσίου στον οποίο κατατέθηκε το ποσό του εσόδου">
<%  for (Account account: accounts) {  %>
								<option value="<%=account.getAccNum() %>"<%= (incomeOnEdit.getIncomeAccount() == account.getAccNum()) ? "selected" : "" %>><%= account.getAccName() %>
								</option>
<%  }  %>
								</select>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-warning btn-xs" 
								onclick="openPopup('newAccount.jsp')" 
								data-toggle="tooltip" data-placement="top" title="Προσθήκη νέου Λογαρ.">
									<span class="glyphicon glyphicon-plus"></span></button>
							</div>
						</div>

						<!-- asset category -->
						<div class="form-group">
							<label for="AssetCat" class="col-sm-3 control-label main-label">Κατηγορία Π/Σ: </label>
							<div class="col-sm-8">
								<select id="AssetCat" name="AssetCat" class="form-control" onchange="filterAssets()" title="Επιλέξτε κατηγορία, στην οποία ανήκει το περιουσιασκό στοιχείο, του οποίου το έσοδο εισάγετε">
<%   for (AssetCat assetCat: assetCats) {  %>
								<option value="<%=assetCat.getAssetCatID() %>"<%= (incomeOnEdit.getIncomeAsset() == assetCat.getAssetCatID()) ? "selected" : "" %>><%= assetCat.getAssetCatName() %>
								</option>
<%  }  %>
								</select>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-warning btn-xs" 
									onclick="openPopup('newAssetCat.jsp')" 
									data-toggle="tooltip" data-placement="top" title="Προσθήκη νέας Κατηγορίας Π/Σ">
									<span class="glyphicon glyphicon-plus"></span></button>
							</div>
						</div>

						<!-- asset -->
						<!-- η επιλογη εξαρταται απο το τι θα επιλεξει ο χρηστης στο προηγουμενο πεδιο (category) -->
						<div class="form-group">
							<label for="Asset" class="col-sm-3 control-label main-label">Περιουσιακό<br>στοιχείο: </label>
							<div class="col-sm-8">
								<select id="Asset" name="Asset" class="form-control" title="Επιλέξτε περιουσιασκό στοιχείο, στο οποία ανήκει το έσοδο που εισάγετε">
<%  for (Asset asset: assets) {   %>
							<option value="<%=asset.getAssetID() %>"<%= (incomeOnEdit.getIncomeAsset() == asset.getAssetID()) ? "selected" : "" %>><%= asset.getAssetName() %>
								</option>
<%  }  %>
								</select>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-warning btn-xs" 
									onclick="openPopup('newAsset.jsp')" 
									data-toggle="tooltip" data-placement="top" title="Προσθήκη νέου Π/Σ">
									<span class="glyphicon glyphicon-plus"></span></button>
							</div>
						</div>

						<!-- income type -->
						<div class="form-group">
							<label for="IncomeType" class="col-sm-3 control-label main-label">Κατηγορία Εσόδου: </label>
							<div class="col-sm-8">
								<select id="IncomeType" name="IncomeType" class="form-control" title="Επιλέξτε κατηγορία εσόδου, στην οποία κατατάσεται το έσοδο που εισάγετε">
<%  for (IncomeType incomeType: incomeTypes) {  %>
								<option value="<%=incomeType.getIncomeTypeID() %>"<%= (incomeOnEdit.getIncomeIncomeType() == incomeType.getIncomeTypeID()) ? "selected" : "" %>><%= incomeType.getIncomeTypeName() %>
								</option>
<%  }  %>
								</select>
							</div>
							<div class="col-sm-1">
								<button type="button" class="btn btn-warning btn-xs" 
									onclick="openPopup('newIncomeType.jsp')" 
									data-toggle="tooltip" data-placement="top" title="Προσθήκη νέας Εσόδου">
									<span class="glyphicon glyphicon-plus"></span></button>
							</div>
						</div>

						<!-- dosi -->
						<!-- αυτο θα φτιαχτει αργοτερα... -->
						<div class="form-group">
							<label for="dosi" class="col-sm-3 control-label main-label">Αρ. δόσης / Έτος: </label>
							<div class="col-sm-8">
							<input value="<%= incomeOnEdit.getIncomeDosi() %>" type="text" name="dosi" id="dosi" class="form-control" title="Εισάγετε τον αριθμό της δόσης (πχ 3η δόση) ή έτος καταβολής (πχ 2023) του εσόδου">
							</div>
						</div>

						<!-- SAP code -->
						<div class="form-group">
							<label for="SAP" class="col-sm-3 control-label main-label">Κωδ. SAP: </label>
							<div class="col-sm-8">
							<input value="<%= incomeOnEdit.getIncomeSAP() %>" type="text" name="SAP" id="SAP" class="form-control" title="Εισάγετε τον κωδικό αναγνώρισης του εσόδου στο σύστημα SAP του ΓΛΚ">
							</div>
						</div>

						<!-- description -->
						<div class="form-group">
							<label for="Descr" class="col-sm-3 control-label main-label">Αναλυτική περιγραφή: </label>
							<div class="col-sm-8">
								<textarea name="Descr" id="Descr" class="form-control" rows="5" title="Εισάγετε αναλυτική περιγραφή του συγκεκριμένου εσόδου, δηλαδή στοιχεία που το αφορούν αλλά δεν έχουν δηλωθεί στα υπόλοιπα πεδία της φόρμας εισόδου (free-form)"><%= incomeOnEdit.getIncomeDescr() == null ? "" : incomeOnEdit.getIncomeDescr() %></textarea>
							</div>
						</div>




						<!-- buttons -->
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9">
								<button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-ok"></span> Ενημέρωση</button> 
								<button type="button" class="btn btn-danger"onclick="goBack()"><span class="glyphicon glyphicon-remove"></span> Ακύρωση & επιστροφή</button>
								<button type="button" class="btn btn-primary" onclick="openAssetIncomesPopup()"><span class="glyphicon glyphicon-list"></span> Λίστα εσόδων Π/Σ</button>
							</div>
						</div>					

					</form>
				</div>
			</div>



<%@include file="components\footer.jsp" %>



<!-- This extra bracket } completes the loginGuard.jsp loop!!! Do not delete it! -->
<%  }   %>




		<!-- script to show filtered assets, based on the assetCat selection -->
		<script>
			function filterAssets() {
				var assetCatSelect = document.getElementById("AssetCat");
				var assetSelect = document.getElementById("Asset");
				var selectedAssetCatID = assetCatSelect.value;

				assetSelect.innerHTML = '<option value="">--- Επιλέξτε Περιουσιακό στοιχείο ---</option>';

<% for (Asset asset: assets) {  %>

				if ("<%=asset.getAssetCatID() %>" === selectedAssetCatID) {
					var option = document.createElement("option");
					option.value = "<%=asset.getAssetID() %>";
					option.text = "<%=asset.getAssetName() %>";
					assetSelect.add(option);
				}
<% 
				}
%>
			}
		
		</script>



		<!-- script to auto-calculate the 2 dates difference -->
		<script>
			function calculateDateDifference() {
				var dateKatath = document.getElementById("DateKatath").value;
				var dateTaiped = document.getElementById("DateTaiped").value;
				var dateDifferenceField = document.getElementById("DateDiff");

				if (dateKatath !== "" && dateTaiped !== "") {
					var dateKatathObj = new Date(dateKatath);
					var dateTaipedObj = new Date(dateTaiped);

					// Calculate the difference in days
					var timeDifference = dateKatathObj - dateTaipedObj;
					var daysDifference = Math.max(Math.floor(timeDifference / (1000 * 60 * 60 * 24)), 0);

					// Update the DateDifference field
					dateDifferenceField.value = daysDifference + " ημέρες";
				} else {
					// If either date is not selected, reset the field
					dateDifferenceField.value = "";
				}
			}

			// Set up event listeners for date changes using 'input' event
			document.getElementById("DateKatath").addEventListener("input", calculateDateDifference);
			document.getElementById("DateTaiped").addEventListener("input", calculateDateDifference);
		</script>




		<!-- script to open popup for incomes -->
		<script>
			function openAssetIncomesPopup() {
				var selectedAsset = document.getElementById("Asset").value;
			
				if (selectedAsset !== "") {
					// Construct the URL with the asset value as a parameter
					var url = "showIncomeController.jsp?asset=" + encodeURIComponent(selectedAsset);

					// Set the width and height for the popup window
					var width = screen.availWidth * 0.5;
					var height = screen.availHeight * 0.5;

					// Calculate the center position for the popup window
					var leftPosition = (screen.width - width) / 2;
					var topPosition = (screen.height - height) / 2;

					// Open the popup window with the constructed URL
					window.open(url, "IncomePopup", "width=" + width + ", height=" + height + ", top=" + topPosition + ", left=" + leftPosition + ", resizable=yes, scrollbars=no");
				} else {
					// Handle the case where no asset is selected
					alert("Παρακαλώ επιλέξτε στο πεδίο Π/Σ για να εμφανιστούν οι αντίστοιχες εγγραφές εσόδου του");
				}
			}
		</script>



	</body>
</html>
