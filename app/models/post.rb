class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 100}
  validates :summary, presence: true, length: {maximum: 1000}
  validates :review, presence: true, length: {maximum: 1000}
  validates :note, length: {maximum: 1000}
end
