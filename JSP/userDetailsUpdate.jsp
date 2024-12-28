<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="omadiki5.*" %>
<%@ page import="java.util.*" %>
<%@ page errorPage="errorpage.jsp" %>




<%
// Getting the reference parameters from the form.
String username = request.getParameter("username");
String name = request.getParameter("fullname");
String email = request.getParameter("email");
String phone = request.getParameter("phone");




// convert variables to UTF-8 to support Greek (GR) characters input
if (name != null) {
    name = new String(name.getBytes("ISO-8859-1"), "UTF-8");
}






// variables conditional checks 
int countErrors = 0;
List<String> errorsFound = new ArrayList<String>();

if (name == null || name.length() < 5) {
    errorsFound.add("Παρακαλώ εισάγετε το ονοματεπώνυμό σας (τουλάχιστον 5 χαρακτήρες)");
    countErrors++;
}

if (phone == null || phone.length() != 10) {
    errorsFound.add("Παρακαλώ εισάγετε το τηλέφωνό σας (ακριβώς 10 ψηφία)");
    countErrors++;
}






// Part if there are errors (at least 1) 
// If there is an error in form data, then add an attribute (with name errorMessage) to request & forward to edit form.
if (countErrors > 0) {
    request.setAttribute("errorMessage", "Form has " + (countErrors == 1 ? "1 error!" : countErrors + " errors!"));
%>
    <jsp:forward page="userDetails.jsp"/>
<%
    return;
}




// Part if there are NO errors 
// Update user details from user's input (form data).
User userThis = new User(username, name, email, phone);
try {
    UserDAO userDaoThis = new UserDAO();
    userDaoThis.updateDetails(userThis);
    // If update is successful, redirect to index.jsp
    response.sendRedirect("index.jsp");
} catch (Exception e) { 
    // Handle exception if needed
    request.setAttribute("message", e.getMessage());
    // Forward to userDetails.jsp in case of an exception
    request.getRequestDispatcher("index.jsp").forward(request, response);
}
%>