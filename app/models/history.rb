class History < ActiveRecord::Base
  belongs_to :lender
  belongs_to :borrower

  validates :amount, :lender, :borrower, presence: true
end
