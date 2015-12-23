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

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
