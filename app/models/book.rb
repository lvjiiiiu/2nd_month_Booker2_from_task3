class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments,dependent: :destroy

  # title：空でないように設定してください。
  # body：空でない、かつ最大200文字までに設定してください。
  validates :title, :body, presence: true
  validates :body, length: { maximum: 200 }
  
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  
end
