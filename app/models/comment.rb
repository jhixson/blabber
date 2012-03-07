class Comment < ActiveRecord::Base
  belongs_to :event
  acts_as_voteable
end
