class HistoriesController < ApplicationController

  before_action :require_login_lender
  before_action :require_correct_lender

  def lend
    @lender = Lender.find(session[:lender_id])
    @borrower = Borrower.find(params[:borrower_id])
    @history = History.new(history_params)
    if @history.amount <= 0
      flash[:errors]="Invalid amount."
      redirect_to :back
    elsif @lender.money<=0
      flash[:errors]="You have no money left in your balance."
      redirect_to :back
    elsif @lender.money<@history.amount
      flash[:errors]="You don't have enough amount"
      redirect_to :back
    else
      @lender.money>@history.amount
      @lender.update(money:@lender.money-@history.amount)
      @borrower.update(raised:@borrower.raised+@history.amount)
      @history.save
      flash[:notices]="Successful!"
      redirect_to :back
    end
  end

  private
    def history_params
      params.require(:history).permit(:amount).merge(lender: Lender.find(session[:lender_id]), borrower: @borrower)
    end

end
