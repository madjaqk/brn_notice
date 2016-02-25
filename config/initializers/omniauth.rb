Rails.application.config.middleware.use OmniAuth::Builder do 
	provider :twitter, ENV['srJwHzRTzjJxc0cUGohYu7jpb'], ENV['pGgz4bWWtoVDnxH3eZ6gnzjZ76xwWBpjpz5tQ7VojtQER51k5d']
	provider :facebook, "1683369941943723", "5fd629e42b0c811536aa6ffa8a57ec2d", scope: 'public_profile', info_fields: 'id,first_name,last_name,link,picture' 
	# First string is app ID, then app secret.  Strings should be replaced with environmental variables in production.

	# StackOverflow answer that solved my "certificate verify failed" error: http://stackoverflow.com/a/16134586/5749040
end