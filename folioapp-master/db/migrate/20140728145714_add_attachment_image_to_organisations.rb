class AddAttachmentImageToOrganisations < ActiveRecord::Migration
  def self.up
    change_table :organisations do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :organisations, :image
  end
end
