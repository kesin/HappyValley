# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  type_name  :string(255)
#  type_id    :integer
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Version < ActiveRecord::Base
  serialize :content, Array
end
