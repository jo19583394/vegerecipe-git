class Recipe < ApplicationRecord
  validates :title, presence: true, length: {maximum: 20}
  validates :image, presence: true
  
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :how_to_makes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  accepts_nested_attributes_for :how_to_makes, allow_destroy: true
  
  mount_uploader :image, ImageUploader
  
  
  def self.search(search)
    if search
      Recipe.where('title LIKE (?)', "%#{search}%")
    else
      Recipe.all
    end
  end
end