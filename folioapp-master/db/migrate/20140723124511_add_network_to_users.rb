class AddNetworkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :network, :string
  end
end
