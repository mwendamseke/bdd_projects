class CreateWorkSelections < ActiveRecord::Migration
  def change
    create_table :work_selections do |t|
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
