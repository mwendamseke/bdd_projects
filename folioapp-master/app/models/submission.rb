class Submission < ActiveRecord::Base
  belongs_to :opportunity
  belongs_to :organisation
  belongs_to :user
  has_one :work

  accepts_nested_attributes_for :work


  after_create :set_status

  validates :work, presence: true

  def sender
  	user
  end

  def recipient
  	organisation
  end


  private

  def set_status
  	update(status: "Pending")
  end

end
