class Book < ApplicationRecord
  belongs_to :user

  # title：空でないように設定してください。
  # body：空でない、かつ最大200文字までに設定してください。
  validates :title, :body, presence: true
  validates :body, length: { maximum: 200 }
end
