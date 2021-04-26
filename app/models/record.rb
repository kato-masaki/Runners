class Record < ApplicationRecord
  belongs_to :user

  validates :distance, presence: true
  validates :hour, presence: true
  validates :minute, presence: true
  validates :second, presence: true
  validates :pace_minute, presence: true
  validates :pace_second, presence: true
end
