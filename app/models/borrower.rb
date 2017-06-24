class Borrower < ActiveRecord::Base
  # has_many :money_borrowed, through: :histories, source: :lender
  has_many :histories
  has_many :lenders, through: :histories


  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, :password, :money, :purpose, :description, presence:true, on:[:create]
  validates :email, uniqueness: {case_sensitive: false}, format: {with:EMAIL_REGEX}

end
