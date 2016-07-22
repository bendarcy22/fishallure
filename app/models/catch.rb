class Catch < ActiveRecord::Base
  mount_uploader :catch_photo, CatchPhotoUploader

  belongs_to :user
  belongs_to :lure
  belongs_to :fish_type

  validates :user_id, presence: true
  validates :lure_id, presence: true
  validates :fish_type_id, presence: true
  validates :latitude, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :caught_at, presence: true
end
