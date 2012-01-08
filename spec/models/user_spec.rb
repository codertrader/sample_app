# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  before :each do
    @attr = {:name=>'Example User',:email=>'user@example.com'} 
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

end
