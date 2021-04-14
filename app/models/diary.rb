class Diary < ApplicationRecord

  belongs_to :user
  attachment :image
end
