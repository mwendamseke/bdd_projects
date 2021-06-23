class Organisation < ActiveRecord::Base
	has_many :memberships
	has_many :users, through: :memberships

	has_many :submissions, through: :opportunities
	# belongs_to :users

	acts_as_follower
	acts_as_followable

	has_many :opportunities

	# has_and_belongs_to_many :users


	has_attached_file :image, 
  									 styles: { thumb: "500x500>" }, 
  									 storage: :s3, 
  									 s3_credentials: {
  									 	bucket: 'ffolioapp',
  									 	access_key_id: Rails.application.secrets.s3_access_key,
  									 	secret_access_key: Rails.application.secrets.s3_secret_key
  									 }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
	after_create :set_role_name

	def creator_role=(role_name)
		@role_name = role_name
	end

	def creator_role
	end



	private
	
	def set_role_name
		memberships.first.update(role: @role_name)
	end

end



