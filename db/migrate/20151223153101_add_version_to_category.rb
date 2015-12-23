class AddVersionToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :version, :text
  end
end
