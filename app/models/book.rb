class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy

  scope :latest, -> {order(created_at: :desc)}
  scope :rating, -> {order(rate: :desc)}

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200}

  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search_word)
    Book.where(['category LIKE ?', "#{search_word}"])
  end

end
