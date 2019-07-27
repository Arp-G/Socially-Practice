class Post < ApplicationRecord

	validates :title,:content, presence: :true

	validates :content, length: { minimum: 10 }

	belongs_to :user

	has_many :comments

end
