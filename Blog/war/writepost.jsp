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
		<style>
			.alert {
			    padding: 20px;
			    background-color: #f44336;
			    color: white;
			}
			
			.closebtn {
			    margin-left: 15px;
			    color: white;
			    font-weight: bold;
			    float: right;
			    font-size: 22px;
			    line-height: 20px;
			    cursor: pointer;
			    transition: 0.3s;
			}
			
			.closebtn:hover {
			    color: black;
			}
		</style>
	</head>
	
	<body>
		<br>
		<center><h3> Record your thoughts and hit Post!</h3></center>
		<br>
		
		<center>
		<form action="/sign" method="post">
			<div><textarea name="contentTitle" rows="1" cols="60"></textarea></div><br>
			<div><textarea name="content" rows="20" cols="60"></textarea></div>
			<br>
			<br>
			<div><input type="submit" name="submitPost" value="Post" />&nbsp
			<input type="reset" value="Clear Post" />&nbsp
			<input type="submit" name="cancel" value="Cancel Post"></div>
			<input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>
			<br><br><br><br><br><br><br><br><br>
		</form>
		</center>
		
		<div class="alert">
  			<span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
  			<strong>Note!</strong> If you leave the title or body empty, your post will not be recorded!
		</div>
	</body>
	
</html>
	