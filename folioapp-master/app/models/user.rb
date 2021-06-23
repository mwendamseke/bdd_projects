class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  has_many :collections
  has_many :works, through: :collections

  has_many :memberships
  has_many :organisations, through: :memberships
  has_many :submissions
  has_one :work_selection

  acts_as_follower
  acts_as_followable

  after_initialize :give_default_collection


  has_attached_file :avatar, 
  									 # styles: { thumb: "100x100>" }, 
  									 storage: :s3, 
  									 s3_credentials: {
  									 	bucket: 'ffolioapp',
  									 	access_key_id: Rails.application.secrets.s3_access_key,
  									 	secret_access_key: Rails.application.secrets.s3_secret_key
  									 }
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  after_create :set_work_selection

  def formatted_profession
    if profession
      profession.split(", ").map(&:capitalize).to_sentence.gsub(" and ", " & ").gsub(", &", " &")
    end
  end


  def workSelection=(work_id_array)
    work_id_array.each do |id| 
      work_selection.works << Work.find(id)
    end 
  end



  def self.find_for_facebook_oauth(auth)
  where(auth.slice(:provider, :uid)).first_or_create do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name
    user.avatar = process_uri(auth.info.image) # no image by default
  end
end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
        return registered_user
      else

        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.uid+"@twitter.com",
                            password:Devise.friendly_token[0,20],
                            avatar:auth.extra.raw_info.profile_image_url,
                            short_bio:auth.info.description
                          )
      end

    end
  end


  private

  def self.process_uri(uri)
   avatar_url = URI.parse(uri)
   avatar_url.scheme = 'https'
   avatar_url.to_s
  end

  def give_default_collection
    if collections.none?
      collections << Collection.create(title: "My Collection", description: "This is your default collection")
    end
  end

  def set_work_selection
    update work_selection: WorkSelection.create
  end

end
