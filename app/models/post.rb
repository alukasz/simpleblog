class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :teaser, presence: true
  validates :text, presence: true
end
