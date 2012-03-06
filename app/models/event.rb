class Event < ActiveRecord::Base
  belongs_to :subcategory
  has_many :comments, :through => :ratings
  has_many :ratings
  acts_as_voteable
end
