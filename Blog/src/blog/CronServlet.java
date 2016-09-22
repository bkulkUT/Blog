package blog;

import java.util.*;
import java.util.logging.Logger;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import blog.Subscriptions;

@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
	
	private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
	
	/*
	 * Name : doPost
	 * Implemented : Compiles list of subscribers. Calls retrieveCurrentBlogPosts to get blog posts created in the last 24 hrs. 
	 * TO-DO : Concatenate all of the blog posts in the retrieved list into a single file. Email said file to all subscribers
	 * in the list. 
	 */
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		try {
			_logger.info("Cron Job has been executed");

			List<Subscriptions> subscribers = ObjectifyService.ofy().load().type(Subscriptions.class).list();
			List<BlogPost> currentPosts = retrieveCurrentBlogPosts();
			
			// for testing purposes
			System.out.println("Number of subscribers: " + subscribers.size());
			
			// for testing purposes 
			for (BlogPost thisPost : currentPosts) {
				System.out.println("Current post ..." + thisPost.getDate());
			}
			
			// for testing purposes
			for (Subscriptions thisSubscriber : subscribers) {
				System.out.println("Subscriber: " + thisSubscriber.getEmail());
			}
			

		}	
		catch (Exception ex) {
			//Log any exceptions in your Cron Job
		}
	}
	
	/*
	 * Name : retrieveCurrentBlogPosts
	 * Called by : doPost
	 * This method looks through and compiles a List of blog posts made in the last 24 hrs. As per the requirement, subscribers should only receive 
	 * posts made in the last day. This method is complete, do not alter.
	 */
	List<BlogPost> retrieveCurrentBlogPosts() throws FileNotFoundException, UnsupportedEncodingException {
		
		System.out.println("In retrieve method!");
		
		Date currentDate = new Date(System.currentTimeMillis() - 60*60*1000*24);
		System.out.println("Current date is " + currentDate);
		
		ObjectifyService.register(BlogPost.class);
		List<BlogPost> posts = ObjectifyService.ofy().load().type(BlogPost.class).list();   
		Collections.sort(posts);
		Collections.reverse(posts);
		List<BlogPost> result = new ArrayList<BlogPost>();
		
		System.out.println("Number of posts " + posts.size());

		for(BlogPost post : posts) {
			
			if (post.getDate().after(currentDate)) {
				
				System.out.println("Date: " + post.getDate() + " This post is within the time limit!");
				result.add(post);
			}
			
			else {
				System.out.println("Date: " + post.getDate() + " This post is too old!");
			}
		}
		
		return result;
	}
	
	/*
	 * TO-DO : Implement sending emails to all users on subscribe list. You can change the parameters/method signature as you like. 
	 */
	void sendEmail() {
		
	}
}















