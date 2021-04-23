class Diary < ApplicationRecord

  belongs_to :user
  attachment :image
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search_for(content)
    Diary.where('caption LIKE ?', '%' + content + '%')
  end
  
  validates :image, presence: true
  validates :distance, presence: true
  validates :hour, presence: true
  validates :minute, presence: true
  validates :second, presence: true
  validates :pace_minute, presence: true
  validates :pace_second, presence: true
  validates :caption, presence: true

end
