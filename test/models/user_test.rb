require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user validation" do
	user = User.new
	assert_not user.save, "User saved without information"
        usertwo = User.new(username: "johndoe", email: "johndoe@gmail.com", 'birthday(1i)' => "1997", 'birthday(2i)' => "8",  'birthday(3i)' => "17")
        usertwo.userlevel = 0
        usertwo.construct_password("fuckingpassword")
        assert usertwo.save, "User didn't save with information"
  end

  test "user password" do
    assert users(:one).password_valid?("ThisIsAStrongPasswordIPromise"), "Password validation not working correctly, or fixture hashpass/salt changed."
  end

  test "birthdate validation" do
    assert users(:one).of_age?, "18+ User not marked as being of age"
    assert_not users(:two).of_age?, "Under 18 User marked as being of age"
  end
end
