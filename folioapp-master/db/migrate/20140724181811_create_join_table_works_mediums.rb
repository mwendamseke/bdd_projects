class CreateJoinTableWorksMediums < ActiveRecord::Migration
  def change
    create_join_table :works, :media do |t|
      # t.index [:work_id, :medium_id]
      # t.index [:medium_id, :work_id]
    end
  end
end
