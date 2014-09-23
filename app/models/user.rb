class User < ActiveRecord::Base
  has_many :skills
  has_and_belongs_to_many :jobs
  has_many :permissions, :through =>  :roles
  has_one :resume, :foreign_key => :owner_id
  has_and_belongs_to_many :roles

  accepts_nested_attributes_for :roles
  accepts_nested_attributes_for :skills

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  # Setup accessible (or protected) attributes for your model

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
            :format =>     { with: VALID_EMAIL_REGEX },
            :uniqueness => { case_sensitive: false }
  VALID_PHONE_REGEX = /\A\d{3}\d{3}\d{4}\z/
    validates :phone,
              :presence => true,
              :format =>     { with: VALID_PHONE_REGEX }

  scope :get_all_employers, lambda{Role.find_by(:name => "employer").users.pluck(:name)}

  def has_permission? perm
    self.permissions.pluck(:name).include? perm
  end

  def has_role? role
    self.roles.include? role
  end

  def is_admin?
    self.has_permission? "application_admin"
  end

  def can_post?
    self.has_permission? "can_post"
  end
end
