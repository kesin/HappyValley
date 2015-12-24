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
  has_many :versions, -> { where(versions: { type_name: "article"}) } ,foreign_key: "type_id", dependent: :destroy

  def article_version_max
    self.versions.pluck(:version_id).max
  end
end
