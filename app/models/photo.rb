class Photo < ActiveRecord::Base
  PRICE = 1000
  
  belongs_to :user

  mount_uploader :upload, UploadUploader
  
  scoped_search on: [:title, :description]
  
end
