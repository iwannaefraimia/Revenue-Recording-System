<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page errorPage="errorpage.jsp" %>





<%
// Retrieve form parameters & translate the bloody date variables to string!


    // Date apo 
        String datefromStr = request.getParameter("DateFrom");
        java.sql.Date datefrom = null;
        if (datefromStr != null && !datefromStr.isEmpty()) {
            try {
    datefrom = java.sql.Date.valueOf(datefromStr);
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            }
        }


    // Date eos 
        String datetoStr = request.getParameter("DateTo");
        java.sql.Date dateto = null;
        if (datetoStr != null && !datetoStr.isEmpty()) {
            try {
    dateto = java.sql.Date.valueOf(datetoStr);
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            }
        }


    // Amount min
        String amountStr = request.getParameter("AmountMin");
        BigDecimal amountmin = null;
        if (amountStr != null && !amountStr.isEmpty()) {
        try {
    amountmin = new BigDecimal(amountStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }


    // SAP (SAP)
    String sap = request.getParameter("SAP");

    // Account 
    String account = request.getParameter("Account");

    // Asset category
    String assetcatID = request.getParameter("AssetCat");

    // Asset 
    String assetID = request.getParameter("Asset");

    // Incometype 
    String incometypeID = request.getParameter("IncomeType");







// Constraints check
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (datefrom != null && dateto != null && dateto.compareTo(datefrom) < 0) {
    errorsFound.add("Η ημερομηνία ΕΩΣ θα πρέπει να είναι μεγαλύτερη από την ημερομηνία ΑΠΟ");
    countErrors++;
}





// Call findIncomes method with the provided parameters
IncomeService iService = new IncomeService();
List<Income> foundIncomesList = iService.findIncomes(datefrom, dateto, amountmin, account, assetcatID, assetID, incometypeID, sap);


// Aiding lists
AccountService accService = new AccountService();
List<Account> accounts = accService.getAccounts();

// AssetCatService acService = new AssetCatService();
// List<AssetCat> assetcats = acService.getAssetCats();
    
AssetService aService = new AssetService();
List<Asset> assets = aService.getAssets();

IncomeTypeService itService = new IncomeTypeService();
List<IncomeType> incometypes = itService.getIncomeTypes();


%>




<!-- custom aiding method to format amounts by thousands separator with 2 decimal digits -->
<%!

public String formatNumber(BigDecimal number) {
    if (number == null) {
        return "";
    }
    NumberFormat numberFormat = NumberFormat.getInstance();
    numberFormat.setMaximumFractionDigits(2);
    numberFormat.setMinimumFractionDigits(2);
    return numberFormat.format(number);
}
%>

<!-- custom aiding method to convert date from database to string for this resultstable -->
<%!

String formatDate(Date date) {
    if (date != null) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(date);
    }
    return "";
}



%>






<!-- Now starts the HTML / JSP page -->
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Αποτελέσματα αναζήτησης Εσόδων</title>

    <%@ include file="components/header.jsp" %>

</head>



<body class="d-flex flex-column">
    <%@ include file="components/navbar.jsp" %>



    <div class="container theme-showcase" role="main">
        <div class="page-header">
            <h1>Αποτελέσματα αναζήτησης Εσόδων</h1>
        </div>

		
        <div id="print-content">
            <div class="row">
                <div class="col-xs-12">
                    <% if (foundIncomesList != null && !foundIncomesList.isEmpty()) { %>
                        <table class="table">

                            <thead>
                                <tr>
                                    <th>Ημ/νία κατάθ.<br>(Δημόσιο)</th>
                                    <th>Ημ/νία κατάθ.<br>(ΤΑΙΠΕΔ)</th>
                                    <th>Ποσό καταθ.</th>
                                    <th>Δόση / Έτος</th>
                                    <th>Αναλυτική<br>περιγραφή</th>
                                    <th>Κωδ. SAP</th>
                                    <th>Λογαρ.<br>κατάθεσης</th>
                                    <th>Π/Σ</th>
                                    <th>Τύπος εσόδου</th>
                                </tr>
                            </thead>

                            <tbody>
    <% for (Income foundincome : foundIncomesList) { %>
                                <tr>

                                    <td style="white-space: nowrap;"><%= foundincome.getIncomeDateKatath() %></td>

                                    <td style="white-space: nowrap;"><% Date incomeDateTaiped = foundincome.getIncomeDateTaiped();
                                            if (incomeDateTaiped != null) { %>
                                        <%= formatDate(incomeDateTaiped) %>
                                            <% } %> </td>

                                    <td style="text-align: right;"><%= formatNumber(foundincome.getIncomeAmount()) %></td>

                                    <td><%= foundincome.getIncomeDosi() %></td>

                                    <td>    <% String incomeDescr = foundincome.getIncomeDescr();
                                            if (incomeDescr != null) { %>
                                        <%= incomeDescr %>
                                            <% } %> </td>

                                    <td>    <% String incomeSAP = foundincome.getIncomeSAP();
                                                if (incomeSAP != null) { %>
                                        <%= incomeSAP %>
                                                <% } %> </td>

                                    <td><%= foundincome.getIncomeAccount() %></td>

                                    <!-- 8th column to get the income's Asset name from assetID (getIncomeAsset)-->
                                    <td>    <% String assetNameInTable = "";
                                            for (Asset assetInForm : assets) {
                                                if (assetInForm.getAssetID() == foundincome.getIncomeAsset()) {
                                                    assetNameInTable = assetInForm.getAssetName();
                                                break;
                                                }
                                            } %>
                                        <%= assetNameInTable %></td>

                                    <!-- 9th column to get the incometype name from incometypeID (getIncomeIncomeType)-->
                                    <td>
                                            <% String incometypeNameInTable = "";
                                            for (IncomeType incometypeInForm : incometypes) {
                                                if (incometypeInForm.getIncomeTypeID() == foundincome.getIncomeIncomeType()) {
                                                    incometypeNameInTable = incometypeInForm.getIncomeTypeName();
                                                break;
                                                }
                                            } %>
                                        <%= incometypeNameInTable %></td>


                                    <!-- action buttons-->
                                    <td class="text-center">
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <a href="editIncome.jsp?incomeID=<%=foundincome.getIncomeID() %>" class="btn btn-warning btn-xs" title="Επεξεργασία Εσόδου" style="margin-right: 5px;">
                                                    <span class="glyphicon glyphicon-pencil"></span>
                                                </a>
                                            </div>
                                            <div class="col-xs-6">
                                                <a href="#" class="btn btn-danger btn-xs delete-btn" title="Διαγραφή εσόδου" income-id="<%=foundincome.getIncomeID() %>">
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
                var incomeID = button.getAttribute('income-id');

                // 1st confirmation dialog
                var firstConfirmation = confirm('Είστε σίγουροι για τη διαγραφή του συγκεκριμένου εσόδου;');

                if (firstConfirmation) {
                    // 2nd confirmation dialog
                    var secondConfirmation = confirm('Είστε 100% σίγουροι; Μετά το 2ο ΟΚ, η διαγραφή δεν μπορεί να ανακληθεί!');

                    if (secondConfirmation) {
                        // User confirmed both dialogs, proceed with the delete method
                        window.location.href = 'deleteIncome.jsp?incomeID=' + incomeID;
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
