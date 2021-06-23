class AddCaptionToWorks < ActiveRecord::Migration
  def change
    add_column :works, :caption, :text
  end
end
