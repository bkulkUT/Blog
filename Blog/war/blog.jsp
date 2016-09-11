<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="java.util.Collections" %>
<%@ page import="blog.BlogPost" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
   <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
 </head>
 
  <body>

<%
    String blogName = request.getParameter("blogName");

    if (blogName == null) {
        blogName = "Bharat and Aftab's Blog";
    }

    pageContext.setAttribute("blogName", blogName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();

    if (user != null) {
      pageContext.setAttribute("user", user);
%>

	<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
	<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
	
	<form action="/writepost.jsp" method="post">
		<div><input type="submit" value="Create a New Post" /></div>
	</form>
<%
    } 
    
    else {
%>

	<p>Hello!
	<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
	to include your name with your posts.</p>

<%
    }
%>

<%
	ObjectifyService.register(BlogPost.class);
	List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list();   
	Collections.sort(posts);
	
    if (posts.isEmpty()) {
%>
       
    <p>Blog '${fn:escapeXml(blogName)}' has no posts.</p>
<%
    } 
    
    else {
%>

        <p>Posts in Blog '${fn:escapeXml(blogName)}'.</p>

<%
        for (BlogPost post : posts) {
            pageContext.setAttribute("post_content", post.getContent());
            pageContext.setAttribute("post_user", post.getUser());
%>

            <p><b>${fn:escapeXml(post_user.nickname)}</b> wrote:</p>

<%
         }
%>

            <blockquote>${fn:escapeXml(post_content)}</blockquote>
            
<%
    }
%>

  </body>
  
</html>



















