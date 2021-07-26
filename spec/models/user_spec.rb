require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) { User.new(first_name: 'Andy', last_name: 'Li', email: 'test@example.com', password: 'test', password_confirmation: 'test') }

    it 'should be valid when password match' do
      expect(user).to be_valid
    end
    it "should be invalid when passwords not match" do
      user.password = "tste"
      expect(user).to_not be_valid
    end
    it "should be invalid when passwords is less than minimum requirement" do
      user.password = "t"
      user.password_confirmation = "t"
      expect(user).to_not be_valid
    end
    it "should be invalid when password confirmation is empty" do
      user.password_confirmation = nil
      expect(user).to_not be_valid
    end
    it "should be invalid when email is empty" do
      user.email = nil
      expect(user).to_not be_valid
    end
    it "should be invalid when first Name is empty" do
      user.first_name = nil
      expect(user).to_not be_valid
    end
    it "should be invalid when last Name is empty" do
      user.last_name = nil
      expect(user).to_not be_valid
    end
  end

  describe '.authenicate_with_credentials' do
    let(:user) { User.new(first_name: 'Andy', last_name: 'Li', email: 'test@example.com', password: 'test', password_confirmation: 'test') }

    it "should return truthy when password and email in good layout" do
      user.save!
      @new_login = User.authenticate_with_credentials("test@example.com", "test")
      expect(@new_login).to be_truthy
    end
    it "should return truthy even when email in a few spaces before and/or after" do
      user.save!
      @new_login = User.authenticate_with_credentials("     test@example.com ", "test")
      expect(@new_login).to be_truthy
    end
    it "should return truthy even when email is in wrong case" do
      user.save!
      @new_login = User.authenticate_with_credentials("TEST@example.com", "test")
      expect(@new_login).to be_truthy
    end
    it "should return nil when password and email not be found from database" do
      user.save!
      @new_login = User.authenticate_with_credentials("test@example.com", "test")
      expect(@new_login).to be_nil
    end
  end
end