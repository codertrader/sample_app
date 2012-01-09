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

class User < ActiveRecord::Base
  
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation 

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => 'true'
  validates :name, :length => {:maximum => 50}

  validates :email, :presence => 'true'
  validates :email, :format => {:with => email_regex}
  validates :email, :uniqueness => {:case_sensitive => false}

  validates :password, :presence => 'true'
  validates :password, :confirmation => 'true'
  validates :password, :length => {:within => (6..40)}
end
