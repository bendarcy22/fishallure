class Lure < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :catches
  has_many :fish_types, through: :catches

  validates :name, presence: true
  validates :manufacturer, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
end
