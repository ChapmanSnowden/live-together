class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @payments = Payment.where("lender_id = ? or borrower_id = ?", current_user.id, current_user.id )
    @settlements = current_user.settlements
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def new
    @payment = current_user.payments.new
  end

  def create
    @payment = current_user.payments.create(payment_params)
    if @payment.persisted?
      flash[:notice] = "Payment registered succesfully."
      redirect_to payments_path
    else
      p @payment.errors.full_messages
      flash[:error] = "Error while creating payment."
      render new_payment_path
    end
  end


  def destroy
  end

  private

  def payment_params
    params.require(:payment).permit(:amount_cents, :date, :description, :method, :lender_id)
  end
end