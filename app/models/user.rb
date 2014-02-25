class User < ActiveRecord::Base
  has_many :authorizations, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  #validates :first_name, :last_name, presence: true

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    if authorization
      user = authorization.user
    else
      email = auth.info[:email]
      user = User.where(email: email).first
      if user
        user.create_authorization(auth)
      else
        if email.present?
          password = Devise.friendly_token[0, 20]
          user = User.create(email: email, password: password, password_confirmation: password)
          user.create_authorization(auth)
        end
      end
    end
    user
  end

  def create_authorization(auth)
    self.authorizations.create!(provider: auth.provider, uid: auth.uid)
  end

  def add_authorization(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    if authorization
      authorization.user == self
    else
      create_authorization(auth)
      true
    end
  end
end
