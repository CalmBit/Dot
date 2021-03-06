require 'digest'
class User < ActiveRecord::Base
	has_many :text_posts
	validates_uniqueness_of :username, case_sensitive: false
  	validates_uniqueness_of :email, case_sensitive: false
        validates :username, presence: true
        validates :email, presence: true
	has_secure_password

        def of_age?
          now = Time.now.utc.to_date
          yearsOfAge = now.year - self.birthday.year - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
          return yearsOfAge >= 18
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
		return "https://www.gravatar.com/avatar/" << Digest::MD5.hexdigest(self.email.downcase)  << "?s=256&default=retro"
	end
end
	
