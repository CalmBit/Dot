class UserMailer < ApplicationMailer
	default from: 'noreply@calmbit.com'
	def validation_email(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to Dot')
	end
end
