<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.Collections" %>
<%@ page import="blog.BlogPost" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>

 	<head>
  		<meta charset="utf-8">
  		<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" /> 
  		<title>A form</title>
 	</head>
	
	<body>
		<h1>You have been removed from our subscribers list!</h1>
 		<p>
 		You will no longer receive daily updates! To resume updates, please re-subscribe. </br>
 		</p>
 		<a href="blog.jsp">Okay, take me back to the blog!</a>
	</body>
	
</html>