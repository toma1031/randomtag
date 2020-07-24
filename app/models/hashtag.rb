class Hashtag < ApplicationRecord
    belongs_to :user 
    
    validates :content, presence: true, length: { maximum: 30 }, uniqueness: { scope: :user_id }
end