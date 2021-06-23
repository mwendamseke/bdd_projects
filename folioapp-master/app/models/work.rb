class Work < ActiveRecord::Base
  
	# belongs_to :user
	belongs_to :collection
  belongs_to :work_selection
	belongs_to :submission

  has_and_belongs_to_many :media
  has_and_belongs_to_many :genres

  validates :image, presence: {message: "You have not attached an image"}
  validates :title, presence: true

  has_attached_file :image, 
  									 styles: { thumb: "500x500>" }, 
  									 storage: :s3, 
  									 s3_credentials: {
  									 	bucket: 'ffolioapp',
  									 	access_key_id: Rails.application.secrets.s3_access_key,
  									 	secret_access_key: Rails.application.secrets.s3_secret_key
  									 }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

	after_save :work_format

	def user
		collection.user
	end

	def work_format
		# (text.blank? || text.include? "Write here...") ? "image" : "text"
		if text.blank? || text == "Write here..."
			"image"
		else
			"text"
		end
	end

	def medium_names
		names = []
		media.each {|medium| names << medium.name}
		names
	end

	def medium_names=(medium_list)
		medium_list.split(', ').each do |medium|
			media << Medium.find_or_create_by(name: medium)
		end
	end

	def genre_names
		names = []
		genres.each {|genre| names << genre.name}
		names
	end

	def genre_names=(genre_list)
		genre_list.split(', ').each do |genre|
			genres << Genre.find_or_create_by(name: genre)
		end
	end

	

end
