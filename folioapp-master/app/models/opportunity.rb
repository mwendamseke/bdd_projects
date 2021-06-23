class Opportunity < ActiveRecord::Base
  belongs_to :organisation
  has_many :submissions

	has_attached_file :image, 
  									 styles: { thumb: "500x500>" }, 
  									 storage: :s3, 
  									 s3_credentials: {
  									 	bucket: 'ffolioapp',
  									 	access_key_id: Rails.application.secrets.s3_access_key,
  									 	secret_access_key: Rails.application.secrets.s3_secret_key
  									 }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
