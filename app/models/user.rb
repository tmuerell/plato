class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  if ENV['PLATO_OPENID_CONNECT_ENABLE'] == 'true'
    devise :omniauthable, omniauth_providers: [ENV['PLATO_OPENID_CONNECT_NAME'].to_sym]

    def self.from_omniauth(auth)
      user = find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      user.roles = auth.extra.raw_info.resource_access.plato.roles
      user.save!
      user
    end
  end

  belongs_to :current_project, class_name: 'Project', optional: true
  serialize :roles, JSON

  def name
    if firstname.present? || lastname.present?
      "#{firstname} #{lastname}"
    else
      email
    end
  end
end
