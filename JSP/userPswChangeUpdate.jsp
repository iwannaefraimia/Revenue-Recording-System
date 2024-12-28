<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>




<%
// Getting the reference parameters from the login session (authenticated user).
User authenticatedUser = (User)session.getAttribute("authenticated_user"); 
String authPsw = authenticatedUser.getPassword();

// Getting the reference parameters from the form.
String username = request.getParameter("username");
String oldPassword = request.getParameter("oldPassword");
String newPassword = request.getParameter("newPassword");
String newPassword2 = request.getParameter("newPassword2");




// password variables checks
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (!oldPassword.equals(authPsw)) {
  errorsFound.add("Το παλιό password που πληκτρολογήσατε είναι λάθος. Παρακαλώ εισάγετε σωστά το παλιό password σας");
  countErrors++;
}

// if (newPassword == null || newPassword.length() < 8) {
  // errorsFound.add("Παρακαλώ εισάγετε το νέο password σας (τουλάχιστον 8 χαρακτήρες αγγλικούς, αριθμούς ή και σύμβολα)");
  // countErrors++;
// }

if (newPassword.equals(authPsw)) {
  errorsFound.add("Το νέο password είναι ίδιο με το παλιό σας! Παρακαλώ εισάγετε διαφορετικό ως νέο password");
  countErrors++;
}

if (!newPassword2.equals(newPassword)) {
  errorsFound.add("Τα 2 πεδία του νέου password δεν ταιριάζουν! Παρακαλώ εισάγετε ξανά το ίδιο νέο password σας και στα 2 πεδία");
  countErrors++;
}






// Part if there are errors (at least 1) 
// If there is an error in form data, then add an attribute (with name errorMessage) to request & forward to edit form.
if (countErrors > 0) {
    request.setAttribute("errorMessage", "Form has " + (countErrors == 1 ? "1 error!" : countErrors + " errors!"));
%>
      <!-- errors message -->
      <div class="row">
        <div class="col-xs-12">
          <div class="alert alert-danger">
            <ol>
<% for (String error : errorsFound) { %>
              <li><%=error %></li>
<% } %>
            </ol>            
          </div>
        </div>
      </div>

<%
request.getRequestDispatcher("userPswChange.jsp").forward(request, response);
}




// Part if there are NO errors 
// Update user's password from user's input (form data).
User userThis = new User(username, newPassword);
UserDAO userDaoObject = new UserDAO();
try {
    userDaoObject.updatePassword(userThis);
 } catch (Exception e) { 
    request.setAttribute("message", e.getMessage());
 }
 if (request.getAttribute("message") != null) { 
%>


<jsp:forward page="index.jsp"/>


<%
}
%>
