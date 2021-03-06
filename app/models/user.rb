class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  attachment :profile_image

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  
  def me?(user_id)
    id === user_id
  end

  def self.search_for(content)
    where('name LIKE ?', '%' + content + '%')
  end

  validates :name, length: { maximum: 20, minimum: 2 }, uniqueness: true
  validates :residence, length: { maximum: 20 }
  validates :introduction, length: { maximum: 100 }
  validates :occupation, length: { maximum: 20 }

  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end
end
