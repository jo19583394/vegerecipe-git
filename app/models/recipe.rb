class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :how_to_makes, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  accepts_nested_attributes_for :how_to_makes, allow_destroy: true
  
  mount_uploader :image, ImageUploader
end