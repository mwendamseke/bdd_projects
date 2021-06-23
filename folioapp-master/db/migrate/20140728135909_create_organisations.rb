class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name
      t.text :description
      t.string :network
      t.string :organisation_type

      t.timestamps
    end
  end
end
