class AddSubmissionToWorks < ActiveRecord::Migration
  def change
    add_reference :works, :submission, index: true
  end
end
