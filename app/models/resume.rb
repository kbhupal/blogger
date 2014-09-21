class Resume < ActiveRecord::Base
  belongs_to :jobseekers
  validates :title, :presence => true, :length => {:maximum => 128}
  validates :body, :presence => true, :length => {:maximum => 10000}
end
