class Catch < ActiveRecord::Base
  extend TimeSplitter::Accessors
  split_accessor :caught_at

  belongs_to :user
  belongs_to :lure
  belongs_to :fish_type

  validates :user_id, presence: true
  validates :lure_id, presence: true
  validates :fish_type_id, presence: true
  validates :zipcode, presence: true, length: { is: 5 }, numericality: { only_integer: true }
  validates :caught_at, presence: true
end
