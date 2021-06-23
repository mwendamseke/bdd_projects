class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.belongs_to :opportunity, index: true
      t.belongs_to :organisation, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
