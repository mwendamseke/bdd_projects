class AddWorkSelectionToWorks < ActiveRecord::Migration
  def change
    add_reference :works, :work_selection, index: true
  end
end
