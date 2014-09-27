class Job < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_one :category

  validates :owner_id, :title, :description, :category, :deadline,  presence: true
end