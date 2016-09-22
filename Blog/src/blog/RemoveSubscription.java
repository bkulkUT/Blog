package blog;

import java.io.IOException;

import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Ref;

import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class RemoveSubscription extends HttpServlet {
	
	/*
	 * Name : doPost
	 * Removes subscribers when they press 'Unsubscribe'. 
	 * The 'Unsubscribe' button and logic is implemented in blog.jsp
	 */
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
		Ref<Subscriptions> removeThis = ofy().load().type(Subscriptions.class).filter("index", user.getNickname()).first();
//		System.out.println("Current user " + user);
//		System.out.println("Contents of removeThis " + removeThis);
		
		if (removeThis != null) {
			ofy().delete().entities(removeThis);
		}
		
		else {
			System.out.println("Error : User not found in database!");
		}
		
//		Ref<Subscriptions> removed = ofy().load().type(Subscriptions.class).filter("index", user.getNickname()).first();
//		System.out.println("Contents of removed " + removed);
        
	}
}