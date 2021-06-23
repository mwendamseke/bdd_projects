class AddCollectionIdToWorks < ActiveRecord::Migration
  def change
    add_reference :works, :collection, index: true
  end
end
