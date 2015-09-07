class CompletedDaysController < ApplicationController
  
  def index
    @completed_days = CompletedDay.all
  end

  def new
    @completed_day = CompletedDay.new
  end

  def create
    @completed_day = CompletedDay.new(completed_day_params)
    # @completed_days = CompletedDay.all
    if @completed_day.save
      redirect_to action: "index"
    else
      render 'new'
    end
  end

  def destroy
    @completed_day = CompletedDay.find(params[:id])
    @completed_day.destroy
   
    redirect_to action: "index"
  end

  private
    def completed_day_params
      params.require(:completed_day).permit(:date)
    end

end
