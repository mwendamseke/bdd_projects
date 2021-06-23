class Workselection < ActiveRecord::Base
  belongs_to :user
  has_many :works

  validates :works, length: {maximum: 3}
end
