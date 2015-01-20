class Ingredient < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  belongs_to :recipe
  validates_presence_of :title
end
