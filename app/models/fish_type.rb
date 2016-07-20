class FishType < ActiveRecord::Base
  mount_uploader :fish_photo, FishPhotoUploader
  
  belongs_to :user
  has_many :catches
  has_many :lures, through: :catches


  validates :name, presence: true
  validates :user_id, presence: true
end
