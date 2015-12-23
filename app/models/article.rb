# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#

class Article < ActiveRecord::Base
  belongs_to :category
  serialize :version, Array
end
