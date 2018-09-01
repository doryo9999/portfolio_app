class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  validates :title,   presence: true, length: { maximum: 100 }
  default_scope -> { order(created_at: :desc) }

  def self.search(search) #ここでのself.はMicropost.を意味する
    if search
      Micropost.where(['title LIKE ?', "%#{sanitize_sql_like(search)}%"]) #検索とcontentの部分一致を表示。
    else
      Micropost.all 
    end
  end
  
  private
  
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
