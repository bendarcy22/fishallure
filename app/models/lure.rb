class Lure < ActiveRecord::Base
  mount_uploader :lure_photo, LurePhotoUploader

  CATEGORIES = [
      ["Bait", "Bait"],
      ["Fly", "Fly"],
      ["Jig", "Jig"],
      ["Plug", "Plug"],
      ["Soft Plastic", "Soft Plastic"],
      ["Spinner", "Spinner"],
      ["Spinnerbait", "Spinnerbait"],
      ["Spoon", "Spoon"],
    ].freeze

  belongs_to :user
  has_many :catches
  has_many :fish_types, through: :catches

  validates :name, presence: true
  validates :manufacturer, presence: true
  validates :category, presence: true
  validates :user_id, presence: true
end
