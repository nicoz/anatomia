class UserMailer < ActionMailer::Base
  default from: "notifications@anatomia.com.uy"

  def welcome_email(user)
  	@user = user
  	@url = "http://example.com/login"
  	mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
