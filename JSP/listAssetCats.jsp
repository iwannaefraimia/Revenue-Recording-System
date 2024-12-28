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
<html>
	<head>        
		<title>Omadiki5 - Λίστα Κατηγοριών Π/Σ</title>

<%@include file="components\header.jsp" %>

    <style>
      .table-container {
          height: 400px; /* Set the height of the container */
          overflow-y: auto; /* Enable vertical scrolling */
      }

      th {
          position: sticky;
          top: 0;
          background-color: #f5f5f5; /* Add a background color for the header */
          z-index: 1; /* Set z-index to keep it above the table body */
      }
    </style>

	</head>
	<body class="d-flex flex-column">


<!-- login guard (right below, there is an extra bracket }. It is needed to close the include-file loop!) -->
<%@include file="components\loginGuard.jsp" %>


    <div class="container theme-showcase" role="main">

      <!-- Page Title -->
      <div class="page-header">
        <h1>Λίστα Κατηγοριών Π/Σ</h1>
        <p>(Με αλφαβητική σειρά ανά κατηγορία Π/Σ)</p>
      </div>




<!-- error or success message -->
<%
}
if (request.getAttribute("errorMessage") != null) {	
%>				
      <div class="row">
        <div class="col-xs-12">
          <div class="alert alert-danger">

<%= 
(String)request.getAttribute("errorMessage") 
%>

          </div>
        </div>
      </div>
<%
}			
%>

<%

if (request.getAttribute("successMessage") != null) {	
%>				
      <div class="row">
        <div class="col-xs-12">
          <div class="alert alert-success">

<%= 
(String)request.getAttribute("successMessage") 
%>

          </div>
        </div>
      </div>
<%
}			
%>



<!-- results table -->
      <div class="row">
        <div class="col-xs-12">
            <div class="table-container">
            <table class="table table-bordered table-hover table-condensed table-responsive">
              <thead>
                <tr class="info">
                    <th>Κατηγορία Π/Σ</th>
                    <th class="text-center" style="width: 120px;">Επιλογές</th>
                </tr>
              </thead>
              <tbody>
<%
for (AssetCat assetCat : assetCats) {
%>

                <tr>
                  <td><%=assetCat.getAssetCatName() %></td>



                  <!-- action buttons -->
                  <td class="text-center">
                    <a href="editAssetCat.jsp?assetCatID=<%=assetCat.getAssetCatID() %>" class="btn btn-warning btn-xs">
                      <span class="glyphicon glyphicon-pencil"></span>
                    </a>
                    <a href="#" class="btn btn-danger btn-xs delete-btn" title="Διαγραφή κατηγορίας Π/Σ" deletebtn="<%=assetCat.getAssetCatID() %>">
                      <span class="glyphicon glyphicon-trash"></span>
                    </a>
                  </td>
                </tr>



<!-- zero results found -->
<% 
}
if (assetCats.size() == 0) {
%>
              <tr>
                <td colspan="7" class="text-center">Δεν βρέθηκαν κατηγορίες Π/Σ</td>
              </tr>
<%  }   %>
              </tbody>
            </table>
          </div>
        </div>
      </div>        
    </div>

    <!-- buttons -->
    <div class="row">
      <div class="col-xs-12 text-center">
        <button type="button" class="btn btn-danger" onclick="closePopup()"><span class="glyphicon glyphicon-remove"></span> Κλείσιμο</button>
      </div>
    </div>					

  </body>
</html>




<!-- JS script for deletion confirmation process on 2 steps -->
<script>
  document.addEventListener('DOMContentLoaded', function () {
      var deleteButtons = document.querySelectorAll('.delete-btn');

      deleteButtons.forEach(function (button) {
          button.addEventListener('click', function (event) {
              event.preventDefault();
              var assetcatID = button.getAttribute('deletebtn');

              // 1st confirmation dialog
              var firstConfirmation = confirm('Είστε σίγουροι για τη διαγραφή της συγκεκριμένης κατηγορίας Π/Σ;');

              if (firstConfirmation) {
                  // 2nd confirmation dialog
                  var secondConfirmation = confirm('Είστε 100% σίγουροι; Μετά το 2ο ΟΚ, η διαγραφή δεν μπορεί να ανακληθεί!');

                  if (secondConfirmation) {
                      // User confirmed both dialogs, proceed with the delete method
                      window.location.href = 'deleteAssetCat.jsp?assetCatID=' + assetcatID;
                  } else {
                      // User cancels the 2nd confirmation
                      alert('Η διαγραφή ακυρώθηκε!');
                  }
              } else {
                  // User cancels the 1st confirmation
                  alert('Η διαγραφή ακυρώθηκε!');
              }
          });
      });
  });



  function closePopup() {
      window.close();
    }



</script>
