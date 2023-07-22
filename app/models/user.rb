class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  if ENV['PLATO_OPENID_CONNECT_ENABLE'] == 'true'
    devise :omniauthable, omniauth_providers: [ ENV['PLATO_OPENID_CONNECT_NAME'].to_sym ]

    def self.from_omniauth(auth)
      find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.email = auth.info.email
        user.firstname = auth.info.first_name
        user.lastname = auth.info.last_name
        user.password = Devise.friendly_token[0, 20]
        #Roles here: auth.extra.raw_info.resource_access.plato.roles
      end
    end
  end
end
