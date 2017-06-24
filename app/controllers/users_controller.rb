class UsersController < ApplicationController
  def register
  end

  def register_lender
    @lender = Lender.new(lender_params)
    if @lender.save
      flash[:notices] = "Registered as a LENDER!"
      redirect_to '/login'
    else
      flash[:errors] = @lender.errors.full_messages
      redirect_to :back
    end
  end

  def register_borrower
    @borrower = Borrower.new(borrower_params)
    if @borrower.save
      flash[:notices] = "Registered as a BORROWER!"
      redirect_to '/login'
    else
      flash[:errors] = @borrower.errors.full_messages
      redirect_to :back
    end
  end

  def login
  end

  def login_lender
    @lender = Lender.find_by(email: params[:lender][:email])
    if @lender
      if @lender.authenticate(params[:lender][:password])
        session[:lender_id] = @lender.id
        redirect_to "/lender/#{@lender.id}"
      else
        flash[:errors] = "Password is incorrect"
        redirect_to :back
      end
    else
      flash[:errors] = "Email not found. Please try again."
      redirect_to :back
    end
  end

  def login_borrower
    @borrower = Borrower.find_by(email: params[:borrower][:email])
    if @borrower
      if @borrower.authenticate(params[:borrower][:password])
        session[:borrower_id] = @borrower.id
        redirect_to "/borrower/#{@borrower.id}"
      else
        flash[:errors] = "Password is incorrect"
        redirect_to :back
      end
    else
      flash[:errors] = "Email not found. Please try again."
      redirect_to :back
    end

  end

  def logout
    reset_session
    redirect_to '/login'
  end





  private
    def lender_params
      params.require(:lender).permit(:first_name, :last_name, :email, :password, :password_confirmation, :money)
    end

    def borrower_params
      params.require(:borrower).permit(:first_name, :last_name, :email, :password, :password_confirmation, :purpose, :description, :money)
    end


end
