class AddTextToWorks < ActiveRecord::Migration
  def change
    add_column :works, :text, :text
  end
end
