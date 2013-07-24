class Post < ActiveRecord::Base
  belongs_to :users
  validates :title, :presence => true, :length => {:maximum => 30}
  validates :body, :presence => true, :length => {:maximum => 500}

  scope :drafts, where("draft = ?", true)
  scope :published, where("draft = ?", false)
end
