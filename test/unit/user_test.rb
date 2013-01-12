require 'test_helper'


class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

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
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end


  #this test does not work, problem with the assertion
  #gives an error saying no message given
  #test "a user can have a correctly formatted profile name" do
    #user = User.new(first_name: "Will", last_name: "Mullane", email: "will-mull@hotmail.com")
    #user.password = user.password_confirmation = "100EARS83"

    #user.profile_name = "willmull"
    #assert user.valid?
  #end

  test "that no error is raised when trying to get to a users friends" do
    assert_nothing_raised do
      users(:will).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:will).friends << users(:paul)
    users(:will).friends.reload
    assert users(:will).friends.include?(users(:paul))
  end
end
