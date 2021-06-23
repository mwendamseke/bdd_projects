class CreateJoinTableWorkSubmission < ActiveRecord::Migration
  def change
    create_join_table :works, :submissions do |t|
      # t.index [:work_id, :submission_id]
      # t.index [:submission_id, :work_id]
    end
  end
end
