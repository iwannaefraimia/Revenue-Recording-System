<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>


<%
// Retrieve user credentials from session.
User loggedUser = (User)session.getAttribute("authenticated_user");
%>


	

	<!-- Fixed navbar -->
	<nav class="navbar navbar-default navbar-static-top navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<div class="pull-left">
					<img src="images\Coat_of_arms.jpg" alt="Υπ.Οικ." class="navbar-logo" width="77" height="77">
				</div>
				<div class="navbar-text">
					<p class="navbar-text-row1" style="font-size: 14px; color: rgb(85, 130, 197);"> <strong>ΕΛΛΗΝΙΚΗ ΔΗΜΟΚΡΑΤΙΑ</strong><br>Υπουργείο Εθνικής <br>Οικονομίας & Οικονομικών</p>
				</div>
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span> <span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>

<% if (loggedUser != null) { 
%>

			<div class="collapse navbar-collapse" id="navbar">
				<ul class="nav nav-pills">
					<li class="dropdown">
						<a class="dropdown-toggle" href="#" id="navbarCreatenew" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: rgb(85, 130, 197);"><h4><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Εισαγωγή νέο<span class="caret"></span></h4></a>
						<ul class="dropdown-menu">
							<li><a href="newAsset.jsp">Περιουσιακό στοιχείο</a></li>
							<li><a href="newIncome.jsp">Έσοδο</a></li>
							<li role="separator" class="divider"></li>
							<li><a href="#" onclick="openPopup('newAssetCat.jsp')">Κατηγορία Π/Σ</a></li>
							<li><a href="#" onclick="openPopup('newIncomeType.jsp')">Είδος Εσόδου</a></li>
							<li><a href="#" onclick="openPopup('newAccount.jsp')">Λογαριασμός</a></li>
							<li><a href="#" onclick="openPopup('newALE.jsp')">ΑΛΕ</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a class="dropdown-toggle" href="#" id="navbarCreatenew" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: rgb(85, 130, 197);"><h4><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span> Αναζήτηση & reports <span class="caret"></span></h4></a>
						<ul class="dropdown-menu">
							<li><a href="searchAssets.jsp">Περιουσιακό στοιχείο</a></li>
							<li><a href="searchIncomes.jsp">Έσοδο</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a class="dropdown-toggle" href="#" id="navbarCreatenew" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: rgb(85, 130, 197);"><h4><span class="glyphicon glyphicon-wrench" aria-hidden="true"></span> Λίστες παραμέτρων<span class="caret"></span> </h4></a>
						<ul class="dropdown-menu">
							<li><a href="#" onclick="openPopup('listAssetCats.jsp')">Κατηγορίες Π/Σ</a></li>
							<li><a href="#" onclick="openPopup('listIncomeTypes.jsp')">Είδη Εσόδων</a></li>
							<li><a href="#" onclick="openPopup('listAccounts.jsp')">Λογαριασμοί</a></li>
							<li><a href="#" onclick="openPopup('listALEs.jsp')">ΑΛΕ</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a class="dropdown-toggle" href="#" id="navbarCreatenew" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: rgb(85, 130, 197);"><h4><span class="glyphicon glyphicon-user" aria-hidden="true"></span> Χρήστης <span class="caret"></span></h4></a>
						<ul class="dropdown-menu">
							<li><a href="userDetails.jsp">Διαχείριση στοιχείων χρήστη</a></li>
							<li><a href="userPswChange.jsp">Αλλαγή password χρήστη</a></li>
							<li><a href="userLogout.jsp">Έξοδος</a></li>
						</ul>
					</li>
				</ul>
			</div>

<%
} else {
%>
		
			<div class="collapse navbar-collapse" id="navbar">
				<ul class="nav nav-pills">
					<li class="dropdown">
						<a class="dropdown-toggle" href="#" id="navbarCreatenew" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: rgb(85, 130, 197);"><h4><span class="glyphicon glyphicon-user" aria-hidden="true"></span>User<span class="caret"></span> </h4></a>
						<ul class="dropdown-menu">
							<li><a href="userLogin.jsp">Σύνδεση / Login</a></li>
							<li><a href="userRegister.jsp">Δημιουργία χρήστη / Register</a></li>
						</ul>
					</li>
				</ul>
			</div>

<%
}
%>

		</div>
	</nav>

