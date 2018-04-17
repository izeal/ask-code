require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A\w+\z/

  before_save :encrypt_password
  before_save { login.downcase! } # todo
  before_save { email.downcase! } # todo

  has_many :posts

  validates :name, presence: true
  validates :login,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 40 },
            format: { with: VALID_USERNAME_REGEX }

  validates :email,
            presence: true,
            uniqueness: {case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  # on: :create???
  validates :password, presence: true, confirmation: true,
            length: { in: 6..15 }

  attr_accessor :password

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user

    hashed_password = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
            password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
    )

    return user if user.password_hash == hashed_password

    nil
  end
end

