# == Schema Information
#
# Table name: decoys
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Decoy < ActiveRecord::Base
end
