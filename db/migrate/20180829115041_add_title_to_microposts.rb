class AddTitleToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :title, :text
    add_index :microposts, :title
  end
end
