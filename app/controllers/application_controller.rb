class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login_lender
    unless session[:lender_id]
      flash[:errors] = "You must be logged in to view this page."
      redirect_to '/login'
    end
  end

  def require_login_borrower
    unless session[:borrower_id]
      flash[:errors] = "You must be logged in to view this page."
      redirect_to '/login'
    end
  end

  def require_correct_borrower
    @borrower = Borrower.find(params[:borrower_id])
    @current = Borrower.find(session[:borrower_id])
    unless @borrower==@current
      redirect_to "/borrower/#{@current.id}"
    end
  end


  def require_correct_lender
    @lender = Lender.find(params[:lender_id])
    @current = Lender.find(session[:lender_id])
    unless @lender==@current
      redirect_to "/lender/#{@current.id}"
    end
  end

  # helper_method :require_login_lender, :require_login_borrower

end
