class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :user

  validates :title, presence: true
  validates :teaser, presence: true
  validates :text, presence: true

  def slug_candidates
    [
      :title,
      [:title, 2],
      [:title, 3],
      [:title, 4],
      [:title, 5]
    ]
  end
end
