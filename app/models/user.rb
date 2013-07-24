class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  # Setup accessible (or protected) attributes for your model

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :roles
  has_many :permissions, :through =>  :roles
  has_many :posts, :foreign_key => "owner_id"

  accepts_nested_attributes_for :roles

  def has_permission? perm
    self.permissions.pluck(:name).include? perm
  end

  def has_role? role
    self.roles.include? role
  end

  def is_admin?
    self.has_permission? "application_admin"
  end

  def can_publish?
    self.has_permission? "can_publish"
  end
end
