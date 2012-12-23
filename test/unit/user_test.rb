require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a use should enter their first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "a use should enter their last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "a use should enter their profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "the user should have a unique profile name" do
    user = User.new
    user.profile_name = "willmull"
    user.email = "will-mull@hotmail.com"
    user.first_name = "Will"
    user.last_name = "Mullane"
    #user.password = "100EARS83"
    #user.password_confirmation = "100EARS83"
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new
    user.profile_name = "My profile with spaces"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("must be formatted correctly.")
  end

end
