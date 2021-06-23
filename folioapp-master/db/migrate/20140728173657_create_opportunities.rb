class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.belongs_to :organisation, index: true
      t.string :title
      t.text :description
      t.text :requirements

      t.timestamps
    end
  end
end
