class AddAttachmentImageToOpportunities < ActiveRecord::Migration
  def self.up
    change_table :opportunities do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :opportunities, :image
  end
end
