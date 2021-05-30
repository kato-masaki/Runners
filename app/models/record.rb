class Record < ApplicationRecord
  belongs_to :user
  
  with_options presence: true do
    validates :distance
    validates :hour
    validates :minute
    validates :second
    validates :pace_minute
    validates :pace_second
  end
  
end
