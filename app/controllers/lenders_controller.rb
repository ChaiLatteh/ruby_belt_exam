class LendersController < ApplicationController

  before_action :require_login_lender
  before_action :require_correct_lender

  def index
    @lender = Lender.find(session[:lender_id])
    @borrowers = Borrower.all
  end

end
