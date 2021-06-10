class Diary < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def self.search_for(content)
    where('caption LIKE ?', '%' + content + '%')
  end

  def self.last_week
    now = Time.current
    @ranks = joins(:favorites).where(diaries: { created_at: now.prev_week..now.prev_week(:sunday) }).group(:id).order("count(*) desc").limit(3)
  end
  
  with_options presence: true do
    validates :image
    validates :distance
    validates :hour
    validates :minute
    validates :second
    validates :pace_minute
    validates :pace_second
    validates :caption
  end
  
end
