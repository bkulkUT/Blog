package blog;

import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

/*
 * Entity class for Subscriptions
 * This is what is used to recall all users who are currently subscribed.
 */

@Entity
public class Subscriptions {
	
	@Id Long id;
	@Index String index;
	User user;
	
	private Subscriptions() {}
	
	public Subscriptions (User user) {
		this.user = user;
		this.index = user.getNickname();
	}
	
	public User getUser() {
		return user;
	}
	
	public String getEmail() {
		return user.getEmail();
	}
	
}