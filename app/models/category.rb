class Category < ActiveRecord::Base
  has_many :lures
  has_many :catches
  has_many :catches, through: :lures

  validates :name, presence: true
end
