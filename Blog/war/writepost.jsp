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
	   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
	</head>
	
	<body>
		<form action="/sign" method="post">
			<div><textarea name="contentTitle" rows="1" cols="60"></textarea></div><br>
			<div><textarea name="content" rows="20" cols="60"></textarea></div>
			<div><input type="submit" name="submitPost" value="Post" />
			<input type="reset" value="Clear Post" />
			<input type="submit" name="cancel" value="Cancel Post"></div>
			<input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>

		</form>
	</body>
	
</html>
	