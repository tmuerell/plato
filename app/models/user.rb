class User < ApplicationRecord
  include Gravtastic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  before_create :set_default_user_groups

  has_many :ticket_user_relationships

  if ENV['PLATO_OPENID_CONNECT_ENABLE'] == 'true'
    devise :omniauthable, omniauth_providers: [ENV['PLATO_OPENID_CONNECT_NAME'].to_sym]

    def self.from_omniauth(auth)
      user = find_by(provider: auth.provider, uid: auth.uid)

      user ||= find_or_create_by(email: auth.info.email) do |new_user|
        new_user.uid = auth.uid
        new_user.provider = auth.provider
        new_user.password = Devise.friendly_token[0, 20]
      end

      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      user.roles = auth.extra.raw_info.resource_access.plato.roles
      user.save!
      user
    end
  end

  belongs_to :current_project, class_name: 'Project', optional: true
  has_many :user_project_roles
  serialize :roles, JSON
  gravtastic

  def name
    if firstname.present? || lastname.present?
      "#{firstname} #{lastname}"
    else
      email
    end
  end

  def is_admin?
    (self.roles || []).include?("Admin")
  end

  private

  def set_default_user_groups
    unless self.roles.present?
      self.roles = ["User"]
    end
  end
end
