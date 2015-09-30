require 'digest'
class User < ActiveRecord::Base
	 has_many :text_posts

	def construct_password(pass)
		self.passsalt = ""
		20.times{self.passsalt << 65+rand(25)}
		self.passhash = Digest::SHA256.hexdigest(pass+self.passsalt)
	end

	def  password_valid?(pass)
		return self.passhash == Digest::SHA256.hexdigest(pass+self.passsalt)
	end

	def construct_validation
		self.validated = false;
		self.validation_code = "";
		8.times{self.validation_code << 65+rand(25)}
	end

	def get_user_title
		return (self.userlevel == 0 ? "<p class=\"usertitle user\"><i class=\"fa fa-user\"></i> User</p>" : (self.userlevel == 1 ? "<p class=\"usertitle premium\"><i class=\"fa fa-trophy\"></i> Premium</p>"   : (self.userlevel == 2 ? "<p class=\"usertitle moderator\"><i class=\"fa fa-shield\"></i> Moderator</p>"  : (self.userlevel == 3 ? "<p class=\"usertitle admin\"><i class=\"fa fa-cog\"></i> Admin</p>"  : "<p class=\"usertitle hacker\"><i class=\"fa fa-exclamation-triangle\"></i> Hacker</p>"  ))))
	end

	def get_gravatar
		return "http://www.gravatar.com/avatar/" << Digest::MD5.hexdigest(self.email.downcase)  << "?s=256&default=retro"
	end
end
	