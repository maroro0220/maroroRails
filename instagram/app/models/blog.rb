class Blog < ActiveRecord::Base
  validates :title, presence: true
  #title이 존재해야만 저장되는거?
  validates :content, presence: true
  
end
