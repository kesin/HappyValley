# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :articles
  has_many :versions, -> { where(versions: { type_name: "category"}) } ,foreign_key: "type_id", dependent: :destroy
end
