class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable, :omniauthable
  has_many :address_books
  has_many :requests
  enum role: [:admin, :user]

  def role? role
    role.include? role.to_s
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.save
      end
    end
  end
end
