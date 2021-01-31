class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :how_to_makes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :fovarites, source: :user
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  accepts_nested_attributes_for :how_to_makes, allow_destroy: true
  
  mount_uploader :image, ImageUploader
  mount_uploader :process_image, ProcessImageUploader
  
  def self.search(search)
    if search
      Recipe.where('title LIKE (?)', "%#{search}%")
    else
      Recipe.all
    end
  end
end