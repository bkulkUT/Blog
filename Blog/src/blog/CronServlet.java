package blog;

import java.util.*;
import java.util.logging.Logger;
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

@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
	
	private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			_logger.info("Cron Job has been executed");
			List<User> subscribers = ObjectifyService.ofy().load().type(User.class).list();
			Iterator<User> iterator = subscribers.iterator();
            while(iterator.hasNext()){
            	UserService userService = UserServiceFactory.getUserService();
                User user = userService.getCurrentUser();
                System.out.println(user.getEmail());
                Properties props = new Properties();
                Session session = Session.getDefaultInstance(props, null);
                try {
                  Message msg = new MimeMessage(session);
                  msg.setFrom(new InternetAddress("admin@blog-143003.appspotmail.com", "Admin"));
                  msg.addRecipient(Message.RecipientType.TO,
                                   new InternetAddress(user.getEmail(), user.getNickname()));
                  msg.setSubject("Daily Blog Update");
                  Transport.send(msg);
                } catch (AddressException e) {
                  // ...
                } catch (MessagingException e) {
                  // ...
                } catch (UnsupportedEncodingException e) {
                  // ...
                }
             }
		}	
		catch (Exception ex) {
			//Log any exceptions in your Cron Job
		}
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
}