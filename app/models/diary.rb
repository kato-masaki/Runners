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
    Diary.where('caption LIKE ?', '%' + content + '%')
  end

  def self.last_week
    @ranks = Diary.joins(:favorites).where(diaries: { created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday) }).group(:id).order("count(*) desc").limit(3)
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
