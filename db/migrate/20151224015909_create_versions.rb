class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :type_name
      t.integer :type_id
      t.text :content
      t.integer :version_id

      t.timestamps
    end
  end
end
