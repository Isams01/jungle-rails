require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User fields' do
    it 'must be created with password and password confirmation fields' do
      @user = User.new(first_name: "fname",last_name: "lname", email: "test@test.com", password: "test", password_confirmation: "test")
      expect(@user).to be_valid
    end
    it 'Should have a password field' do
      @user = User.new(first_name: "fname",last_name:"lname", email: "test@test.com", password: nil, password_confirmation: "TEest")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'should have matching password and password confirmation' do
      @user = User.new(first_name: "my name", last_name: "lname", email: "test@test.com", password: "test", password_confirmation: "TEest")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'should have a unique email' do
      @user1 = User.new(first_name: "ftest", last_name: "ltest", email: "test@test.com", password: "test", password_confirmation: "test")
      @user2 = User.new(first_name: "ftest", last_name: "ltest", email: "test@test.com", password: "test", password_confirmation: "test")
      p @user2.errors[:email].first
    end
    it 'should have an email, first name and last name' do
    end
  end
end