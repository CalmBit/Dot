require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user validation" do
	user = User.new
	assert_not user.save, "User saved without information"
        usertwo = User.new(username: "johndoe", email: "johndoe@gmail.com", 'birthday(1i)' => "1997", 'birthday(2i)' => "8",  'birthday(3i)' => "17", password: "SecurePassword")
        usertwo.userlevel = 0
        assert usertwo.save, "User didn't save with information"
  end

  test "user password" do
    assert users(:one).authenticate("ThisIsASecurePassword"), "Password validation not working correctly, or fixture hashpass/salt changed."
    assert_not users(:one).authenticate("ThisIsNotASecurePassword"), "Password validation authenticating all passwords, or fixture hashpass/salt changed."
    user = User.new(username: "johndoe", email: "johndoe@gmail.com", 'birthday(1i)' => "1997", 'birthday(2i)' => "8",  'birthday(3i)' => "17", password: "SecurePassword")
    assert user.authenticate("SecurePassword"), "Dynamic generation of passwords not working"
    assert_not user.authenticate("NotASecurePassword"), "Dynamic genned auth isn't working!"
  end

  test "birthdate validation" do
    assert users(:one).of_age?, "18+ User not marked as being of age"
    assert_not users(:two).of_age?, "Under 18 User marked as being of age"
  end
end
