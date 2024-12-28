<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page errorPage="errorpage.jsp" %>




<html>
  <head>
    <title>Omadiki5 - Εγγραφές εσόδων για το συγκεκριμένο Π/Σ</title>

    <%@include file="components\header.jsp" %>

  </head>


  <body>

<%
try {
    // Get the assetID from the request parameter
    int assetID = Integer.parseInt(request.getParameter("asset"));

    // Use the AssetService to retrieve the AssetName for the specified assetID
    AssetService assetService = new AssetService();
    String assetName = assetService.getAssetNameById(assetID);

    // Use the IncomeService to retrieve income records for the specified assetID
    IncomeService incomeService = new IncomeService();
    List<Income> incomes = incomeService.findIncomesByAsset(assetID);

    // Sort the incomes by IncomeDateKatath in descending order using an anonymous inner class
    Collections.sort(incomes, new Comparator<Income>() {
        public int compare(Income income1, Income income2) {
            return income2.getIncomeDateKatath().compareTo(income1.getIncomeDateKatath());
        }
    });
%>


        <!-- Display the income records in a table -->
        <div class="col-xs-12">
            <h2>Υφιστάμενες εγγραφές εσόδων (ανά ημ/νία) για το Π/Σ: <%= assetName %></h2>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-condensed">
                    <tr class="info">
                        <th>Ημ/νία Κατάθεσης</th>
                        <th>Ποσό</th>
                        <th>Δόση / Έτος</th>
                        <th>Περιγραφή</th>
                        <th>Λογαριασμός</th>
                        <th>Κατηγορία εσόδου</th>
                    </tr>
<% for (Income income : incomes) { %>
                    <tr>
                        <td><%= new SimpleDateFormat("dd/MM/yyyy").format(income.getIncomeDateKatath()) %></td>
                        <td><%= income.getIncomeAmount() %></td>
                        <td><%= income.getIncomeDosi() %></td>
                        <td><%= income.getIncomeDescr() %></td>
                        <td><%= income.getIncomeAccount() %></td>
                        <td><%= income.getIncomeTypeName() %></td>

                        <!-- buttons -->
                        <td class="text-center">
                            <a href="editIncomes.jsp?ID=<%=income.getIncomeID() %>" class="btn btn-warning btn-xs">
                            <span class="glyphicon glyphicon-pencil"></span>
                            </a>                        
                        </td>
                    </tr>
<% 
} 
%>
                </table>
            </div>
        </div>

<%
    } catch (Exception e) {
        // Handle exceptions here
        out.println("Error: " + e.getMessage());
    }
%>

  </body>

</html>
