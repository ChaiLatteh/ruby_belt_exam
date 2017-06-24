class Lender < ActiveRecord::Base
  has_many :histories
  has_many :borrowers, through: :histories

  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, :password, :money, presence: true, on:[:create]
  validates :email, uniqueness: {case_sensitive: false}, format: {with:EMAIL_REGEX}

end
