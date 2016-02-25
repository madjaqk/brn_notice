Rails.application.config.middleware.use OmniAuth::Builder do 
	provider :twitter, ENV['srJwHzRTzjJxc0cUGohYu7jpb'], ENV['pGgz4bWWtoVDnxH3eZ6gnzjZ76xwWBpjpz5tQ7VojtQER51k5d']
	provider :facebook, "1683369941943723", "5fd629e42b0c811536aa6ffa8a57ec2d", scope: 'public_profile', info_fields: 'id,first_name,last_name,email,picture' 
	provider :google_oauth2, "640397428630-qd690b6rmmukc6e6qk4bqq1vvvrlqhus.apps.googleusercontent.com", "JaqUtGpQlM9v-sEVlmQcrMID", scope: "profile", image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'
	# First string is app ID, then app secret.  Strings should be replaced with environmental variables in production.

	# StackOverflow answer that solved my "certificate verify failed" error: http://stackoverflow.com/a/16134586/5749040
end

OmniAuth.config.on_failure = Proc.new do |env|
	SessionsController.action(:auth_failure).call(env)
end