class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,:dob,:gender,presence: :true

  validate :dob_cannot_be_in_the_future

  has_many :posts

  has_many :comments

  private

  def dob_cannot_be_in_the_future
  	if dob and dob>Date.today
  		errors.add("dob","cannot be in the future")
  	end
  end

end
