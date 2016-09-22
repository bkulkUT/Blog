package blog;

import java.io.IOException;

import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import static com.googlecode.objectify.ObjectifyService.ofy;

@SuppressWarnings("serial")
public class CreateSubscription extends HttpServlet {
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();        
        Subscriptions subs = new Subscriptions (user);
        ofy().save().entity(subs).now(); 
        
        resp.sendRedirect("/subscribe.jsp");
        
	}
}