class Post < ActiveRecord::Base
  mount_uploader :postimage, PostImageUploader
  #mount_uploader는 belongs_to처럼 정해져있는거

end
