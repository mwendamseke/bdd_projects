class CreateJoinTableWorksGenres < ActiveRecord::Migration
  def change
    create_join_table :works, :genres do |t|
      # t.index [:work_id, :genre_id]
      # t.index [:genre_id, :work_id]
    end
  end
end
