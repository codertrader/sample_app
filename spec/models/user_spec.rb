# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do
  before :each do
    @attr = {:name=>'Example User',
	     :email=>'user@example.com',
             :password=>'foobar',
             :password_confirmation=>'foobar'} 
  end

  it 'should create a new instance given valid attributes' do
    User.create!(@attr) 
  end

  it 'should require a name' do
    no_name_user = User.new(@attr.merge({:name=>''}))
    no_name_user.should_not be_valid 
  end

  it 'should require an email' do
    no_name_user = User.new(@attr.merge({:email=>''}))
    no_name_user.should_not be_valid 
  end

  it 'should reject names that are too long' do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge({:name=>long_name}))
    long_name_user.should_not be_valid
  end

  it 'should reject invalid email addresses' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo]
    addresses.each do |address| 
      invalid_email_user = User.new(@attr.merge({:email=>address}))
      invalid_email_user.should_not be_valid 
    end
  end

  it 'should not allow duplicate email addresses' do
    User.create!(@attr)
    user_with_dup_address = User.new(@attr.merge({:email=>@attr[:email].upcase}))
    user_with_dup_address.should_not be_valid 
  end

  describe "password validations" do 
    it 'should require a password' do
      user_no_pass = User.new(@attr.merge({:password=>'',:password_confirmation=>''}))
      user_no_pass.should_not be_valid 
    end

    it 'should require a matching password confirmation' do
      user = User.new(@attr.merge(:password_confirmation=>'invalid'))
      user.should_not be_valid 
    end

    it 'should reject short passwords' do
      short = 'a'*5
      user = User.new(@attr.merge({:password=>short,:password_confirmation=>short})) 
      user.should_not be_valid 
    end

    it 'should reject long passwords' do
      long = 'a'*41
      user = User.new(@attr.merge({:password=>long,:password_confirmation=>long}))
      user.should_not be_valid 
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it 'should have an encrypted password attribute' do
      @user.should respond_to(:encrypted_password) 
    end

    it 'should set the encrypted password' do
      @user.encrypted_password.should_not be_blank
    end

    describe 'has_password? method' do

      it 'should be true if the passwords match' do
        @user.has_password?(@attr[:password]).should be_true 
      end

      it 'should be false if the passwords do not match' do
        @user.has_password?('invalid').should be_false
      end
    end

    describe "authenticate method" do

      it 'should return nil on email password mismatch' do 
	wrong_password_user = User.authenticate(@attr[:email],'wrongpass')
        wrong_password_user.should be_nil	
      end

      it 'should return nil for an email address with no user' do
	nonexistent_user = User.authenticate("bar@foo.com",@attr[:password])
        nonexistent_user.should be_nil	
      end

      it 'should return the user on email/password match' do
        user = User.authenticate(@attr[:email],@attr[:password])
        user.should == @user
      end

    end
 
  end

end