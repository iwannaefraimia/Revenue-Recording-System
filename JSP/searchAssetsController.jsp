<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page errorPage="errorpage.jsp" %>





<%
// Retrieve form parameters & translate the bloody double variables to string!

String assetCatID = request.getParameter("AssetCat");


    String timimaMinStr = request.getParameter("AssetTotalTimimaMin");
    BigDecimal assetTotalTimimaMin = null;
    try {
assetTotalTimimaMin = (timimaMinStr != null && !timimaMinStr.isEmpty()) ? new BigDecimal(timimaMinStr) : null;
    } catch (NumberFormatException e) {
    e.printStackTrace();
    }


    String timimaMaxStr = request.getParameter("AssetTotalTimimaMax");
    BigDecimal assetTotalTimimaMax = null;
    try {
assetTotalTimimaMax = (timimaMaxStr != null && !timimaMaxStr.isEmpty()) ? new BigDecimal(timimaMaxStr) : null;
    } catch (NumberFormatException e) {
    e.printStackTrace();
    }




// Constraints check
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (assetTotalTimimaMin != null && assetTotalTimimaMax != null && assetTotalTimimaMax.compareTo(assetTotalTimimaMin) < 0) {
    errorsFound.add("Η Αξία ΕΩΣ θα πρέπει να είναι μεγαλύτερη από την Αξία ΑΠΟ");
    countErrors++;
}





// Call findAssets method with the provided parameters
AssetService aService = new AssetService();
List<Asset> assetList = aService.findAssets(assetCatID, assetTotalTimimaMin, assetTotalTimimaMax);



// Aiding lists
AssetCatService assetCatService = new AssetCatService();
List<AssetCat> assetCats = assetCatService.getAssetCats();



%>



<!-- custom aiding method to format amounts in timima by thousands separator with 2 decimal digits -->
<%!

public String formatNumber(BigDecimal number) {
    if (number == null) {
        return "";
    }
    NumberFormat numberFormat = NumberFormat.getInstance();
    numberFormat.setMaximumFractionDigits(2);  // Set maximum decimal digits
    numberFormat.setMinimumFractionDigits(2);  // Set minimum decimal digits
    return numberFormat.format(number);
}

%>





<!-- Now starts the HTML / JSP page -->
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Αποτελέσματα αναζήτησης Π/Σ</title>

    <%@ include file="components/header.jsp" %>

</head>



<body class="d-flex flex-column">
    <%@ include file="components/navbar.jsp" %>



    <div class="container theme-showcase" role="main">
        <div class="page-header">
            <h1>Αποτελέσματα αναζήτησης Π/Σ</h1>
        </div>

		
        <div id="print-content">
            <div class="row">
                <div class="col-xs-12">
                    <% if (assetList != null && !assetList.isEmpty()) { %>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Όνομα Π/Σ</th>
                                    <th>Περιγραφή</th>
                                    <th>Συνολική αξία</th>
                                    <th>Κατηγορια Π/Σ</th>
                                </tr>
                            </thead>
                            <tbody>
    <% for (Asset asset : assetList) { %>
                                <tr>
                                    <td><%= asset.getAssetName() %></td>
                                    
                                    <td>
                                            <% String assetDescr = asset.getAssetDescr();
                                            if (assetDescr != null) { %>
                                        <%= assetDescr %>
                                                        <% } %> </td>
                                    <td style="text-align: right;"><%= formatNumber(asset.getAssetTotalTimima()) %></td>
                                    
                                    <!-- 4th column to get the asset category name from assetcat ID-->
                                    <td>
                                        <% String assetCatNameInTable = "";
                                        for (AssetCat assetCat : assetCats) {
                                            if (assetCat.getAssetCatID() == asset.getAssetCatID()) {
                                                assetCatNameInTable = assetCat.getAssetCatName();
                                                break;
                                            }
                                        } %>
                                        <%= assetCatNameInTable %></td>



                                    <!-- action buttons-->
                                    <td class="text-center">
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <a href="editAsset.jsp?AssetID=<%=asset.getAssetID() %>" class="btn btn-warning btn-xs" 
                                                    title="Επεξεργασία Π/Σ">
                                                    <span class="glyphicon glyphicon-pencil"></span>
                                                </a>
                                            </div>
                                            <div class="col-xs-6">
                                                <a href="#" class="btn btn-danger btn-xs delete-btn" 
                                                    title="Διαγραφή Π/Σ" deletebtn="<%=asset.getAssetID() %>">
                                                <span class="glyphicon glyphicon-trash"></span>
                                                </a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
    <% } %>
                            </tbody>
                        </table>
    <% } else { %>
                        <div class="alert alert-info">
                            No results found.
                        </div>
    <% } %>
                </div>
            </div>
        </div>
    </div>



<!-- Print button -->
    <div class="row">
        <div class="col-xs-12 text-center">
            <button type="button" class="btn btn-primary" onclick="printResults()">Εκτύπωση</button>
        </div>
    </div>



<%@ include file="components/footer.jsp" %>

</body>
</html>







<!-- JS script for: 1) deletion confirmation & 2) printing the results page -->
<script>


    // This handles the deletion process on 2 steps
    document.addEventListener('DOMContentLoaded', function () {
            var deleteButtons = document.querySelectorAll('.delete-btn');

            deleteButtons.forEach(function (button) {
                button.addEventListener('click', function (event) {
                    event.preventDefault();
                    var assetID = button.getAttribute('deletebtn');

                    // 1st confirmation dialog
                    var firstConfirmation = confirm('Είστε σίγουροι για τη διαγραφή του συγκεκριμένου Π/Σ;');

                    if (firstConfirmation) {
                        // 2nd confirmation dialog
                        var secondConfirmation = confirm('Είστε 100% σίγουροι; Μετά το 2ο ΟΚ, η διαγραφή δεν μπορεί να ανακληθεί!');

                        if (secondConfirmation) {
                            // User confirmed both dialogs, proceed with the delete method
                            window.location.href = 'deleteAsset.jsp?assetID=' + assetID;
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



    // This handles the print process
    function printResults() {
        var printWindow = window.open('', '_blank');

        var printContent = document.getElementById('print-content').innerHTML;
        printWindow.document.write('<html><head><title>Print Results</title></head><body>' + printContent + '</body></html>');

        printWindow.print();
    }

  </script>
