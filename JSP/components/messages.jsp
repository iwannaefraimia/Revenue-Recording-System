<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!-- error or success message -->
<%
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
