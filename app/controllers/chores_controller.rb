class ChoresController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @chores = Chore.all
  end

  def show
    @chore = Chore.find(params[:id])
  end

  def new
    @chore = Chore.new
  end

  def create
    @chore = Chore.new(params[:chore].permit(:title, :frequency))
    if @chore.save
      redirect_to chores_path
    else
      render "chores/new"
    end
  end

  def chore_params
    params.require(:chore).permit(:title, :frequency)
  end
end