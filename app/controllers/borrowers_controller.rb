class BorrowersController < ApplicationController

  before_action :require_login_borrower
  before_action :require_correct_borrower

  def index
    @borrower = Borrower.find(session[:borrower_id])
  end
end
