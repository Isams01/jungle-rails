require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with password and password confirmation fields' do
      @user = User.new(first_name: "fname",last_name: "lname", email: "test@test.com", password: "testtttt", password_confirmation: "testtttt")
      expect(@user).to be_valid
    end
    it 'Should have a password field' do
      @user = User.new(first_name: "fname",last_name:"lname", email: "test@test.com", password: nil, password_confirmation: "TEesttt")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'should have matching password and password confirmation' do
      @user = User.new(first_name: "my name", last_name: "lname", email: "test@test.com", password: "test", password_confirmation: "TEest")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'should have a unique email' do
      @user1 = User.new(first_name: "ftest", last_name: "ltest", email: "test@test.com", password: "testttt", password_confirmation: "testttt")
      @user1.save
      @user2 = User.new(first_name: "ftest", last_name: "ltest", email: "test@test.com", password: "testttt", password_confirmation: "testttt")
      @user3 = User.new(first_name: "ftest", last_name: "ltest", email: "TEST@test.com", password: "testttt", password_confirmation: "testttt")
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
      expect(@user3).to_not be_valid
      expect(@user3.errors.full_messages).to include("Email has already been taken")
    end
    it 'should have an email, first name and last name' do
      @userfirst = User.new(first_name: nil, last_name: "lname", email: "test@test.com", password: "test", password_confirmation: "test")
      @userlast = User.new(first_name: "fname", last_name: nil, email: "test@test.com", password: "test", password_confirmation: "test")
      expect(@userfirst).to_not be_valid
      expect(@userfirst.errors.full_messages).to include("First name can't be blank")
      expect(@userlast).to_not be_valid
      expect(@userlast.errors.full_messages).to include("Last name can't be blank")
    end
    it 'Sould have a minimum length of 4 characters for the password' do
      @user = User.new(first_name: "my name", last_name: "lname", email: "test@test.com", password: "tes", password_confirmation: "tes")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end
  end
  describe '.authenticate_with_credentials' do
  end

end