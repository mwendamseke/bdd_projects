class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.belongs_to :user, index: true
      t.text :title

      t.timestamps
    end
  end
end
