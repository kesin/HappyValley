class AddVersionToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :version, :text
  end
end
