class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  attachment :profile_image
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  
  has_many:user_rooms
  has_many:chats
has_many:rooms, through: :user_rooms
  
# 1. followメソッド　＝　フォローする
  def follow(user_id)
   follower.create(followed_id: user_id)
  end

# 2. unfollowメソッド　＝　フォローを外す
  def unfollow(user_id)
   follower.find_by(followed_id: user_id).destroy
  end

# 3. followingメソッド　＝　既にフォローしているかの確認
  def following?(user)
   following_user.include?(user)
  end
  
  
  # name：一意性を持たせ、かつ2～20文字の範囲で設定してください。
  validates :name, uniqueness: true
  validates :name, length: { in: 2..20 }
  #  introduction：最大50文字までに設定してください。
  validates :introduction, length: { maximum: 50 }
  
include JpPrefecture
  jp_prefecture :prefecture_code　
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  
  after_create :complete_mail

  def complete_mail
    ThanksMailer.complete_mail(self).deliver
  end
end
