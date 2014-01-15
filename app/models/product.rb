class Product < ActiveRecord::Base
  has_many :images

  validates :title, presence: true

  accepts_nested_attributes_for :images
end
