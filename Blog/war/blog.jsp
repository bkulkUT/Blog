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
	<style>
		div.container {
		    width: 100%;
		    border: 1px solid gray;
		}
		
		header, footer {
		    padding: 1em;
		    color: white;
		    background-color: black;
		    clear: left;
		    text-align: center;
		}
		
		nav {
		    float: left;
		    max-width: 160px;
		    margin: 0;
		    padding: 1em;
		}
		
		nav ul {
		    list-style-type: none;
		    padding: 0;
		}
		   
		nav ul a {
		    text-decoration: none;
		}
		
		article {
		    margin-left: 170px;
		    border-left: 1px solid gray;
		    padding: 1em;
		    overflow: hidden;
		}
	</style>
	<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
	</head>
 
 <body>
 <div class="container">

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

	<header>
	   <h1>Random Thoughts</h1>
	</header>
	  
	<nav>
	  <ul>
	    <li><a href="test.jsp">View all posts</a></li>
	  </ul>
	</nav>
	
<%
	ObjectifyService.register(BlogPost.class);
	List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list();   
	Collections.sort(posts);
	Collections.reverse(posts);
	
    if (posts.isEmpty()) {
%>
       
    <p>Blog '${fn:escapeXml(blogName)}' has no posts.</p>
	<br> 
    
<%
    } 
    
    else {
%>

       
		<article>
<%
    int counter = 0;    
	for (BlogPost post : posts) {
		pageContext.setAttribute("post_content", post.getContent());
		pageContext.setAttribute("post_user", post.getUser());
		pageContext.setAttribute("current_date", post.getDate());
		pageContext.setAttribute("post_title", post.getTitle());
            
            
%>

            <p><b>${fn:escapeXml(post_user.nickname)} says:<h2>${fn:escapeXml(post_title)}</h2></b></p>
            <br>
            <blockquote>${fn:escapeXml(post_content)}</blockquote>
            <br>
            ${fn:escapeXml(current_date)}<hr><br>

<%
    	counter++;
		if (counter == 5) break;
	}
%>

		</article>
            
<%
    }
    
    if (user != null) {
%>

    	<form action="/writepost.jsp" method="post">
			<div><input type="submit" value="Create a New Post" /></div>
		</form>
	
<%
    }
%>
		
	<footer> Created by Bharat and Aftab </footer>
	</div>
	
  </body>
</html>



















