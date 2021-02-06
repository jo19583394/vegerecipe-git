class HowToMake < ApplicationRecord
  belongs_to :recipe
  
  mount_uploaders :process_image, ProcessImageUploader
end
